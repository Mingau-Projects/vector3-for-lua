--@class vector
local vector = {}
vector.__index = vector

--@param x number
--@param y number
--@param z number
--@return vector
vector.new = function(x, y, z)
    --@type vector
    local self = setmetatable({}, vector)

    self.X = x or 0
    self.Y = y or 0
    self.Z = z or 0

    return self
end

--@return number
function vector:Length()
    return math.sqrt(self:LengthSquared())
end

--@return number
function vector:LengthSquared()
    return (self.X * self.X) + (self.Y * self.Y) + (self.Z * self.Z)
end

--@return number
function vector:Distance(v)
    return math.sqrt(self:DistanceSquared(v))
end

--@return number
function vector:DistanceSquared(v)
    local dist = (
        ((self.X - v.X) * (self.X - v.X)) +
        ((self.Y - v.Y) * (self.Y - v.Y)) +
        ((self.Z - v.Z) * (self.Z - v.Z))
    )
    return dist
end

--@return vector
function vector:Normalize()
    local length = self:Length()
    if length == 0 then return end

    self.X = self.X / length
    self.Y = self.Y / length
    self.Z = self.Z / length

    return self
end

--@return vector
function vector:GetNormalized()
    local length = self:Length()
    if length == 0 then return end

    local v = vector.new(self.X / length, self.Y / length, self.Z / length)

    return v
end

--@param v vector
--@return number
function vector:Angle(v)
    assert(getmetatable(v) == vector, "Angle expects a vector!")
    local lenght = (self:Length() * v:Length())
    if lenght == 0 then
        return 0
    end

    local dot = self:Dot(v)

    local cosTheta = dot / lenght
    cosTheta = math.max(-1, math.min(1, cosTheta))
    local theta = math.acos(cosTheta)

    return theta
end

--@param v vector
--@return number
function vector:Dot(v)
    assert(getmetatable(v) == vector, "Dot expects a vector!")
    return self.X * v.X + self.Y * v.Y + self.Z * v.Z
end

--@param v vector
--@return vector
function vector:Cross(v)
    assert(getmetatable(v) == vector, "Cross expects a vector!")
    local x = (self.Y * v.Z - self.Z * v.Y)
    local y = (self.Z * v.X - self.X * v.Z)
    local z = (self.X * v.Y - self.Y * v.X)

    return vector.new(x, y, z)
end

--@param scalar number
--@return vector
function vector:Scale(scalar)
    assert(type(scalar) == "number", "Scale expects a number!")
    self.X = self.X * scalar
    self.Y = self.Y * scalar
    self.Z = self.Z * scalar

    return self
end

vector.__add = function(v, k)
    local vIsVector = getmetatable(v) == vector
    local kIsVector = getmetatable(k) == vector

    if vIsVector and kIsVector then
        return vector.new(v.X + k.X, v.Y + k.Y, v.Z + k.Z)

    elseif vIsVector and type(k) == "number" then
        return vector.new(v.X + k, v.Y + k, v.Z + k)

    elseif type(v) == "number" and kIsVector then
        return vector.new(v + k.X, v + k.Y, v + k.Z)
    end

    error("Invalid addition between " .. type(v) .. " and " .. type(k))
end
vector.__sub = function(v, k)
    local vIsVector = getmetatable(v) == vector
    local kIsVector = getmetatable(k) == vector

    if vIsVector and kIsVector then
        return vector.new(v.X - k.X, v.Y - k.Y, v.Z - k.Z)

    elseif vIsVector and type(k) == "number" then
        return vector.new(v.X - k, v.Y - k, v.Z - k)

    elseif type(v) == "number" and kIsVector then
        return vector.new(v - k.X, v - k.Y, v - k.Z)
    end

    error("Invalid subtraction between " .. type(v) .. " and " .. type(k))
end
vector.__mul = function(v, k)
    local vIsVector = getmetatable(v) == vector
    local kIsVector = getmetatable(k) == vector

    if vIsVector and kIsVector then
        return vector.new(v.X * k.X, v.Y * k.Y, v.Z * k.Z)

    elseif vIsVector and type(k) == "number" then
        return vector.new(v.X * k, v.Y * k, v.Z * k)

    elseif type(v) == "number" and kIsVector then
        return vector.new(v * k.X, v * k.Y, v * k.Z)
    end

    error("Invalid multiplication between " .. type(v) .. " and " .. type(k))
end
vector.__div = function(v, k)
   local vIsVector = getmetatable(v) == vector
    local kIsVector = getmetatable(k) == vector

    if vIsVector and kIsVector then
        return vector.new(v.X / k.X, v.Y / k.Y, v.Z / k.Z)

    elseif vIsVector and type(k) == "number" then
        return vector.new(v.X / k, v.Y / k, v.Z / k)

    elseif type(v) == "number" and kIsVector then
        return vector.new(v / k.X, v / k.Y, v / k.Z)
    end

    error("Invalid division between " .. type(v) .. " and " .. type(k))
end
vector.__unm = function(v)
    return vector.new(v.X * (-1), v.Y * (-1), v.Z * (-1))
end
vector.__pow = function(v, k)
    local vIsVector = getmetatable(v) == vector
    local kIsVector = getmetatable(k) == vector

    if vIsVector and kIsVector then
        return vector.new(v.X ^ k.X, v.Y ^ k.Y, v.Z ^ k.Z)

    elseif vIsVector and type(k) == "number" then
        return vector.new(v.X ^ k, v.Y ^ k, v.Z ^ k)

    elseif type(v) == "number" and kIsVector then
        return vector.new(v ^ k.X, v ^ k.Y, v ^ k.Z)
    end

    error("Invalid exponential between " .. type(v) .. " and " .. type(k))
end

vector.__eq = function(v, k)
    local factor1 = v.X == k.X
    local factor2 = v.Y == k.Y
    local factor3 = v.Z == k.Z

    return factor1 and factor2 and factor3
end

vector.__tostring = function(v)
    return "{\n X: " .. v.X .. "\n Y: " .. v.Y .. "\n Z: " .. v.Z .. "\n}"
end

return vector