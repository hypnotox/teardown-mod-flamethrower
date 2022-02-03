Util = {}

function Util:random(min, max)
    return math.random(1000) / 1000 * (max - min) + min
end

-- Return a random vector of desired length
function Util:randomVector(length)
    local v = VecNormalize(Vec(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
    return VecScale(v, length)
end

-- Used to dump a variable onto screen
function Util:dump(object, shouldReturn)
   shouldReturn = shouldReturn or false

    if type(object) == 'table' then
        local s = '{ '
        for k, v in ipairs(object) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. self:dump(v, shouldReturn or true) or '' .. ','
        end

        if shouldReturn then
            return s .. '} '
        end

        DebugPrint(s .. '} ')
    else
        if shouldReturn then
            return tostring(object)
        end

        DebugPrint(tostring(object))
    end
end
