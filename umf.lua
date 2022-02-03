local __RUNLATER = {}
UMF_RUNLATER = function(code)
    __RUNLATER[#__RUNLATER + 1] = code
end
local __UMFLOADED = {
    ["src/util/config.lua"] = true,
    ["src/util/registry.lua"] = true
}
UMF_SOFTREQUIRE = function(name)
    return __UMFLOADED[name]
end
(function()
    local registryloaded = UMF_SOFTREQUIRE "src/util/registry.lua"
    if registryloaded then
        function OptionsKeys(def)
            return util.structured_table("savegame.mod", def)
        end
    end
    OptionsMenu = setmetatable({}, {
        __call = function(self, def)
            def.title_size = def.title_size or 50
            local f = OptionsMenu.Group(def)
            draw = function()
                UiTranslate(UiCenter(), 60)
                UiPush()
                local fw, fh = f()
                UiPop()
                UiTranslate(0, fh + 20)
                UiFont("regular.ttf", 30)
                UiAlign("center top")
                UiButtonImageBox("ui/common/box-outline-6.png", 6, 6)
                if UiTextButton("Close") then
                    Menu()
                end
            end
            return f
        end
    })
    function OptionsMenu.Group(def)
        local elements = {}
        if def.title then
            elements[#elements + 1] = OptionsMenu.Text(def.title, {
                size = def.title_size or 40,
                pad_bottom = def.title_pad or 15,
                align = def.title_align or "center top"
            })
        end
        for i = 1, #def do
            elements[#elements + 1] = def[i]
        end
        local condition = def.condition
        return function()
            if condition and not condition() then
                return 0, 0
            end
            local mw, mh = 0, 0
            for i = 1, #elements do
                UiPush()
                local w, h = elements[i]()
                UiPop()
                UiTranslate(0, h)
                mh = mh + h
                mw = math.max(mw, w)
            end
            return mw, mh
        end
    end
    function OptionsMenu.Text(text, options)
        options = options or {}
        local size = options.size or 30
        local align = options.align or "left top"
        local offset = options.offset or (align:find("left") and -400) or 0
        local font = options.font or "regular.ttf"
        local padt = options.pad_top or 0
        local padb = options.pad_bottom or 5
        local condition = options.condition
        return function()
            if condition and not condition() then
                return 0, 0
            end
            UiTranslate(offset, padt)
            UiFont(font, size)
            UiAlign(align)
            UiWordWrap(800)
            local tw, th = UiText(text)
            return tw, th + padt + padb
        end
    end
    function OptionsMenu.Spacer(space, spacew, condition)
        return function()
            if condition and not condition() then
                return 0, 0
            end
            return spacew or 0, space
        end
    end
    local function getvalue(id, def, func)
        local key = "savegame.mod." .. id
        if HasKey(key) then
            return (func or GetString)(key)
        else
            return def
        end
    end
    local function setvalue(id, val, func)
        local key = "savegame.mod." .. id
        if val ~= nil then
            (func or SetString)(key, val)
        else
            ClearKey(key)
        end
    end
    function OptionsMenu.Keybind(def)
        local text = def.name or def.id
        local size = def.size or 30
        local padt = def.pad_top or 0
        local padb = def.pad_bottom or 5
        local value = string.upper(getvalue(def.id, def.default) or "")
        if value == "" then
            value = "<none>"
        end
        local pressed = false
        local condition = def.condition
        return function()
            if condition and not condition() then
                return 0, 0
            end
            UiTranslate(-4, padt)
            UiFont("regular.ttf", size)
            local fheight = UiFontHeight()
            UiAlign("right top")
            local lw, lh = UiText(text)
            UiTranslate(8, 0)
            UiAlign("left top")
            UiColor(1, 1, 0)
            local tempv = value
            if pressed then
                tempv = "<press a key>"
                local k = InputLastPressedKey()
                if k == "esc" then
                    pressed = false
                elseif k ~= "" then
                    value = string.upper(k)
                    tempv = value
                    setvalue(def.id, k)
                    pressed = false
                end
            end
            local rw, rh = UiGetTextSize(tempv)
            if UiTextButton(tempv) then
                pressed = not pressed
            end
            UiTranslate(rw, 0)
            if value ~= "<none>" then
                UiColor(1, 0, 0)
                if UiTextButton("x") then
                    value = "<none>"
                    setvalue(def.id, "")
                end
                UiTranslate(size * 0.8, 0)
            end
            if getvalue(def.id) then
                UiColor(0.5, 0.8, 1)
                if UiTextButton("Reset") then
                    value = def.default and string.upper(def.default) or "<none>"
                    setvalue(def.id)
                end
            end
            return lw + 8 + rw, fheight + padt + padb
        end
    end
    function OptionsMenu.Slider(def)
        local text = def.name or def.id
        local size = def.size or 30
        local padt = def.pad_top or 0
        local padb = def.pad_bottom or 5
        local min = def.min or 0
        local max = def.max or 100
        local range = max - min
        local value = getvalue(def.id, def.default, GetFloat)
        local format = string.format("%%.%df", math.max(0, math.floor(math.log10(1000 / range))))
        local step = def.step
        local condition = def.condition
        return function()
            if condition and not condition() then
                return 0, 0
            end
            UiTranslate(-4, padt)
            UiFont("regular.ttf", size)
            local fheight = UiFontHeight()
            UiAlign("right top")
            local lw, lh = UiText(text)
            UiTranslate(16, lh / 2)
            UiAlign("left middle")
            UiColor(1, 1, 0.5)
            UiRect(200, 2)
            UiTranslate(-8, 0)
            local prev = value
            value = UiSlider("ui/common/dot.png", "x", (value - min) * 200 / range, 0, 200) * range / 200 + min
            if value ~= prev then
                setvalue(def.id, value, SetFloat)
                if step then
                    value = math.floor(value / step + 0.5) * step
                end
            end
            UiTranslate(216, 0)
            UiText(string.format(format, value))
            return lw + 224, fheight + padt + padb
        end
    end
    function OptionsMenu.Toggle(def)
        local text = def.name or def.id
        local size = def.size or 30
        local padt = def.pad_top or 0
        local padb = def.pad_bottom or 5
        local value = getvalue(def.id, def.default, GetBool)
        local condition = def.condition
        return function()
            if condition and not condition() then
                return 0, 0
            end
            UiTranslate(-4, padt)
            UiFont("regular.ttf", size)
            local fheight = UiFontHeight()
            UiAlign("right top")
            local lw, lh = UiText(text)
            UiTranslate(8, 0)
            UiAlign("left top")
            UiColor(1, 1, 0)
            if UiTextButton(value and "Enabled" or "Disabled") then
                value = not value
                setvalue(def.id, value, SetBool)
            end
            return lw + 100, fheight + padt + padb
        end
    end
end)();
(function()
    local coreloaded = UMF_SOFTREQUIRE "src/core/_index.lua"
    util = util or {}
    do
        local serialize_any, serialize_table
        serialize_table = function(val, bck)
            if bck[val] then
                return "nil"
            end
            bck[val] = true
            local entries = {}
            for k, v in pairs(val) do
                entries[#entries + 1] = string.format("[%s] = %s", serialize_any(k, bck), serialize_any(v, bck))
            end
            return string.format("{%s}", table.concat(entries, ","))
        end
        serialize_any = function(val, bck)
            local vtype = type(val)
            if vtype == "table" then
                return serialize_table(val, bck)
            elseif vtype == "string" then
                return string.format("%q", val)
            elseif vtype == "function" or vtype == "userdata" then
                return string.format("nil ", tostring(val))
            else
                return tostring(val)
            end
        end
        function util.serialize(...)
            local result = {}
            for i = 1, select("#", ...) do
                result[i] = serialize_any(select(i, ...), {})
            end
            return table.concat(result, ",")
        end
    end
    function util.unserialize(dt)
        local fn = loadstring("return " .. dt)
        if fn then
            setfenv(fn, {})
            return fn()
        end
    end
    do
        local function serialize_any(val, bck)
            local vtype = type(val)
            if vtype == "table" then
                if bck[val] then
                    return "{}"
                end
                bck[val] = true
                local len = 0
                for k, v in pairs(val) do
                    len = len + 1
                end
                local rt = {}
                if len == #val then
                    for i = 1, #val do
                        rt[i] = serialize_any(val[i], bck)
                    end
                    return string.format("[%s]", table.concat(rt, ","))
                else
                    for k, v in pairs(val) do
                        if type(k) == "string" or type(k) == "number" then
                            rt[#rt + 1] = string.format("%s: %s", serialize_any(k, bck), serialize_any(v, bck))
                        end
                    end
                    return string.format("{%s}", table.concat(rt, ","))
                end
            elseif vtype == "string" then
                return string.format("%q", val)
            elseif vtype == "function" or vtype == "userdata" or vtype == "nil" then
                return "null"
            else
                return tostring(val)
            end
        end
        function util.serializeJSON(val)
            return serialize_any(val, {})
        end
    end
    function util.shared_buffer(name, max)
        max = max or 64
        return {
            _pos_name = name .. ".position",
            _list_name = name .. ".list.",
            push = function(self, text)
                local cpos = GetInt(self._pos_name)
                SetString(self._list_name .. (cpos % max), text)
                SetInt(self._pos_name, cpos + 1)
            end,
            len = function(self)
                return math.min(GetInt(self._pos_name), max)
            end,
            pos = function(self)
                return GetInt(self._pos_name)
            end,
            get = function(self, index)
                local pos = GetInt(self._pos_name)
                local len = math.min(pos, max)
                if index >= len then
                    return
                end
                return GetString(self._list_name .. (pos + index - len) % max)
            end,
            get_g = function(self, index)
                return GetString(self._list_name .. (index % max))
            end,
            clear = function(self)
                SetInt(self._pos_name, 0)
                ClearKey(self._list_name:sub(1, -2))
            end
        }
    end
    if coreloaded then
        function util.shared_channel(name, max, local_realm)
            max = max or 64
            local channel = {
                _buffer = util.shared_buffer(name, max),
                _offset = 0,
                _hooks = {},
                _ready_count = 0,
                _ready = {},
                broadcast = function(self, ...)
                    return self:send("", ...)
                end,
                send = function(self, realm, ...)
                    self._buffer:push(string.format(",%s,;%s", (type(realm) == "table" and table.concat(realm, ",") or
                        tostring(realm)), util.serialize(...)))
                end,
                listen = function(self, callback)
                    if self._ready[callback] ~= nil then
                        return
                    end
                    self._hooks[#self._hooks + 1] = callback
                    self:ready(callback)
                    return callback
                end,
                unlisten = function(self, callback)
                    self:unready(callback)
                    self._ready[callback] = nil
                    for i = 1, #self._hooks do
                        if self._hooks[i] == callback then
                            table.remove(self._hooks, i)
                            return true
                        end
                    end
                end,
                ready = function(self, callback)
                    if not self._ready[callback] then
                        self._ready_count = self._ready_count + 1
                        self._ready[callback] = true
                    end
                end,
                unready = function(self, callback)
                    if self._ready[callback] then
                        self._ready_count = self._ready_count - 1
                        self._ready[callback] = false
                    end
                end
            }
            local_realm = "," .. (local_realm or "unknown") .. ","
            local function receive(...)
                for i = 1, #channel._hooks do
                    local f = channel._hooks[i]
                    if channel._ready[f] then
                        f(channel, ...)
                    end
                end
            end
            hook.add("base.tick", name, function(dt)
                if channel._ready_count > 0 then
                    local last_pos = channel._buffer:pos()
                    if last_pos > channel._offset then
                        for i = math.max(channel._offset, last_pos - max), last_pos - 1 do
                            local message = channel._buffer:get_g(i)
                            local start = message:find(";", 1, true)
                            local realms = message:sub(1, start - 1)
                            if realms == ",," or realms:find(local_realm, 1, true) then
                                receive(util.unserialize(message:sub(start + 1)))
                                if channel._ready_count <= 0 then
                                    channel._offset = i + 1
                                    return
                                end
                            end
                        end
                        channel._offset = last_pos
                    end
                end
            end)
            return channel
        end
        function util.async_channel(channel)
            local listener = {
                _channel = channel,
                _waiter = nil,
                read = function(self)
                    self._waiter = coroutine.running()
                    if not self._waiter then
                        error("async_channel:read() can only be used in a coroutine")
                    end
                    self._channel:ready(self._handler)
                    return coroutine.yield()
                end,
                close = function(self)
                    if self._handler then
                        self._channel:unlisten(self._handler)
                    end
                end
            }
            listener._handler = listener._channel:listen(function(_, ...)
                if listener._waiter then
                    local co = listener._waiter
                    listener._waiter = nil
                    listener._channel:unready(listener._handler)
                    return coroutine.resume(co, ...)
                end
            end)
            listener._channel:unready(listener._handler)
            return listener
        end
    end
    do
        local gets, sets = {}, {}
        function util.register_unserializer(type, callback)
            gets[type] = function(key)
                return callback(GetString(key))
            end
        end
        if coreloaded then
            hook.add("api.newmeta", "api.createunserializer", function(name, meta)
                gets[name] = function(key)
                    return setmetatable({}, meta):__unserialize(GetString(key))
                end
                sets[name] = function(key, value)
                    return SetString(key, meta.__serialize(value))
                end
            end)
        end
        function util.shared_table(name, base)
            return setmetatable(base or {}, {
                __index = function(self, k)
                    local key = tostring(k)
                    local vtype = GetString(string.format("%s.%s.type", name, key))
                    if vtype == "" then
                        return
                    end
                    return gets[vtype](string.format("%s.%s.val", name, key))
                end,
                __newindex = function(self, k, v)
                    local vtype = type(v)
                    local handler = sets[vtype]
                    if not handler then
                        return
                    end
                    local key = tostring(k)
                    if vtype == "table" then
                        local meta = getmetatable(v)
                        if meta and meta.__serialize and meta.__type then
                            vtype = meta.__type
                            v = meta.__serialize(v)
                            handler = sets.string
                        end
                    end
                    SetString(string.format("%s.%s.type", name, key), vtype)
                    handler(string.format("%s.%s.val", name, key), v)
                end
            })
        end
        function util.structured_table(name, base)
            local function generate(base)
                local root = {}
                local keys = {}
                for k, v in pairs(base) do
                    local key = name .. "." .. tostring(k)
                    if type(v) == "table" then
                        if #v == 0 then
                            root[k] = util.structured_table(key, v)
                        else
                            keys[k] = {
                                type = v[1],
                                key = key,
                                default = v[2]
                            }
                        end
                    elseif type(v) == "string" then
                        keys[k] = {
                            type = v,
                            key = key
                        }
                    else
                        root[k] = v
                    end
                end
                return setmetatable(root, {
                    __index = function(self, k)
                        local entry = keys[k]
                        if entry and gets[entry.type] then
                            if HasKey(entry.key) then
                                return gets[entry.type](entry.key)
                            else
                                return entry.default
                            end
                        end
                    end,
                    __newindex = function(self, k, v)
                        local entry = keys[k]
                        if entry and sets[entry.type] then
                            return sets[entry.type](entry.key, v)
                        end
                    end
                })
            end
            if type(base) == "table" then
                return generate(base)
            end
            return generate
        end
        gets.number = GetFloat
        gets.integer = GetInt
        gets.boolean = GetBool
        gets.string = GetString
        gets.table = util.shared_table
        sets.number = SetFloat
        sets.integer = SetInt
        sets.boolean = SetBool
        sets.string = SetString
        sets.table = function(key, val)
            local tab = util.shared_table(key)
            for k, v in pairs(val) do
                tab[k] = v
            end
        end
    end
end)();
for i = 1, #__RUNLATER do
    local f = loadstring(__RUNLATER[i])
    if f then
        pcall(f)
    end
end
