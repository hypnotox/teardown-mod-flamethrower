#include "scripts/flamethrower.lua"

function init()
    Flamethrower:init()
end

function tick(dt)
    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        Flamethrower:tick(dt)
    end
end

function update()
    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        Flamethrower:update()
    end
end