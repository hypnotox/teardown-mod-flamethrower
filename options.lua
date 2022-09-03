---@class Options
---@field valueToSet string?
---@field inputBuffer number|string|nil
Options = {
    valueToSet = nil,
    inputBuffer = nil,
}

function init()
    local isInitialized = GetBool('savegame.mod.general.is_initialized')

    if not isInitialized then
        SetBool('savegame.mod.features.fire_limit.enabled', true)
        SetInt('savegame.mod.features.fire_limit.value', 1000000)
        SetString('savegame.mod.features.nozzle.keybinds.decrease', 'leftarrow')
        SetString('savegame.mod.features.nozzle.keybinds.increase', 'rightarrow')
        SetBool('savegame.mod.features.debug.enabled', false)

        SetBool('savegame.mod.general.is_initialized', true)
    end
end

function draw()
    UiTranslate(UiCenter(), 50)
    UiAlign('center middle')
    UiFont('regular.ttf', 24)

    --Title
    UiPush()
    UiFont('bold.ttf', 48)
    UiText('Flamethrower mod options')
    UiPop()
    UiTranslate(0, 100)

    -- Subtitle nozzle
    Options:subtitle('Nozzle adjustment')
    Options:keybind('Decrease nozzle velocity', 'savegame.mod.features.nozzle.keybinds.decrease')
    Options:keybind('Increase nozzle velocity', 'savegame.mod.features.nozzle.keybinds.increase')

    -- Subtitle fire limit
    Options:subtitle('Fire limit')
    Options:toggle('Enable unlimited fire', 'savegame.mod.features.fire_limit.enabled')

    -- Subtitle debug
    Options:subtitle('Debug')
    Options:toggle('Toggle debug mode', 'savegame.mod.features.debug.enabled', false)

    UiTranslate(0, 100)
    if UiTextButton('Close', 200, 40) then
        Menu()
    end
end

function Options:title(title)
    UiPush()
    UiFont('bold.ttf', 48)
    UiText(title)
    UiPop()
    UiTranslate(0, 100)
end

function Options:subtitle(title)
    UiPush()
    UiFont('bold.ttf', 36)
    UiText(title)
    UiPop()
    UiTranslate(0, 100)
end

function Options:keybind(title, key, default)
    UiPush()
    UiFont('regular.ttf', 26)

    UiPush()
    UiTranslate(-200, 0)
    UiText(title)
    UiPop()

    UiPush()
    UiTranslate(200, 0)
    local keybind = GetString(key)

    if keybind == '' then
        keybind = default
    end

    if keybind and keybind ~= nil then
        UiPush()
        UiColor(0.5, 1, 0.5, 0.2)
        UiImageBox('ui/common/box-solid-6.png', 200, 40, 6, 6)
        UiPop()
    end

    if self.keybindToSet == key then
        UiButtonImageBox('ui/common/box-outline-6.png', 6, 6)
    end

    if UiTextButton(keybind or 'not bound', 200, 40) then
        self.keybindToSet = key
    end
    UiPop()

    UiPop()
    UiTranslate(0, 100)

    local lastPressedKey = InputLastPressedKey()
    if self.keybindToSet ~= nil and lastPressedKey ~= '' then
        SetString(self.keybindToSet, lastPressedKey)
        self.keybindToSet = nil
    end
end

function Options:toggle(title, key, default)
    default = default or false
    UiPush()

    UiPush()
    UiTranslate(-200, 0)
    UiText(title)
    UiPop()

    UiPush()
    UiTranslate(200, 0)
    UiButtonImageBox('ui/common/box-outline-6.png', 6, 6)
    local label = 'Off'

    if GetBool(key) or default then
        UiPush()
        UiColor(0.5, 1, 0.5, 0.2)
        UiImageBox('ui/common/box-solid-6.png', 80, 40, 6, 6)
        UiPop()
        label = 'On'
    end

    if UiTextButton(label, 80, 40) then
        SetBool(key, not GetBool(key))
    end
    UiPop()

    UiPop()
    UiTranslate(0, 100)
end

function Options:input(title, key)
    UiPush()
    UiFont('regular.ttf', 26)

    UiPush()
    UiTranslate(-200, 0)
    UiText(title)
    UiPop()

    UiPush()
    UiTranslate(200, 0)
    local keybind = GetString(key)

    if keybind and keybind ~= nil then
        UiPush()
        UiColor(0.5, 1, 0.5, 0.2)
        UiImageBox('ui/common/box-solid-6.png', 200, 40, 6, 6)
        UiPop()
    end

    if Options.valueToSet == key then
        UiButtonImageBox('ui/common/box-outline-6.png', 6, 6)
    end

    if UiTextButton(tostring(GetInt(key)), 200, 40) then
        Options.valueToSet = key
    end
    UiPop()

    UiPop()
    UiTranslate(0, 100)

    local lastPressedKey = InputLastPressedKey()
    if Options.valueToSet ~= nil and lastPressedKey ~= '' then
        if lastPressedKey == 'enter' then
            Options.valueToSet = nil
            local inputBuffer = Options.inputBuffer
            SetString(Options.valueToSet, tostring(inputBuffer))
        else
            Options.inputBuffer = Options.inputBuffer .. lastPressedKey
        end
    end
end
