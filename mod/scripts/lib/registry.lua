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
