-- Presentation: all local rendering, input, and audio (future multiplayer
-- `client`). Reads input and the read-only State, drives the visual sub-modules,
-- and relays player intent to Simulation (the future ServerCall boundary). No
-- world mutation. See ../../../docs/reference/multiplayer.md.
Presentation = {}

function Presentation:setup()
    SoundManager:load()
    Knob:loadConfig()
end

function Presentation:init()
    -- Re-capture the knob's model default fresh each session (init does not run
    -- on quickload), self-healing a stale stored value after a .vox change.
    Knob:clearStoredDefault()
end

function Presentation:tick()
    Tool:tick()
    SoundManager:tick()
    Knob:tick()
    FlameLight:tick()

    if not GetBool("game.player.canusetool") then
        return
    end

    FireStarter:tick()
end

function Presentation:update()
    -- This guard suppresses the local jet FX when there is no ammo or no input;
    -- Simulation:fire independently re-checks ammo as the authority, so the two
    -- checks are not redundant -- this one gates presentation, that one gates state.
    if State:hasAmmo() and InputDown('usetool') then
        local params = Nozzle:buildFiringParams()
        Nozzle:spawnJetParticles(params)
        Simulation:fire(params)
    end
end
