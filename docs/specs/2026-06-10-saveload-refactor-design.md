# Save/load-correct restructure

2026-06-10. Approved design for refactoring the mod's initialization and module
structure so it is correct under Teardown's quicksave/quickload, with the
init-wrapper indirection removed.

## Background: confirmed engine semantics

Verified in-game with a probe mod (mutate state → quicksave → quickload,
observing registry counters, globals, upvalues, and metatable calls):

1. Quickload **re-executes the script file** from scratch — file-scope code
   runs again; locals/upvalues are rebuilt fresh.
2. **`init()` is not called again** on quickload.
3. After re-execution, saved global data is **restored on top, merged per
   key**: data values come back as saved, while functions defined by the
   fresh execution stay intact.
4. Functions and metatables never serialize. Objects created *at runtime*
   (e.g. live `Flame` instances) are restored as plain data tables — method
   calls on them crash.
5. The registry is snapshot/restored too.

Untested: loading a save after a full game restart (whether `init()` runs
then, whether `LoadSound` handles stay valid). The design covers this path
defensively.

## Problems with the current code

- Every module wraps its table and all methods in an `initX()` function run
  at runtime. These are exactly the values that do not survive serialization,
  forcing the triple lazy-init guard in `main.lua` (`init`, `tick`, `update`).
- The force-rebuild discards restored state (e.g. `Knob.flameVelocity`).
- `Flame` instances carry metatables; a mid-spray quicksave restores them
  method-less. (Today the force-rebuild masks this by wiping the list.)
- `lib/input.lua` is ~270 lines of dead code (only `Input.home()` is used).

## Design

### 1. Module pattern (every file)

Each script defines its module table and all methods at **file scope**; the
`initX()` wrappers are removed. File scope holds definitions and constant
defaults only. Engine-API-dependent setup (registry reads, `RegisterTool`,
`LoadSound`, fire-limit override) moves into a small per-module
`Module:init()`. Quickload re-execution rebuilds all functions automatically;
the `_G` merge restores mutated data (knob velocity now survives quickload).

### 2. main.lua lifecycle

`init()` runs the per-module inits (`SoundManager:init()`, `Knob:init()`,
`Flamethrower:init()` — which registers the tool — plus the fire-limit
override). One defensive guard replaces today's three:

```lua
local engineSetupDone = false   -- locals reset on every (re-)execution

local function setup()
    engineSetupDone = true
    -- per-module init calls
end

function init() setup() end

function tick()
    if not engineSetupDone then setup() end
    ...
end
```

Because locals reset on re-execution and `init()` does not re-run on
quickload, `tick()` re-runs the idempotent engine setup exactly once per
script execution. This also covers the untested load-after-restart path
(stale `LoadSound` handles). Setup must never touch gameplay state, so
restored data is never clobbered.

### 3. Flame as plain data

`Flame.new(...)` returns a plain table (no metatable). Behavior lives in
file-scope functions `Flame.tick(flame)` / `Flame.update(flame)`;
`randomPoint` becomes a local helper. `Flamethrower.flames` remains a list of
these tables. A mid-spray quicksave/quickload restores in-flight flames as
data and they keep working — nothing to detect or repair.

### 4. Cleanups riding along

- Delete `lib/input.lua`; inline `'home'` in `lib/debug.lua`.
- Fix `fireStarter.lua`'s shared-upvalue particle velocities (pass as
  parameters).
- One registry-read-with-fallback helper (new `lib/registry.lua`, used by
  `Knob` and `Flamethrower`) to dedupe keybind/slot defaults.
- Debug overlay keeps its comment-toggle mechanism, defined at file scope.

### 5. Out of scope (flagged, not changed)

`Nozzle:getFlameVelocity()` does `VecAdd(direction, GetPlayerTransform())` —
adds a transform to a vector. Looks like a latent bug that produces the
current (working) feel; behavior-preserving refactor leaves it alone.
`options.lua` is untouched.

## Verification

- `make check` from the workspace root (luajit syntax + LuaLS error gating)
  passes.
- In-game smoke test via the existing mods-folder symlink: tool registers,
  spraying/ammo/knob/sounds work; spray, quicksave mid-flame, quickload — no
  crash, flames continue, knob setting survives.
