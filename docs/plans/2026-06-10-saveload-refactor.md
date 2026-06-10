# Save/load-correct restructure — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructure the flamethrower mod so module tables/methods live at file scope and `init()` does fresh-start setup only, making the mod correct under Teardown's quicksave/quickload while removing the init-wrapper indirection.

**Architecture:** Teardown re-executes a script's file on quickload (rebuilding all file-scope definitions) but does *not* re-call `init()`, then merges saved `_G` data over the fresh tables. So: define everything at file scope; keep engine re-establishment (tool registration, sound loading, registry-derived config) in idempotent setup methods re-runnable via a single `tick`/`update` guard; keep fresh-start gameplay state (full ammo, fire-limit) in `init()` only so restored state is never clobbered. `Flame` becomes plain data + file-scope functions so restored in-flight flames (which lose metatables) keep working.

**Tech Stack:** Lua 5.1 (Teardown dialect), `#include` preprocessor composition, `make check` harness (luajit `-bl` syntax + lua-language-server `--check`). No unit-test framework — see "Verification model" below.

---

## Verification model

This mod has no runtime test harness; the per-task gate is **`make check`** (run from the workspace root `/home/hypno/Projects/teardown`), which must report **no error-severity findings**. The `.luarc.json` gates only `undefined-global` and `param-type-mismatch` as errors; method-calls-before-definition surface as ungated `undefined-field` warnings and will not fail `check`.

Because the mod is a single `#include`-composed unit, intermediate commits compile and pass `make check` but the mod is only guaranteed to *run* correctly after the final wiring is complete (Task 10). The only end-to-end behavioral check is the manual in-game smoke test in Task 12 — there is no automated substitute, so do not claim runtime correctness from `make check` alone.

**Run check with:**
```
cd /home/hypno/Projects/teardown && make check
```
Expected at every task: exits 0, no lines tagged as errors for `teardown-mod-flamethrower`.

All `git` commands run from `/home/hypno/Projects/teardown/teardown-mod-flamethrower` (current branch `next`).

## Intentional behavior change (review before executing)

Today `init()`-equivalent setup re-runs on quickload (the `initialized` flag is a local that resets), so **ammo resets to full on every quickload**. This plan moves the ammo reset into `init()` only, so **ammo now persists across quickload** — the save/load-correct behavior, consistent with the approved spec's principle "setup must never touch gameplay state." If you instead want ammo to keep resetting on quickload, say so and Task 10 changes (move the `SetFloat` ammo line into `setup()`).

## File structure (end state)

- `mod/main.lua` — lifecycle only: `setup()` (idempotent engine re-establishment), `init()` (setup + fresh gameplay state + fire-limit), `tick()`/`update()` (single setup guard + per-frame dispatch). Include list swaps `input.lua`→`registry.lua`.
- `mod/scripts/lib/registry.lua` — **new** — `Registry.getStringOr` / `Registry.getIntOr` registry-read-with-fallback helpers.
- `mod/scripts/lib/engine.lua` — file-scope `Engine` table + `voxelCenterOffset`.
- `mod/scripts/lib/debug.lua` — file-scope `Debug`; `'home'` inlined (drops the last `Input` use).
- `mod/scripts/lib/input.lua` — **deleted** (dead: only `Input.home()` was used).
- `mod/scripts/managers/soundManager.lua` — file-scope `SoundManager` + `:load()` (sound handles).
- `mod/scripts/knob.lua` — file-scope `Knob` + `:loadConfig()` (registry keybinds via `Registry`).
- `mod/scripts/nozzle.lua` — file-scope `Nozzle` (stateless; no init).
- `mod/scripts/fireStarter.lua` — file-scope `FireStarter`; particle velocities passed as params (no shared upvalues).
- `mod/scripts/flamethrower.lua` — file-scope `Flamethrower` + `:register()` (RegisterTool + enable).
- `mod/scripts/entities/flame.lua` — plain-data `Flame.new` + file-scope `Flame.tick`/`Flame.update`.

---

### Task 1: Add the registry helper

**Files:**
- Create: `mod/scripts/lib/registry.lua`
- Modify: `mod/main.lua` (include list, inside the block comment)

- [ ] **Step 1: Create `mod/scripts/lib/registry.lua`**

```lua
Registry = {}

---Read a string registry key, returning `default` when the key is unset (empty).
---@param key string
---@param default string
---@return string
function Registry.getStringOr(key, default)
    local value = GetString(key)

    if value == '' then
        return default
    end

    return value
end

---Read an integer registry key, returning `default` when the key is unset (0).
---@param key string
---@param default integer
---@return integer
function Registry.getIntOr(key, default)
    local value = GetInt(key)

    if value == 0 then
        return default
    end

    return value
end
```

- [ ] **Step 2: Add the include to `mod/main.lua`**

In the `--[[ ... ]]` include block, change the Libraries section so `registry.lua` is included first:

```lua
--[[
-- Libraries
#include "scripts/lib/registry.lua"
#include "scripts/lib/input.lua"
#include "scripts/lib/engine.lua"
#include "scripts/lib/debug.lua"
```

(Leave the rest of the include block unchanged for now; `input.lua` is removed in Task 11.)

- [ ] **Step 3: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no errors.

- [ ] **Step 4: Commit**

```bash
git add mod/scripts/lib/registry.lua mod/main.lua
git commit -m "feat: add registry read-with-fallback helper"
```

---

### Task 2: Rewrite main.lua lifecycle

Rewrites `main.lua` to the final lifecycle. It calls `SoundManager:load()`, `Knob:loadConfig()`, and `Flamethrower:register()`, which are defined in later tasks — until then they are ungated `undefined-field` warnings, so `make check` stays green. The mod will not fully initialize at runtime until Task 10; that is expected.

**Files:**
- Modify: `mod/main.lua` (everything below the include block)

- [ ] **Step 1: Replace the code below the include block**

Keep the `--[[ ... ]]` include block exactly as left after Task 1. Replace everything from `local initialized = false` to end of file with:

```lua
local engineSetupDone = false

-- Re-establishes engine-side bindings that do not survive serialization.
-- Safe to run on every script (re-)execution, including quickload; must never
-- touch gameplay-progress state (see init()).
local function setup()
    engineSetupDone = true

    -- Uncomment to enable the debug overlay (HOME toggles in-game).
    -- Must be disabled when publishing.
    -- Debug:init()

    SoundManager:load()
    Knob:loadConfig()
    Flamethrower:register()
end

function init()
    setup()

    -- Fresh-start gameplay state: only on a new level, never re-applied on
    -- quickload, so a restored partial-ammo save is preserved.
    SetFloat('game.tool.hypnotox_flamethrower.ammo', Flamethrower.maxAmmo)

    if GetBool('savegame.mod.features.fire_limit.enabled') then
        SetInt("game.fire.maxcount", GetInt('savegame.mod.features.fire_limit.value') or 1000000)
    end
end

function tick()
    if not engineSetupDone then
        setup()
    end

    if GetString("game.player.tool") == "hypnotox_flamethrower" then
        Debug:tick()
        Flamethrower:tick()
    end
end

function update()
    if not engineSetupDone then
        setup()
    end

    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        Flamethrower:update()
    end
end
```

- [ ] **Step 2: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0. (`undefined-field` warnings for `load`/`loadConfig`/`register` are acceptable — they are not gated as errors.)

- [ ] **Step 3: Commit**

```bash
git add mod/main.lua
git commit -m "refactor: rewrite lifecycle with single setup guard"
```

---

### Task 3: Convert engine.lua to file scope

**Files:**
- Modify: `mod/scripts/lib/engine.lua`

- [ ] **Step 1: Replace the whole file**

```lua
-- Holds game engine constants
Engine = {
    voxelSize = 0.05
}

function Engine:voxelCenterOffset()
    return Transform(Vec(Engine.voxelSize * 0.5, Engine.voxelSize * 0.5, -Engine.voxelSize * 0.5))
end
```

- [ ] **Step 2: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no errors.

- [ ] **Step 3: Commit**

```bash
git add mod/scripts/lib/engine.lua
git commit -m "refactor: define Engine at file scope"
```

---

### Task 4: Convert debug.lua to file scope and inline 'home'

**Files:**
- Modify: `mod/scripts/lib/debug.lua`

- [ ] **Step 1: Unwrap the `initDebug()` function**

Remove the `function initDebug()` line at the top and its matching closing `end` at the very bottom of the file, de-indenting the body by one level so the `Debug = {...}` table and every `function Debug:...` / `function Debug.*` definition sits at file scope.

- [ ] **Step 2: Inline the toggle key**

In the `Debug = { ... }` table, change:

```lua
        toggleKey = Input.home()
```

to:

```lua
        toggleKey = 'home'
```

The resulting top of the file must read:

```lua
Debug = {
    enabled = false,
    toggleKey = 'home'
}

local function dumpTransform(transform)
```

(All other `Debug` methods follow at file scope, unchanged.)

- [ ] **Step 3: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no errors. (`Input` is now unreferenced but `input.lua` still defines it — no `undefined-global`.)

- [ ] **Step 4: Commit**

```bash
git add mod/scripts/lib/debug.lua
git commit -m "refactor: define Debug at file scope, inline home key"
```

---

### Task 5: Convert soundManager.lua to file scope with :load()

**Files:**
- Modify: `mod/scripts/managers/soundManager.lua`

- [ ] **Step 1: Replace the whole file**

```lua
SoundManager = {
    soundVolume = 0.5,
    outOfAmmo = false,
    soundFlamethrowerActive = nil,
    soundFlamethrowerStart = nil,
    soundFlamethrowerEnd = nil
}

-- Loads sound handles. Handles are runtime-only and must be reloaded on every
-- script execution, including after a quickload.
function SoundManager:load()
    self.soundFlamethrowerActive = LoadLoop('sound/flamethrower-active.ogg')
    self.soundFlamethrowerStart = LoadSound('sound/flamethrower-start.ogg')
    self.soundFlamethrowerEnd = LoadSound('sound/flamethrower-end.ogg')
end

function SoundManager:tick()
    if InputPressed('usetool') and GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        PlaySound(self.soundFlamethrowerStart, GetPlayerTransform().pos, self.soundVolume)
        PlaySound(self.soundFlamethrowerActive, GetPlayerTransform().pos, self.soundVolume)
    end

    if InputReleased('usetool') and GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        PlaySound(self.soundFlamethrowerEnd, GetPlayerTransform().pos, self.soundVolume)
    end

    if InputDown('usetool') and GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        PlayLoop(self.soundFlamethrowerActive, GetPlayerTransform().pos, self.soundVolume)
    end

    if not self.outOfAmmo and GetInt('game.tool.hypnotox_flamethrower.ammo') == 0 then
        PlaySound(self.soundFlamethrowerEnd, GetPlayerTransform().pos, self.soundVolume)
        self.outOfAmmo = true
    end
end
```

- [ ] **Step 2: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no errors. (`SoundManager:load()` in main.lua now resolves.)

- [ ] **Step 3: Commit**

```bash
git add mod/scripts/managers/soundManager.lua
git commit -m "refactor: define SoundManager at file scope, load sounds in :load()"
```

---

### Task 6: Convert knob.lua to file scope with :loadConfig()

`:loadConfig()` reads the keybinds from the registry (which persists), so re-running it on quickload is harmless. It deliberately does NOT touch `flameVelocity` — that file-scope default is overwritten by the saved value via the `_G` merge, so the player's chosen velocity survives quickload.

**Files:**
- Modify: `mod/scripts/knob.lua`

- [ ] **Step 1: Replace the whole file**

```lua
Knob = {
    flameVelocity = 15,
    flameVelocityMin = 5,
    flameVelocityMax = 25,
    changePerSecond = 10,
    keybinds = {
        decrease = 'leftarrow',
        increase = 'rightarrow'
    },
}

-- Reads keybinds from the registry, falling back to defaults. Does not reset
-- flameVelocity: the saved value is restored over the file-scope default.
function Knob:loadConfig()
    self.keybinds.decrease = Registry.getStringOr('savegame.mod.features.nozzle.keybinds.decrease', 'leftarrow')
    self.keybinds.increase = Registry.getStringOr('savegame.mod.features.nozzle.keybinds.increase', 'rightarrow')
end

function Knob:tick()
    local knobShape = self:getShape()

    if InputDown('usetool') and GetBool("game.player.canusetool") then
        SetShapeEmissiveScale(knobShape, 0.25)
    else
        SetShapeEmissiveScale(knobShape, 0)
    end

    if InputDown(self.keybinds.decrease) and not InputDown(self.keybinds.increase) and self.flameVelocity >= self.flameVelocityMin then
        local change = self.changePerSecond * GetTimeStep()

        self.flameVelocity = self.flameVelocity - change
        self:rotateKnob(change)
    end

    if InputDown(self.keybinds.increase) and not InputDown(self.keybinds.decrease) and self.flameVelocity <= self.flameVelocityMax then
        local change = self.changePerSecond * GetTimeStep()

        self.flameVelocity = self.flameVelocity + change
        self:rotateKnob(-change)
    end
end

function Knob:rotateKnob(angle)
    local shape = self:getShape()
    local axisTransform = Transform(Vec(Engine.voxelSize * 0.5, Engine.voxelSize * 6.5, 0))
    local shapeTransform = TransformToLocalTransform(axisTransform, GetShapeLocalTransform(shape))

    axisTransform.rot = QuatEuler(0, 0, angle)
    shapeTransform = TransformToParentTransform(axisTransform, shapeTransform)

    SetShapeLocalTransform(
        shape,
        shapeTransform
    )
end

function Knob:getShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[2]
end
```

- [ ] **Step 2: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no errors.

- [ ] **Step 3: Commit**

```bash
git add mod/scripts/knob.lua
git commit -m "refactor: define Knob at file scope, read keybinds in :loadConfig()"
```

---

### Task 7: Convert fireStarter.lua to file scope and fix shared upvalues

The current code stashes the two particle velocities in file-local upvalues set inside `spawnParticles` and read by `spawnAtPosition`. Pass them as parameters instead.

**Files:**
- Modify: `mod/scripts/fireStarter.lua`

- [ ] **Step 1: Replace the whole file**

```lua
FireStarter = {}

local function spawnAtPosition(pos, lifetime, velocityHigh, velocityLow)
    SpawnParticle(pos, velocityHigh, lifetime)
    SpawnParticle(pos, velocityLow, lifetime * 1.7)
end

function FireStarter:getShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[3]
end

function FireStarter:getFireStarterTransform()
    local shape = self:getShape()
    local transform = GetShapeWorldTransform(shape)
    local tool = GetToolBody()
    local toolTransform = GetBodyTransform(tool)

    return TransformToParentTransform(
        Transform(transform.pos, toolTransform.rot),
        Engine:voxelCenterOffset()
    )
end

function FireStarter:spawnParticles()
    local shape = self:getShape()
    local transform = GetShapeWorldTransform(shape)
    local tool = GetToolBody()
    local toolTransform = GetBodyTransform(tool)

    local fireStarter = TransformToParentTransform(
        Transform(transform.pos, toolTransform.rot),
        Engine:voxelCenterOffset()
    )
    local direction

    if InputDown('usetool') then
        direction = TransformToParentVec(fireStarter, Vec(-0.2, 0.4, 0))
    else
        direction = TransformToParentVec(fireStarter, Vec(0, 0.4, 0))
    end

    local velocityHigh = VecAdd(direction, VecScale(direction, 0.2))
    local velocityLow = VecAdd(direction, VecScale(direction, 0.05))

    ParticleReset()
    ParticleSticky(0)
    ParticleCollide(0)
    ParticleGravity(5)
    ParticleDrag(0)
    ParticleTile(5)
    ParticleStretch(10)
    ParticleEmissive(2, 0)
    ParticleAlpha(0.7, 0.1)

    -- white core
    ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
    ParticleRadius(0.03, 0.01)
    spawnAtPosition(fireStarter.pos, 0.1, velocityHigh, velocityLow)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleRadius(0.06, 0.02)
    spawnAtPosition(fireStarter.pos, 0.1, velocityHigh, velocityLow)

    -- orange splatter
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleRadius(0.05, 0.02)
    ParticleAlpha(0.9, 0.01)
    spawnAtPosition(fireStarter.pos, 0.1, velocityHigh, velocityLow)

    PointLight(fireStarter.pos, 1, 0.3, 0.1, 0.2)
end
```

- [ ] **Step 2: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no errors.

- [ ] **Step 3: Commit**

```bash
git add mod/scripts/fireStarter.lua
git commit -m "refactor: define FireStarter at file scope, pass particle velocities as params"
```

---

### Task 8: Convert nozzle.lua to file scope

Keep the `Flame:new(...)` call exactly as-is — `Flame` is still metatable-based until Task 10, where this call site is updated atomically with the `Flame` change.

**Files:**
- Modify: `mod/scripts/nozzle.lua`

- [ ] **Step 1: Replace the whole file**

```lua
Nozzle = {}

local function spawnAtPosition(pos, lifetime, flameVelocity)
    SpawnParticle(pos, flameVelocity, lifetime)
    SpawnParticle(pos, flameVelocity, lifetime * 0.8)
    SpawnParticle(pos, flameVelocity, lifetime * 0.7)
end

local function spawnParticles(flameVelocity, lifetime)
    local nozzle = Nozzle:getNozzleTransform()
    local startSize = 0.03
    local endSize = 0.8

    ParticleReset()
    ParticleSticky(0.1, 1, 'easein')
    ParticleCollide(0, 0.001, 'easein')
    ParticleGravity(5, -10)
    ParticleDrag(0)
    ParticleStretch(5)
    ParticleTile(5)

    -- white core
    ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
    ParticleEmissive(2, 0)
    ParticleRadius(startSize, endSize)
    ParticleAlpha(0.8, 0.5)
    spawnAtPosition(nozzle.pos, lifetime, flameVelocity)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleEmissive(6, 3)
    ParticleRadius(startSize * 1.5, endSize * 1.5)
    ParticleAlpha(0.8, 0.5)
    spawnAtPosition(nozzle.pos, lifetime, flameVelocity)

    -- red splatter
    ParticleColor(1, math.random(5, 15) / 100, 0)
    ParticleEmissive(4, 2)
    ParticleRadius(startSize * 1.5, endSize * 1.7)
    ParticleAlpha(0.3, 0.7)
    spawnAtPosition(nozzle.pos, lifetime, flameVelocity)

    -- red cloud
    ParticleColor(1, math.random(40, 50) * 0.01, 0, 1, math.random(20, 40) * 0.01, 0)
    ParticleEmissive(3, 1)
    ParticleRadius(startSize * 1.5, endSize * 2.5)
    ParticleAlpha(0.8, 0.5)
    spawnAtPosition(nozzle.pos, lifetime, flameVelocity)
end

function Nozzle:getFlameVelocity()
    local nozzle = self:getNozzleTransform()
    local direction = TransformToParentVec(nozzle, Vec(0, 0, -1))
    direction = VecAdd(direction, GetPlayerTransform())

    return VecScale(direction, Knob.flameVelocity * 2)
end

function Nozzle:getNozzleShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[4]
end

function Nozzle:getNozzleTransform()
    local shape = self:getNozzleShape()
    local transform = GetShapeWorldTransform(shape)
    local tool = GetToolBody()
    local toolTransform = GetBodyTransform(tool)

    return TransformToParentTransform(
        TransformToParentTransform(
            Transform(transform.pos, toolTransform.rot),
            Engine:voxelCenterOffset()
        ),
        Transform(Vec(0, 0, -0.05))
    )
end

function Nozzle:throwFlames(flameVelocity, lifetime)
    if InputDown('usetool') then
        local nozzle = self:getNozzleTransform()
        local fwd = TransformToParentVec(nozzle, Vec(0, 0, -1))
        local hit, maxDist, normal = QueryRaycast(nozzle.pos, fwd, 100)

        table.insert(Flamethrower.flames, Flame:new(nozzle, VecLength(flameVelocity), lifetime * 0.5, hit, maxDist, normal))
        Flamethrower:ammoTick()
        spawnParticles(flameVelocity, lifetime)
    end
end
```

> Note: `Nozzle:getFlameVelocity()` keeps the existing `VecAdd(direction, GetPlayerTransform())` (vector + transform). This is preserved deliberately per the spec — it is flagged as a latent oddity, out of scope for this behavior-preserving refactor.

- [ ] **Step 2: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no errors.

- [ ] **Step 3: Commit**

```bash
git add mod/scripts/nozzle.lua
git commit -m "refactor: define Nozzle at file scope"
```

---

### Task 9: Convert flamethrower.lua to file scope with :register()

Keep the `self.flames[i]:tick()` / `self.flames[i]:update()` calls as method calls for now — they are updated to `Flame.tick(...)` / `Flame.update(...)` in Task 10 together with the `Flame` change.

**Files:**
- Modify: `mod/scripts/flamethrower.lua`

- [ ] **Step 1: Replace the whole file**

```lua
Flamethrower = {
    maxAmmo = 100,
    ammoPerSecond = 5,
    flames = {}
}

-- Registers the tool and enables it. Idempotent engine-side setup, safe to
-- re-run on quickload. Does not set ammo (that is fresh-start state in init()).
function Flamethrower:register()
    local modelPath = 'MOD/vox/Flamethrower.vox'
    local inventorySlot = Registry.getIntOr('savegame.mod.features.inventory.slot', 6)

    if Debug.enabled then
        modelPath = 'MOD/vox/FlamethrowerDebug.vox'
    end

    Debug:dump(inventorySlot, 'Slot')

    RegisterTool('hypnotox_flamethrower', 'Flamethrower', modelPath, inventorySlot)
    SetBool('game.tool.hypnotox_flamethrower.enabled', true)
end

function Flamethrower:tick()
    SetBool('hud.aimdot', false)
    self:setToolPosition()

    SoundManager:tick()
    Knob:tick()

    for i = 1, #self.flames, 1 do
        self.flames[i]:tick()
    end

    if not GetBool("game.player.canusetool") then
        return
    end

    local fireStarterShape = FireStarter:getShape()

    if GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        SetShapeEmissiveScale(fireStarterShape, 0.5)
        FireStarter:spawnParticles()
    else
        SetShapeEmissiveScale(fireStarterShape, 0)
    end
end

function Flamethrower:update()
    if GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 and InputDown('usetool') then
        local lifetime = 1.3
        local flameVelocity = Nozzle:getFlameVelocity()

        Nozzle:throwFlames(flameVelocity, lifetime)
    end

    for i = #self.flames, 1, -1 do
        self.flames[i]:update()

        if not self.flames[i].isAlive then
            table.remove(self.flames, i)
        end
    end
end

-- Helper methods

function Flamethrower:ammoTick()
    local ammoUsed = self.ammoPerSecond * GetTimeStep()
    local ammoLeft = GetFloat('game.tool.hypnotox_flamethrower.ammo') - ammoUsed

    SetFloat('game.tool.hypnotox_flamethrower.ammo', ammoLeft)
end

function Flamethrower:setToolPosition()
    if InputDown('usetool') and GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 and GetBool("game.player.canusetool") then
        local offset = Transform(Vec(0.3, -0.5, -0.9))
        SetToolTransform(offset, 0.1)
    else
        local offset = Transform(Vec(0.3, -0.5, -0.95))
        SetToolTransform(offset, 0.5)
    end
end
```

- [ ] **Step 2: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no errors. (`Flamethrower:register()` in main.lua now resolves.)

- [ ] **Step 3: Commit**

```bash
git add mod/scripts/flamethrower.lua
git commit -m "refactor: define Flamethrower at file scope, register tool in :register()"
```

---

### Task 10: Convert Flame to plain data and update call sites

This is the save/load-correctness payoff: flames become plain tables, so quickload-restored in-flight flames (which lose metatables) are indistinguishable from live ones. The `Flame` change and its three call sites change in one commit so the runtime stays consistent.

**Files:**
- Modify: `mod/scripts/entities/flame.lua`
- Modify: `mod/scripts/nozzle.lua` (one call site)
- Modify: `mod/scripts/flamethrower.lua` (two call sites)

- [ ] **Step 1: Replace `mod/scripts/entities/flame.lua` entirely**

```lua
Flame = {}

local function randomPoint(transform, r)
    local radius = r * 100
    local offsetLength = math.random(-radius, radius) / 100
    local offsetRotation = QuatEuler(math.random(0, 360), math.random(0, 360), math.random(0, 360))

    return VecAdd(transform.pos, QuatRotateVec(offsetRotation, Vec(0, 0, offsetLength)))
end

---Create a flame as plain data (no metatable) so it survives quickload intact.
---@return table
function Flame.new(nozzle, fwd, lifetime, hit, maxDist, normal)
    return {
        transform = TransformCopy(nozzle),
        fwd = fwd,
        lifetime = lifetime,
        dist = 0,
        hit = hit,
        maxDist = maxDist,
        normal = normal,
        isAlive = true
    }
end

function Flame.tick(flame)
    local size = ((flame.dist * 2) / flame.fwd)
    PointLight(flame.transform.pos, 1, 0.2, 0.01, size)
end

function Flame.update(flame)
    local size = (flame.dist * 1.5) / flame.fwd

    if size < 0 then
        size = 0.05
    end

    local samplePoints = math.ceil(size * 10)

    for _ = 1, samplePoints, 1 do
        local point = randomPoint(flame.transform, size)
        SpawnFire(point)
        Debug:cross(point, 150, 0, 255, 1)
    end

    if flame.lifetime < 0 or flame.dist > flame.maxDist then
        flame.isAlive = false
    end

    local travelledDist = flame.fwd * GetTimeStep()
    flame.transform = TransformToParentTransform(flame.transform, Transform(Vec(0, 0, -travelledDist)))
    flame.dist = flame.dist + travelledDist
    flame.lifetime = flame.lifetime - GetTimeStep()
    flame.fwd = flame.fwd - ((flame.fwd * 0.2) * GetTimeStep())
end
```

- [ ] **Step 2: Update the call site in `mod/scripts/nozzle.lua`**

In `Nozzle:throwFlames`, change:

```lua
        table.insert(Flamethrower.flames, Flame:new(nozzle, VecLength(flameVelocity), lifetime * 0.5, hit, maxDist, normal))
```

to:

```lua
        table.insert(Flamethrower.flames, Flame.new(nozzle, VecLength(flameVelocity), lifetime * 0.5, hit, maxDist, normal))
```

- [ ] **Step 3: Update the two call sites in `mod/scripts/flamethrower.lua`**

In `Flamethrower:tick`, change:

```lua
    for i = 1, #self.flames, 1 do
        self.flames[i]:tick()
    end
```

to:

```lua
    for i = 1, #self.flames, 1 do
        Flame.tick(self.flames[i])
    end
```

In `Flamethrower:update`, change:

```lua
    for i = #self.flames, 1, -1 do
        self.flames[i]:update()

        if not self.flames[i].isAlive then
            table.remove(self.flames, i)
        end
    end
```

to:

```lua
    for i = #self.flames, 1, -1 do
        Flame.update(self.flames[i])

        if not self.flames[i].isAlive then
            table.remove(self.flames, i)
        end
    end
```

- [ ] **Step 4: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no errors.

- [ ] **Step 5: Commit**

```bash
git add mod/scripts/entities/flame.lua mod/scripts/nozzle.lua mod/scripts/flamethrower.lua
git commit -m "refactor: model Flame as plain data so it survives quickload"
```

---

### Task 11: Delete the dead input library

`Input` has no remaining references after Task 4. Delete the file and its include together so the `#include` resolution check stays clean.

**Files:**
- Delete: `mod/scripts/lib/input.lua`
- Modify: `mod/main.lua` (remove the include line)

- [ ] **Step 1: Remove the include line from `mod/main.lua`**

Delete this line from the `--[[ ... ]]` include block:

```lua
#include "scripts/lib/input.lua"
```

- [ ] **Step 2: Delete the file**

```bash
git rm mod/scripts/lib/input.lua
```

- [ ] **Step 3: Run check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no errors, no unresolved-include findings.

- [ ] **Step 4: Commit**

```bash
git add mod/main.lua
git commit -m "chore: remove unused Input key-name library"
```

---

### Task 12: Final verification

**Files:** none (verification only)

- [ ] **Step 1: Full static check**

Run: `cd /home/hypno/Projects/teardown && make check`
Expected: exits 0, no error-severity findings for `teardown-mod-flamethrower`.

- [ ] **Step 2: In-game smoke test**

The mod is already symlinked into the Teardown mods folder. Launch Teardown, enable the Gasoline Flamethrower, load a sandbox map, and confirm:

- Tool registers in the expected inventory slot; equips with the correct model.
- Holding `usetool` sprays flames, spawns fire, drains ammo, plays start/loop/end sounds, and lights the fire-starter/knob emissive.
- Left/Right arrows adjust nozzle velocity and visibly rotate the knob.
- Settings menu (`options.lua`) still reads/writes keybinds, inventory slot, and fire limit.
- **Save/load:** start spraying, **quicksave (F5) mid-flame**, then **quickload (F9)**. Confirm: no Lua error, in-flight flames continue burning, the tool still works, the nozzle velocity you set is preserved, and ammo reflects the saved (partial) amount rather than resetting to full.

- [ ] **Step 3: Remove the throwaway probe (optional cleanup)**

The save/load probe in the workspace root and its symlink are no longer needed:

```bash
rm /mnt/biggy/SteamLibrary/steamapps/compatdata/1167630/pfx/drive_c/users/steamuser/Documents/Teardown/mods/saveload-probe
rm -rf /home/hypno/Projects/teardown/saveload-probe
```

- [ ] **Step 4: Update the submodule pointer in the workspace**

After the branch work is integrated per your usual flow, update the pinned submodule commit in the workspace repo (`/home/hypno/Projects/teardown`).
