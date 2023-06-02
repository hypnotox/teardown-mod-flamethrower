
--[[
Teardown uses Lua version 5.1 as scripting language.
The API can be found here: https://www.teardowngame.com/modding/api.html
The Lua 5.1 reference manual can be found here: https://www.lua.org/manual/5.1/

Created with HypnoTox's Teardown API Stub Generator, available at: https://github.com/hypnotox/teardown-api-stub-generator
]]

--[[ Classes ]]

---@class VectorType:table
---@see @https://www.teardowngame.com/modding/api.html#Vec
local defaultVector = {0, 0, 0}

---@class QuaternionType:table
---@see @https://www.teardowngame.com/modding/api.html#Quat
local defaultQuaternion = {0, 0, 0, 0}

---@class TransformType:table
---@field pos VectorType Vector representing transform position
---@field rot QuaternionType Quaternion representing transform rotation
---@see @https://www.teardowngame.com/modding/api.html#Transform
local defaultTransform = {
    pos = Vec(),
    rot = Quat(),
}

--[[ Functions ]]

---@param name string Parameter name
---@param default number Default parameter value
---@return number value Parameter value
---@see @https://www.teardowngame.com/modding/api.html#GetIntParam
function GetIntParam(name, default) end

---@param name string Parameter name
---@param default number Default parameter value
---@return number value Parameter value
---@see @https://www.teardowngame.com/modding/api.html#GetFloatParam
function GetFloatParam(name, default) end

---@param name string Parameter name
---@param default boolean Default parameter value
---@return boolean value Parameter value
---@see @https://www.teardowngame.com/modding/api.html#GetBoolParam
function GetBoolParam(name, default) end

---@param name string Parameter name
---@param default string Default parameter value
---@return string value Parameter value
---@see @https://www.teardowngame.com/modding/api.html#GetStringParam
function GetStringParam(name, default) end

---@return string version Dot separated string of current version of the game
---@see @https://www.teardowngame.com/modding/api.html#GetVersion
function GetVersion() end

---@param version string Reference version
---@return boolean match True if current version is at least provided one
---@see @https://www.teardowngame.com/modding/api.html#HasVersion
function HasVersion(version) end

---@return number time The time in seconds since level was started
---@see @https://www.teardowngame.com/modding/api.html#GetTime
function GetTime() end

---@return number dt The timestep in seconds
---@see @https://www.teardowngame.com/modding/api.html#GetTimeStep
function GetTimeStep() end

---@return string name Name of last pressed key, empty if no key is pressed
---@see @https://www.teardowngame.com/modding/api.html#InputLastPressedKey
function InputLastPressedKey() end

---@param input string The input identifier
---@return boolean pressed True if input was pressed during last frame
---@see @https://www.teardowngame.com/modding/api.html#InputPressed
function InputPressed(input) end

---@param input string The input identifier
---@return boolean pressed True if input was released during last frame
---@see @https://www.teardowngame.com/modding/api.html#InputReleased
function InputReleased(input) end

---@param input string The input identifier
---@return boolean pressed True if input is currently held down
---@see @https://www.teardowngame.com/modding/api.html#InputDown
function InputDown(input) end

---@param input string The input identifier
---@return number value Depends on input type
---@see @https://www.teardowngame.com/modding/api.html#InputValue
function InputValue(input) end

---@param variable string Name of number variable in the global context
---@param value number The new value
---@param transition string|nil Transition type. See description.
---@param time number|nil Transition time (seconds)
---@see @https://www.teardowngame.com/modding/api.html#SetValue
function SetValue(variable, value, transition, time) end

---@param title string Text on button
---@param primary bool|nil Primary button
---@return boolean clicked True if clicked, false otherwise
---@see @https://www.teardowngame.com/modding/api.html#PauseMenuButton
function PauseMenuButton(title, primary) end

---@param mission string An identifier of your choice
---@param path string Path to level XML file
---@param layers string|nil Active layers. Default is no layers.
---@param passThrough boolean|nil If set, loading screen will have no text and music will keep playing
---@see @https://www.teardowngame.com/modding/api.html#StartLevel
function StartLevel(mission, path, layers, passThrough) end

---@param paused boolean True if game should be paused
---@see @https://www.teardowngame.com/modding/api.html#SetPaused
function SetPaused(paused) end

---@see @https://www.teardowngame.com/modding/api.html#Restart
function Restart() end

---@see @https://www.teardowngame.com/modding/api.html#Menu
function Menu() end

---@param key string Registry key to clear
---@see @https://www.teardowngame.com/modding/api.html#ClearKey
function ClearKey(key) end

---@param parent string The parent registry key
---@return table<string> children Indexed table of strings with child keys
---@see @https://www.teardowngame.com/modding/api.html#ListKeys
function ListKeys(parent) end

---@param key string Registry key
---@return boolean exists True if key exists
---@see @https://www.teardowngame.com/modding/api.html#HasKey
function HasKey(key) end

---@param key string Registry key
---@param value number Desired value
---@see @https://www.teardowngame.com/modding/api.html#SetInt
function SetInt(key, value) end

---@param key string Registry key
---@return number value Integer value of registry node or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#GetInt
function GetInt(key) end

---@param key string Registry key
---@param value number Desired value
---@see @https://www.teardowngame.com/modding/api.html#SetFloat
function SetFloat(key, value) end

---@param key string Registry key
---@return number value Float value of registry node or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#GetFloat
function GetFloat(key) end

---@param key string Registry key
---@param value boolean Desired value
---@see @https://www.teardowngame.com/modding/api.html#SetBool
function SetBool(key, value) end

---@param key string Registry key
---@return boolean value Boolean value of registry node or false if not found
---@see @https://www.teardowngame.com/modding/api.html#GetBool
function GetBool(key) end

---@param key string Registry key
---@param value string Desired value
---@see @https://www.teardowngame.com/modding/api.html#SetString
function SetString(key, value) end

---@param key string Registry key
---@return string value String value of registry node or '' if not found
---@see @https://www.teardowngame.com/modding/api.html#GetString
function GetString(key) end

---@param x number|nil X value
---@param y number|nil Y value
---@param z number|nil Z value
---@return VectorType vec New vector
---@see @https://www.teardowngame.com/modding/api.html#Vec
function Vec(x, y, z) end

---@param org VectorType A vector
---@return VectorType new Copy of org vector
---@see @https://www.teardowngame.com/modding/api.html#VecCopy
function VecCopy(org) end

---@param vec VectorType A vector
---@return number length Length (magnitude) of the vector
---@see @https://www.teardowngame.com/modding/api.html#VecLength
function VecLength(vec) end

---@param vec VectorType A vector
---@return VectorType norm A vector of length 1.0
---@see @https://www.teardowngame.com/modding/api.html#VecNormalize
function VecNormalize(vec) end

---@param vec VectorType A vector
---@param scale number A scale factor
---@return VectorType norm A scaled version of input vector
---@see @https://www.teardowngame.com/modding/api.html#VecScale
function VecScale(vec, scale) end

---@param a VectorType Vector
---@param b VectorType Vector
---@return VectorType c New vector with sum of a and b
---@see @https://www.teardowngame.com/modding/api.html#VecAdd
function VecAdd(a, b) end

---@param a VectorType Vector
---@param b VectorType Vector
---@return VectorType c New vector representing a-b
---@see @https://www.teardowngame.com/modding/api.html#VecSub
function VecSub(a, b) end

---@param a VectorType Vector
---@param b VectorType Vector
---@return number c Dot product of a and b
---@see @https://www.teardowngame.com/modding/api.html#VecDot
function VecDot(a, b) end

---@param a VectorType Vector
---@param b VectorType Vector
---@return VectorType c Cross product of a and b (also called vector product)
---@see @https://www.teardowngame.com/modding/api.html#VecCross
function VecCross(a, b) end

---@param a VectorType Vector
---@param b VectorType Vector
---@param t number fraction (usually between 0.0 and 1.0)
---@return VectorType c Linearly interpolated vector between a and b, using t
---@see @https://www.teardowngame.com/modding/api.html#VecLerp
function VecLerp(a, b, t) end

---@param x number|nil X value
---@param y number|nil Y value
---@param z number|nil Z value
---@param w number|nil W value
---@return QuaternionType quat New quaternion
---@see @https://www.teardowngame.com/modding/api.html#Quat
function Quat(x, y, z, w) end

---@param org QuaternionType Quaternion
---@return QuaternionType new Copy of org quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatCopy
function QuatCopy(org) end

---@param axis QuaternionType Rotation axis, unit vector
---@param angle number Rotation angle in degrees
---@return QuaternionType quat New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatAxisAngle
function QuatAxisAngle(axis, angle) end

---@param x number Angle around X axis in degrees, sometimes also called roll or bank
---@param y number Angle around Y axis in degrees, sometimes also called yaw or heading
---@param z number Angle around Z axis in degrees, sometimes also called pitch or attitude
---@return QuaternionType quat New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatEuler
function QuatEuler(x, y, z) end

---@param quat QuaternionType Quaternion
---@return number x Angle around X axis in degrees, sometimes also called roll or bank
---@return number y Angle around Y axis in degrees, sometimes also called yaw or heading
---@return number z Angle around Z axis in degrees, sometimes also called pitch or attitude
---@see @https://www.teardowngame.com/modding/api.html#GetQuatEuler
function GetQuatEuler(quat) end

---@param eye VectorType Vector representing the camera location
---@param target VectorType Vector representing the point to look at
---@return QuaternionType quat New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatLookAt
function QuatLookAt(eye, target) end

---@param a QuaternionType Quaternion
---@param b QuaternionType Quaternion
---@param t number fraction (usually between 0.0 and 1.0)
---@return QuaternionType c New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatSlerp
function QuatSlerp(a, b, t) end

---@param a QuaternionType Quaternion
---@param b QuaternionType Quaternion
---@return QuaternionType c New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatRotateQuat
function QuatRotateQuat(a, b) end

---@param a QuaternionType Quaternion
---@param vec VectorType Vector
---@return VectorType vec Rotated vector
---@see @https://www.teardowngame.com/modding/api.html#QuatRotateVec
function QuatRotateVec(a, vec) end

---@param pos VectorType|nil Vector representing transform position
---@param rot QuaternionType|nil Quaternion representing transform rotation
---@return TransformType transform New transform
---@see @https://www.teardowngame.com/modding/api.html#Transform
function Transform(pos, rot) end

---@param org TransformType Transform
---@return TransformType new Copy of org transform
---@see @https://www.teardowngame.com/modding/api.html#TransformCopy
function TransformCopy(org) end

---@param parent TransformType Transform
---@param child TransformType Transform
---@return TransformType transform New transform
---@see @https://www.teardowngame.com/modding/api.html#TransformToParentTransform
function TransformToParentTransform(parent, child) end

---@param parent TransformType Transform
---@param child TransformType Transform
---@return TransformType transform New transform
---@see @https://www.teardowngame.com/modding/api.html#TransformToLocalTransform
function TransformToLocalTransform(parent, child) end

---@param t TransformType Transform
---@param v VectorType Vector
---@return VectorType r Transformed vector
---@see @https://www.teardowngame.com/modding/api.html#TransformToParentVec
function TransformToParentVec(t, v) end

---@param t TransformType Transform
---@param v VectorType Vector
---@return VectorType r Transformed vector
---@see @https://www.teardowngame.com/modding/api.html#TransformToLocalVec
function TransformToLocalVec(t, v) end

---@param t TransformType Transform
---@param p VectorType Vector representing position
---@return VectorType r Transformed position
---@see @https://www.teardowngame.com/modding/api.html#TransformToParentPoint
function TransformToParentPoint(t, p) end

---@param t TransformType Transform
---@param p VectorType Vector representing position
---@return VectorType r Transformed position
---@see @https://www.teardowngame.com/modding/api.html#TransformToLocalPoint
function TransformToLocalPoint(t, p) end

---@param handle integer Entity handle
---@param tag string Tag name
---@param value string|nil Tag value
---@see @https://www.teardowngame.com/modding/api.html#SetTag
function SetTag(handle, tag, value) end

---@param handle integer Entity handle
---@param tag string Tag name
---@see @https://www.teardowngame.com/modding/api.html#RemoveTag
function RemoveTag(handle, tag) end

---@param handle integer Entity handle
---@param tag string Tag name
---@return boolean exists Returns true if entity has tag
---@see @https://www.teardowngame.com/modding/api.html#HasTag
function HasTag(handle, tag) end

---@param handle integer Entity handle
---@param tag string Tag name
---@return string value Returns the tag value, if any. Empty string otherwise.
---@see @https://www.teardowngame.com/modding/api.html#GetTagValue
function GetTagValue(handle, tag) end

---@param handle integer Entity handle
---@return string description The description string
---@see @https://www.teardowngame.com/modding/api.html#GetDescription
function GetDescription(handle) end

---@param handle integer Entity handle
---@param description string The description string
---@see @https://www.teardowngame.com/modding/api.html#SetDescription
function SetDescription(handle, description) end

---@param handle integer Entity handle
---@see @https://www.teardowngame.com/modding/api.html#Delete
function Delete(handle) end

---@param handle integer Entity handle
---@return boolean exists Returns true if the entity pointed to by handle still exists
---@see @https://www.teardowngame.com/modding/api.html#IsHandleValid
function IsHandleValid(handle) end

---@param handle integer Entity handle
---@return string type Type name of the provided entity
---@see @https://www.teardowngame.com/modding/api.html#GetEntityType
function GetEntityType(handle) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return integer handle Handle to first body with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindBody
function FindBody(tag, global) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return table<integer> list Indexed table with handles to all bodies with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindBodies
function FindBodies(tag, global) end

---@param handle integer Body handle
---@return TransformType transform Transform of the body
---@see @https://www.teardowngame.com/modding/api.html#GetBodyTransform
function GetBodyTransform(handle) end

---@param handle integer Body handle
---@param transform TransformType Desired transform
---@see @https://www.teardowngame.com/modding/api.html#SetBodyTransform
function SetBodyTransform(handle, transform) end

---@param handle integer Body handle
---@return number mass Body mass. Static bodies always return zero mass.
---@see @https://www.teardowngame.com/modding/api.html#GetBodyMass
function GetBodyMass(handle) end

---@param handle integer Body handle
---@return boolean dynamic Return true if body is dynamic
---@see @https://www.teardowngame.com/modding/api.html#IsBodyDynamic
function IsBodyDynamic(handle) end

---@param handle integer Body handle
---@param dynamic boolean True for dynamic. False for static.
---@see @https://www.teardowngame.com/modding/api.html#SetBodyDynamic
function SetBodyDynamic(handle, dynamic) end

---@param handle integer Body handle (should be a dynamic body)
---@param velocity VectorType Vector with linear velocity
---@see @https://www.teardowngame.com/modding/api.html#SetBodyVelocity
function SetBodyVelocity(handle, velocity) end

---@param handle integer Body handle (should be a dynamic body)
---@return VectorType velocity Linear velocity as vector
---@see @https://www.teardowngame.com/modding/api.html#GetBodyVelocity
function GetBodyVelocity(handle) end

---@param handle integer Body handle (should be a dynamic body)
---@param pos VectorType World space point as vector
---@return VectorType velocity Linear velocity on body at pos as vector
---@see @https://www.teardowngame.com/modding/api.html#GetBodyVelocityAtPos
function GetBodyVelocityAtPos(handle, pos) end

---@param handle integer Body handle (should be a dynamic body)
---@param angVel VectorType Vector with angular velocity
---@see @https://www.teardowngame.com/modding/api.html#SetBodyAngularVelocity
function SetBodyAngularVelocity(handle, angVel) end

---@param handle integer Body handle (should be a dynamic body)
---@return VectorType angVel Angular velocity as vector
---@see @https://www.teardowngame.com/modding/api.html#GetBodyAngularVelocity
function GetBodyAngularVelocity(handle) end

---@param handle integer Body handle
---@return boolean active Return true if body is active
---@see @https://www.teardowngame.com/modding/api.html#IsBodyActive
function IsBodyActive(handle) end

---@param handle integer Body handle
---@param active boolean Set to tru if body should be active (simulated)
---@see @https://www.teardowngame.com/modding/api.html#SetBodyActive
function SetBodyActive(handle, active) end

---@param handle integer Body handle (should be a dynamic body)
---@param position VectorType World space position as vector
---@param impulse VectorType World space impulse as vector
---@see @https://www.teardowngame.com/modding/api.html#ApplyBodyImpulse
function ApplyBodyImpulse(handle, position, impulse) end

---@param handle integer Body handle
---@return table<integer> list Indexed table of shape handles
---@see @https://www.teardowngame.com/modding/api.html#GetBodyShapes
function GetBodyShapes(handle) end

---@param body number Body handle
---@return integer handle Get parent vehicle for body, or zero if not part of vehicle
---@see @https://www.teardowngame.com/modding/api.html#GetBodyVehicle
function GetBodyVehicle(body) end

---@param handle integer Body handle
---@return VectorType min Vector representing the AABB lower bound
---@return VectorType max Vector representing the AABB upper bound
---@see @https://www.teardowngame.com/modding/api.html#GetBodyBounds
function GetBodyBounds(handle) end

---@param handle integer Body handle
---@return VectorType point Vector representing local center of mass in body space
---@see @https://www.teardowngame.com/modding/api.html#GetBodyCenterOfMass
function GetBodyCenterOfMass(handle) end

---@param handle integer Body handle
---@param maxDist number Maximum visible distance
---@param rejectTransparent boolean|nil See through transparent materials. Default false.
---@return boolean visible Return true if body is visible
---@see @https://www.teardowngame.com/modding/api.html#IsBodyVisible
function IsBodyVisible(handle, maxDist, rejectTransparent) end

---@param handle integer Body handle
---@return boolean broken Return true if body is broken
---@see @https://www.teardowngame.com/modding/api.html#IsBodyBroken
function IsBodyBroken(handle) end

---@param handle integer Body handle
---@return boolean result Return true if body is in any way connected to a static body
---@see @https://www.teardowngame.com/modding/api.html#IsBodyJointedToStatic
function IsBodyJointedToStatic(handle) end

---@param handle integer Body handle
---@param r number|nil Red
---@param g number|nil Green
---@param b number|nil Blue
---@param a number Alpha
---@see @https://www.teardowngame.com/modding/api.html#DrawBodyOutline
function DrawBodyOutline(handle, r, g, b, a) end

---@param handle integer Body handle
---@param amount number Amount
---@see @https://www.teardowngame.com/modding/api.html#DrawBodyHighlight
function DrawBodyHighlight(handle, amount) end

---@param body integer Body handle
---@param origin VectorType World space point
---@return boolean hit True if a point was found
---@return VectorType point World space closest point
---@return VectorType normal World space normal at closest point
---@return integer shape Handle to closest shape
---@see @https://www.teardowngame.com/modding/api.html#GetBodyClosestPoint
function GetBodyClosestPoint(body, origin) end

---@param bodyA integer First body handle (zero for static)
---@param bodyB integer Second body handle (zero for static)
---@param point VectorType World space point
---@param dir VectorType World space direction
---@param relVel number Desired relative velocity along the provided direction
---@param min number|nil Minimum impulse (default: -infinity)
---@param max number|nil Maximum impulse (default: infinity)
---@see @https://www.teardowngame.com/modding/api.html#ConstrainVelocity
function ConstrainVelocity(bodyA, bodyB, point, dir, relVel, min, max) end

---@param bodyA integer First body handle (zero for static)
---@param bodyB integer Second body handle (zero for static)
---@param dir VectorType World space direction
---@param relAngVel number Desired relative angular velocity along the provided direction
---@param min number|nil Minimum angular impulse (default: -infinity)
---@param max number|nil Maximum angular impulse (default: infinity)
---@see @https://www.teardowngame.com/modding/api.html#ConstrainAngularVelocity
function ConstrainAngularVelocity(bodyA, bodyB, dir, relAngVel, min, max) end

---@param bodyA integer First body handle (zero for static)
---@param bodyB integer Second body handle (zero for static)
---@param pointA VectorType World space point for first body
---@param pointB VectorType World space point for second body
---@param maxVel number|nil Maximum relative velocity (default: infinite)
---@param maxImpulse number|nil Maximum impulse (default: infinite)
---@see @https://www.teardowngame.com/modding/api.html#ConstrainPosition
function ConstrainPosition(bodyA, bodyB, pointA, pointB, maxVel, maxImpulse) end

---@param bodyA integer First body handle (zero for static)
---@param bodyB integer Second body handle (zero for static)
---@param quatA VectorType World space orientation for first body
---@param quatB VectorType World space orientation for second body
---@param maxAngVel number|nil Maximum relative angular velocity (default: infinite)
---@param maxAngImpulse number|nil Maximum angular impulse (default: infinite)
---@see @https://www.teardowngame.com/modding/api.html#ConstrainOrientation
function ConstrainOrientation(bodyA, bodyB, quatA, quatB, maxAngVel, maxAngImpulse) end

---@return integer body Handle to the static world body
---@see @https://www.teardowngame.com/modding/api.html#GetWorldBody
function GetWorldBody() end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return integer handle Handle to first shape with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindShape
function FindShape(tag, global) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return table<number> list Indexed table with handles to all shapes with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindShapes
function FindShapes(tag, global) end

---@param handle integer Shape handle
---@return TransformType transform Return shape transform in body space
---@see @https://www.teardowngame.com/modding/api.html#GetShapeLocalTransform
function GetShapeLocalTransform(handle) end

---@param handle integer Shape handle
---@param transform TransformType Shape transform in body space
---@see @https://www.teardowngame.com/modding/api.html#SetShapeLocalTransform
function SetShapeLocalTransform(handle, transform) end

---@param handle integer Shape handle
---@return TransformType transform Return shape transform in world space
---@see @https://www.teardowngame.com/modding/api.html#GetShapeWorldTransform
function GetShapeWorldTransform(handle) end

---@param handle integer Shape handle
---@return integer handle Body handle
---@see @https://www.teardowngame.com/modding/api.html#GetShapeBody
function GetShapeBody(handle) end

---@param shape number Shape handle
---@return table<number> list Indexed table with joints connected to shape
---@see @https://www.teardowngame.com/modding/api.html#GetShapeJoints
function GetShapeJoints(shape) end

---@param shape number Shape handle
---@return table<number> list Indexed table of lights owned by shape
---@see @https://www.teardowngame.com/modding/api.html#GetShapeLights
function GetShapeLights(shape) end

---@param handle integer Shape handle
---@return VectorType min Vector representing the AABB lower bound
---@return VectorType max Vector representing the AABB upper bound
---@see @https://www.teardowngame.com/modding/api.html#GetShapeBounds
function GetShapeBounds(handle) end

---@param handle integer Shape handle
---@param scale number Scale factor for emissiveness
---@see @https://www.teardowngame.com/modding/api.html#SetShapeEmissiveScale
function SetShapeEmissiveScale(handle, scale) end

---@param handle integer Shape handle
---@param pos VectorType Position in world space
---@return string type Material type
---@return number r Red
---@return number g Green
---@return number b Blue
---@return number a Alpha
---@see @https://www.teardowngame.com/modding/api.html#GetShapeMaterialAtPosition
function GetShapeMaterialAtPosition(handle, pos) end

---@param handle integer Shape handle
---@param x number X integer coordinate
---@param y number Y integer coordinate
---@param z number Z integer coordinate
---@return string type Material type
---@return number r Red
---@return number g Green
---@return number b Blue
---@return number a Alpha
---@see @https://www.teardowngame.com/modding/api.html#GetShapeMaterialAtIndex
function GetShapeMaterialAtIndex(handle, x, y, z) end

---@param handle integer Shape handle
---@return number xsize Size in voxels along x axis
---@return number ysize Size in voxels along y axis
---@return number zsize Size in voxels along z axis
---@return number scale The size of one voxel in meters (with default scale it is 0.1)
---@see @https://www.teardowngame.com/modding/api.html#GetShapeSize
function GetShapeSize(handle) end

---@param handle integer Shape handle
---@return number count Number of voxels in shape
---@see @https://www.teardowngame.com/modding/api.html#GetShapeVoxelCount
function GetShapeVoxelCount(handle) end

---@param handle integer Shape handle
---@param maxDist number Maximum visible distance
---@param rejectTransparent boolean|nil See through transparent materials. Default false.
---@return boolean visible Return true if shape is visible
---@see @https://www.teardowngame.com/modding/api.html#IsShapeVisible
function IsShapeVisible(handle, maxDist, rejectTransparent) end

---@param handle integer Shape handle
---@return boolean broken Return true if shape is broken
---@see @https://www.teardowngame.com/modding/api.html#IsShapeBroken
function IsShapeBroken(handle) end

---@param handle integer Shape handle
---@param a number Alpha
---@see @https://www.teardowngame.com/modding/api.html#DrawShapeOutline
function DrawShapeOutline(handle, a) end

---@param handle integer Shape handle
---@param r number|nil Red
---@param g number|nil Green
---@param b number|nil Blue
---@param a number Alpha
---@see @https://www.teardowngame.com/modding/api.html#DrawShapeOutline
function DrawShapeOutline(handle, r, g, b, a) end

---@param handle integer Shape handle
---@param amount number Amount
---@see @https://www.teardowngame.com/modding/api.html#DrawShapeHighlight
function DrawShapeHighlight(handle, amount) end

---@param handle integer Shape handle
---@param layer number Layer bits (0-255)
---@param mask number Mask bits (0-255)
---@see @https://www.teardowngame.com/modding/api.html#SetShapeCollisionFilter
function SetShapeCollisionFilter(handle, layer, mask) end

---@param shape integer Shape handle
---@param origin VectorType World space point
---@return boolean hit True if a point was found
---@return VectorType point World space closest point
---@return VectorType normal World space normal at closest point
---@see @https://www.teardowngame.com/modding/api.html#GetShapeClosestPoint
function GetShapeClosestPoint(shape, origin) end

---@param a integer Handle to first shape
---@param b integer Handle to second shape
---@return boolean touching True is shapes a and b are touching each other
---@see @https://www.teardowngame.com/modding/api.html#IsShapeTouching
function IsShapeTouching(a, b) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return integer handle Handle to first location with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindLocation
function FindLocation(tag, global) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return table<integer> list Indexed table with handles to all locations with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindLocations
function FindLocations(tag, global) end

---@param handle integer Location handle
---@return TransformType transform Transform of the location
---@see @https://www.teardowngame.com/modding/api.html#GetLocationTransform
function GetLocationTransform(handle) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return integer handle Handle to first joint with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindJoint
function FindJoint(tag, global) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return table<integer> list Indexed table with handles to all joints with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindJoints
function FindJoints(tag, global) end

---@param joint integer Joint handle
---@return boolean broken True if joint is broken
---@see @https://www.teardowngame.com/modding/api.html#IsJointBroken
function IsJointBroken(joint) end

---@param joint integer Joint handle
---@return string type Joint type
---@see @https://www.teardowngame.com/modding/api.html#GetJointType
function GetJointType(joint) end

---@param joint integer Joint handle
---@param shape number Shape handle
---@return number other Other shape handle
---@see @https://www.teardowngame.com/modding/api.html#GetJointOtherShape
function GetJointOtherShape(joint, shape) end

---@param joint integer Joint handle
---@return number shapes Shape handles
---@see @https://www.teardowngame.com/modding/api.html#GetJointShapes
function GetJointShapes(joint) end

---@param joint number Joint handle
---@param velocity number Desired velocity
---@param strength number|nil Desired strength. Default is infinite. Zero to disable.
---@see @https://www.teardowngame.com/modding/api.html#SetJointMotor
function SetJointMotor(joint, velocity, strength) end

---@param joint integer Joint handle
---@param target number Desired movement target
---@param maxVel number|nil Maximum velocity to reach target. Default is infinite.
---@param strength number|nil Desired strength. Default is infinite. Zero to disable.
---@see @https://www.teardowngame.com/modding/api.html#SetJointMotorTarget
function SetJointMotorTarget(joint, target, maxVel, strength) end

---@param joint integer Joint handle
---@return number min Minimum joint limit (angle or distance)
---@return number max Maximum joint limit (angle or distance)
---@see @https://www.teardowngame.com/modding/api.html#GetJointLimits
function GetJointLimits(joint) end

---@param joint integer Joint handle
---@return number movement Current joint position or angle
---@see @https://www.teardowngame.com/modding/api.html#GetJointMovement
function GetJointMovement(joint) end

---@param body integer Body handle (must be dynamic)
---@return table<integer> bodies Handles to all dynamic bodies in the jointed structure. The input handle will also be included.
---@see @https://www.teardowngame.com/modding/api.html#GetJointedBodies
function GetJointedBodies(body) end

---@param joint integer Joint handle
---@param shape integer Shape handle
---@see @https://www.teardowngame.com/modding/api.html#DetachJointFromShape
function DetachJointFromShape(joint, shape) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return integer handle Handle to first light with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindLight
function FindLight(tag, global) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return table<integer> list Indexed table with handles to all lights with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindLights
function FindLights(tag, global) end

---@param handle integer Light handle
---@param enabled boolean Set to true if light should be enabled
---@see @https://www.teardowngame.com/modding/api.html#SetLightEnabled
function SetLightEnabled(handle, enabled) end

---@param handle integer Light handle
---@param r number Red value
---@param g number Green value
---@param b number Blue value
---@see @https://www.teardowngame.com/modding/api.html#SetLightColor
function SetLightColor(handle, r, g, b) end

---@param handle integer Light handle
---@param intensity number Desired intensity of the light
---@see @https://www.teardowngame.com/modding/api.html#SetLightIntensity
function SetLightIntensity(handle, intensity) end

---@param handle integer Light handle
---@return TransformType transform World space light transform
---@see @https://www.teardowngame.com/modding/api.html#GetLightTransform
function GetLightTransform(handle) end

---@param handle integer Light handle
---@return integer handle Shape handle or zero if not attached to shape
---@see @https://www.teardowngame.com/modding/api.html#GetLightShape
function GetLightShape(handle) end

---@param handle integer Light handle
---@return boolean active True if light is currently emitting light
---@see @https://www.teardowngame.com/modding/api.html#IsLightActive
function IsLightActive(handle) end

---@param handle integer Light handle
---@param point VectorType World space point as vector
---@return boolean affected Return true if point is in light cone and range
---@see @https://www.teardowngame.com/modding/api.html#IsPointAffectedByLight
function IsPointAffectedByLight(handle, point) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return integer handle Handle to first trigger with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindTrigger
function FindTrigger(tag, global) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return table<integer> list Indexed table with handles to all triggers with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindTriggers
function FindTriggers(tag, global) end

---@param handle integer Trigger handle
---@return TransformType transform Current trigger transform in world space
---@see @https://www.teardowngame.com/modding/api.html#GetTriggerTransform
function GetTriggerTransform(handle) end

---@param handle integer Trigger handle
---@param transform TransformType Desired trigger transform in world space
---@see @https://www.teardowngame.com/modding/api.html#SetTriggerTransform
function SetTriggerTransform(handle, transform) end

---@param handle integer Trigger handle
---@return VectorType min Lower point of trigger bounds in world space
---@return VectorType max Upper point of trigger bounds in world space
---@see @https://www.teardowngame.com/modding/api.html#GetTriggerBounds
function GetTriggerBounds(handle) end

---@param trigger integer Trigger handle
---@param body integer Body handle
---@return boolean inside True if body is in trigger volume
---@see @https://www.teardowngame.com/modding/api.html#IsBodyInTrigger
function IsBodyInTrigger(trigger, body) end

---@param trigger integer Trigger handle
---@param vehicle integer Vehicle handle
---@return boolean inside True if vehicle is in trigger volume
---@see @https://www.teardowngame.com/modding/api.html#IsVehicleInTrigger
function IsVehicleInTrigger(trigger, vehicle) end

---@param trigger integer Trigger handle
---@param shape integer Shape handle
---@return boolean inside True if shape is in trigger volume
---@see @https://www.teardowngame.com/modding/api.html#IsShapeInTrigger
function IsShapeInTrigger(trigger, shape) end

---@param trigger integer Trigger handle
---@param point VectorType Word space point as vector
---@return boolean inside True if point is in trigger volume
---@see @https://www.teardowngame.com/modding/api.html#IsPointInTrigger
function IsPointInTrigger(trigger, point) end

---@param handle integer Trigger handle
---@param demolision boolean|nil If true, small debris and vehicles are ignored
---@return boolean empty True if trigger is empty
---@return VectorType maxpoint World space point of highest point (largest Y coordinate) if not empty
---@see @https://www.teardowngame.com/modding/api.html#IsTriggerEmpty
function IsTriggerEmpty(handle, demolision) end

---@param trigger integer Trigger handle
---@param point VectorType Word space point as vector
---@return number distance Positive if point is outside, negative if inside
---@see @https://www.teardowngame.com/modding/api.html#GetTriggerDistance
function GetTriggerDistance(trigger, point) end

---@param trigger integer Trigger handle
---@param point VectorType Word space point as vector
---@return VectorType closest Closest point in trigger as vector
---@see @https://www.teardowngame.com/modding/api.html#GetTriggerClosestPoint
function GetTriggerClosestPoint(trigger, point) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return integer handle Handle to first screen with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindScreen
function FindScreen(tag, global) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return table<integer> list Indexed table with handles to all screens with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindScreens
function FindScreens(tag, global) end

---@param screen integer Screen handle
---@param enabled boolean True if screen should be enabled
---@see @https://www.teardowngame.com/modding/api.html#SetScreenEnabled
function SetScreenEnabled(screen, enabled) end

---@param screen integer Screen handle
---@return boolean enabled True if screen is enabled
---@see @https://www.teardowngame.com/modding/api.html#IsScreenEnabled
function IsScreenEnabled(screen) end

---@param screen integer Screen handle
---@return integer shape Shape handle or zero if none
---@see @https://www.teardowngame.com/modding/api.html#GetScreenShape
function GetScreenShape(screen) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return integer handle Handle to first vehicle with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindVehicle
function FindVehicle(tag, global) end

---@param tag string Tag name
---@param global boolean|nil Search in entire scene
---@return table<number> list Indexed table with handles to all vehicles with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindVehicles
function FindVehicles(tag, global) end

---@param vehicle integer Vehicle handle
---@return TransformType transform Transform of vehicle
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleTransform
function GetVehicleTransform(vehicle) end

---@param vehicle integer Vehicle handle
---@return number body Main body of vehicle
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleBody
function GetVehicleBody(vehicle) end

---@param vehicle integer Vehicle handle
---@return number health Vehicle health (zero to one)
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleHealth
function GetVehicleHealth(vehicle) end

---@param vehicle integer Vehicle handle
---@return VectorType pos Driver position as vector in vehicle space
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleDriverPos
function GetVehicleDriverPos(vehicle) end

---@param vehicle integer Vehicle handle
---@param drive number Reverse/forward control -1 to 1
---@param steering number Left/right control -1 to 1
---@param handbrake boolean Handbrake control
---@see @https://www.teardowngame.com/modding/api.html#DriveVehicle
function DriveVehicle(vehicle, drive, steering, handbrake) end

---@return VectorType position Player center position
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerPos
function GetPlayerPos() end

---@param includePitch boolean|nil Include the player pitch (look up/down) in transform
---@return TransformType transform Current player transform
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerTransform
function GetPlayerTransform(includePitch) end

---@param transform TransformType Desired player transform
---@param includePitch boolean|nil Set player pitch (look up/down) as well
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerTransform
function SetPlayerTransform(transform, includePitch) end

---@param vel VectorType Desired ground velocity
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerGroundVelocity
function SetPlayerGroundVelocity(vel) end

---@return TransformType transform Current player camera transform
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerCameraTransform
function GetPlayerCameraTransform() end

---@param transform TransformType Desired player camera offset transform
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerCameraOffsetTransform
function SetPlayerCameraOffsetTransform(transform) end

---@param transform TransformType Desired player spawn transform
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerSpawnTransform
function SetPlayerSpawnTransform(transform) end

---@return VectorType velocity Player velocity in world space as vector
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerVelocity
function GetPlayerVelocity() end

---@param vehicle integer Handle to vehicle or zero to not drive.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerVehicle
function SetPlayerVehicle(vehicle) end

---@param velocity VectorType Player velocity in world space as vector
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerVelocity
function SetPlayerVelocity(velocity) end

---@return integer handle Current vehicle handle, or zero if not in vehicle
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerVehicle
function GetPlayerVehicle() end

---@return integer handle Handle to grabbed shape or zero if not grabbing.
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerGrabShape
function GetPlayerGrabShape() end

---@return integer handle Handle to grabbed body or zero if not grabbing.
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerGrabBody
function GetPlayerGrabBody() end

---@see @https://www.teardowngame.com/modding/api.html#ReleasePlayerGrab
function ReleasePlayerGrab() end

---@return integer handle Handle to picked shape or zero if nothing is picked
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerPickShape
function GetPlayerPickShape() end

---@return integer handle Handle to picked body or zero if nothing is picked
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerPickBody
function GetPlayerPickBody() end

---@return integer handle Handle to interactable shape or zero
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerInteractShape
function GetPlayerInteractShape() end

---@return integer handle Handle to interactable body or zero
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerInteractBody
function GetPlayerInteractBody() end

---@param handle integer Handle to screen or zero for no screen
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerScreen
function SetPlayerScreen(handle) end

---@return integer handle Handle to interacted screen or zero if none
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerScreen
function GetPlayerScreen() end

---@param health number Set player health (between zero and one)
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerHealth
function SetPlayerHealth(health) end

---@return number health Current player health
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerHealth
function GetPlayerHealth() end

---@see @https://www.teardowngame.com/modding/api.html#RespawnPlayer
function RespawnPlayer() end

---@param id string Tool unique identifier
---@param name string Tool name to show in hud
---@param file string Path to vox file
---@param group number|nil Tool group for this tool (1-6) Default is 6.
---@see @https://www.teardowngame.com/modding/api.html#RegisterTool
function RegisterTool(id, name, file, group) end

---@return integer handle Handle to currently visible tool body or zero if none
---@see @https://www.teardowngame.com/modding/api.html#GetToolBody
function GetToolBody() end

---@param transform TransformType Tool body transform
---@param sway number Tool sway amount. Default is 1.0.
---@see @https://www.teardowngame.com/modding/api.html#SetToolTransform
function SetToolTransform(transform, sway) end

---@param path string Path to ogg sound file
---@param nominalDistance number|nil The distance in meters this sound is recorded at. Affects attenuation, default is 10.0
---@return integer handle Sound handle
---@see @https://www.teardowngame.com/modding/api.html#LoadSound
function LoadSound(path, nominalDistance) end

---@param path string Path to ogg sound file
---@param nominalDistance number|nil The distance in meters this sound is recorded at. Affects attenuation, default is 10.0
---@return integer handle Loop handle
---@see @https://www.teardowngame.com/modding/api.html#LoadLoop
function LoadLoop(path, nominalDistance) end

---@param handle integer Sound handle
---@param pos VectorType|nil World position as vector. Default is player position.
---@param volume number|nil Playback volume. Default is 1.0
---@see @https://www.teardowngame.com/modding/api.html#PlaySound
function PlaySound(handle, pos, volume) end

---@param handle integer Loop handle
---@param pos VectorType|nil World position as vector. Default is player position.
---@param volume number|nil Playback volume. Default is 1.0
---@see @https://www.teardowngame.com/modding/api.html#PlayLoop
function PlayLoop(handle, pos, volume) end

---@param path string Music path
---@see @https://www.teardowngame.com/modding/api.html#PlayMusic
function PlayMusic(path) end

---@see @https://www.teardowngame.com/modding/api.html#StopMusic
function StopMusic() end

---@param path string Path to sprite. Must be PNG or JPG format.
---@return integer handle Sprite handle
---@see @https://www.teardowngame.com/modding/api.html#LoadSprite
function LoadSprite(path) end

---@param handle integer Sprite handle
---@param transform TransformType Transform
---@param width number Width in meters
---@param height number Height in meters
---@param r number|nil Red color. Default 1.0.
---@param g number|nil Green color. Default 1.0.
---@param b number|nil Blue color. Default 1.0.
---@param a number|nil Alpha. Default 1.0.
---@param depthTest boolean|nil Depth test enabled. Default false.
---@param additive boolean|nil Additive blending enabled. Default false.
---@see @https://www.teardowngame.com/modding/api.html#DrawSprite
function DrawSprite(handle, transform, width, height, r, g, b, a, depthTest, additive) end

---@param layers string Space separate list of layers
---@see @https://www.teardowngame.com/modding/api.html#QueryRequire
function QueryRequire(layers) end

---@param vehicle integer Vehicle handle
---@see @https://www.teardowngame.com/modding/api.html#QueryRejectVehicle
function QueryRejectVehicle(vehicle) end

---@param body integer Body handle
---@see @https://www.teardowngame.com/modding/api.html#QueryRejectBody
function QueryRejectBody(body) end

---@param shape integer Shape handle
---@see @https://www.teardowngame.com/modding/api.html#QueryRejectShape
function QueryRejectShape(shape) end

---@param origin VectorType Raycast origin as world space vector
---@param direction VectorType Unit length raycast direction as world space vector
---@param maxDist number Raycast maximum distance. Keep this as low as possible for good performance.
---@param radius number|nil Raycast thickness. Default zero.
---@param rejectTransparent boolean|nil Raycast through transparent materials. Default false.
---@return boolean hit True if raycast hit something
---@return number dist Hit distance from origin
---@return VectorType normal World space normal at hit point
---@return integer shape Handle to hit shape
---@see @https://www.teardowngame.com/modding/api.html#QueryRaycast
function QueryRaycast(origin, direction, maxDist, radius, rejectTransparent) end

---@param origin VectorType World space point
---@param maxDist number Maximum distance. Keep this as low as possible for good performance.
---@return boolean hit True if a point was found
---@return VectorType point World space closest point
---@return VectorType normal World space normal at closest point
---@return integer shape Handle to closest shape
---@see @https://www.teardowngame.com/modding/api.html#QueryClosestPoint
function QueryClosestPoint(origin, maxDist) end

---@param min VectorType Aabb minimum point
---@param max VectorType Aabb maximum point
---@return table<integer> list Indexed table with handles to all shapes in the aabb
---@see @https://www.teardowngame.com/modding/api.html#QueryAabbShapes
function QueryAabbShapes(min, max) end

---@param min VectorType Aabb minimum point
---@param max VectorType Aabb maximum point
---@return table<integer> list Indexed table with handles to all bodies in the aabb
---@see @https://www.teardowngame.com/modding/api.html#QueryAabbBodies
function QueryAabbBodies(min, max) end

---@param startValue VectorType World space start point
---@param endValue VectorType World space target point
---@param maxDist number|nil Maximum path length before giving up. Default is infinite.
---@param targetRadius number|nil Maximum allowed distance to target in meters. Default is 2.0
---@see @https://www.teardowngame.com/modding/api.html#QueryPath
function QueryPath(startValue, endValue, maxDist, targetRadius) end

---@see @https://www.teardowngame.com/modding/api.html#AbortPath
function AbortPath() end

---@return string state Current path planning state
---@see @https://www.teardowngame.com/modding/api.html#GetPathState
function GetPathState() end

---@return number length Length of last path planning result (in meters)
---@see @https://www.teardowngame.com/modding/api.html#GetPathLength
function GetPathLength() end

---@param dist number The distance along path. Should be between zero and result from GetPathLength()
---@return VectorType point The path point dist meters along the path
---@see @https://www.teardowngame.com/modding/api.html#GetPathPoint
function GetPathPoint(dist) end

---@return number volume Volume of loudest sound played last frame
---@return VectorType position World position of loudest sound played last frame
---@see @https://www.teardowngame.com/modding/api.html#GetLastSound
function GetLastSound() end

---@param point VectorType World point as vector
---@return boolean inWater True if point is in water
---@return number depth Depth of point into water, or zero if not in water
---@see @https://www.teardowngame.com/modding/api.html#IsPointInWater
function IsPointInWater(point) end

---@param point VectorType World point as vector
---@return VectorType vel Wind at provided position
---@see @https://www.teardowngame.com/modding/api.html#GetWindVelocity
function GetWindVelocity(point) end

---@see @https://www.teardowngame.com/modding/api.html#ParticleReset
function ParticleReset() end

---@param type string Type of particle. Can be 'smoke' or 'plain'.
---@see @https://www.teardowngame.com/modding/api.html#ParticleType
function ParticleType(type) end

---@param type integer Tile in the particle texture atlas (0-15)
---@see @https://www.teardowngame.com/modding/api.html#ParticleTile
function ParticleTile(type) end

---@param r0 number Red value
---@param g0 number Green value
---@param b0 number Blue value
---@param r1 number|nil Red value at end
---@param g1 number|nil Green value at end
---@param b1 number|nil Blue value at end
---@see @https://www.teardowngame.com/modding/api.html#ParticleColor
function ParticleColor(r0, g0, b0, r1, g1, b1) end

---@param r0 number Radius
---@param r1 number|nil End radius
---@param interpolation string|nil Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein number|nil Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout number|nil Fade out between t=fadeout and t=1. Default is one.
---@see @https://www.teardowngame.com/modding/api.html#ParticleRadius
function ParticleRadius(r0, r1, interpolation, fadein, fadeout) end

---@param a0 number Alpha (0.0 - 1.0)
---@param a1 number|nil End alpha (0.0 - 1.0)
---@param interpolation string|nil Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein number|nil Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout number|nil Fade out between t=fadeout and t=1. Default is one.
---@see @https://www.teardowngame.com/modding/api.html#ParticleAlpha
function ParticleAlpha(a0, a1, interpolation, fadein, fadeout) end

---@param g0 number Gravity
---@param g1 number|nil End gravity
---@param interpolation string|nil Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein number|nil Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout number|nil Fade out between t=fadeout and t=1. Default is one.
---@see @https://www.teardowngame.com/modding/api.html#ParticleGravity
function ParticleGravity(g0, g1, interpolation, fadein, fadeout) end

---@param d0 number Drag
---@param d1 number|nil End drag
---@param interpolation string|nil Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein number|nil Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout number|nil Fade out between t=fadeout and t=1. Default is one.
---@see @https://www.teardowngame.com/modding/api.html#ParticleDrag
function ParticleDrag(d0, d1, interpolation, fadein, fadeout) end

---@param d0 number Emissive
---@param d1 number|nil End emissive
---@param interpolation string|nil Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein number|nil Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout number|nil Fade out between t=fadeout and t=1. Default is one.
---@see @https://www.teardowngame.com/modding/api.html#ParticleEmissive
function ParticleEmissive(d0, d1, interpolation, fadein, fadeout) end

---@param r0 number Rotation speed in radians per second.
---@param r1 number|nil End rotation speed in radians per second.
---@param interpolation string|nil Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein number|nil Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout number|nil Fade out between t=fadeout and t=1. Default is one.
---@see @https://www.teardowngame.com/modding/api.html#ParticleRotation
function ParticleRotation(r0, r1, interpolation, fadein, fadeout) end

---@param s0 number Stretch
---@param s1 number|nil End stretch
---@param interpolation string|nil Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein number|nil Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout number|nil Fade out between t=fadeout and t=1. Default is one.
---@see @https://www.teardowngame.com/modding/api.html#ParticleStretch
function ParticleStretch(s0, s1, interpolation, fadein, fadeout) end

---@param s0 number Sticky (0.0 - 1.0)
---@param s1 number|nil End sticky (0.0 - 1.0)
---@param interpolation string|nil Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein number|nil Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout number|nil Fade out between t=fadeout and t=1. Default is one.
---@see @https://www.teardowngame.com/modding/api.html#ParticleSticky
function ParticleSticky(s0, s1, interpolation, fadein, fadeout) end

---@param c0 number Collide (0.0 - 1.0)
---@param c1 number|nil End collide (0.0 - 1.0)
---@param interpolation string|nil Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein number|nil Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout number|nil Fade out between t=fadeout and t=1. Default is one.
---@see @https://www.teardowngame.com/modding/api.html#ParticleCollide
function ParticleCollide(c0, c1, interpolation, fadein, fadeout) end

---@param bitmask number Particle flags (bitmask 0-65535)
---@see @https://www.teardowngame.com/modding/api.html#ParticleFlags
function ParticleFlags(bitmask) end

---@param pos VectorType World space point as vector
---@param velocity VectorType World space velocity as vector
---@param lifetime number Particle lifetime in seconds
---@see @https://www.teardowngame.com/modding/api.html#SpawnParticle
function SpawnParticle(pos, velocity, lifetime) end

---@param xml string File name or xml string
---@param transform TransformType Spawn transform
---@param allowStatic boolean|nil Allow spawning static shapes and bodies (default false)
---@param jointExisting boolean|nil Allow joints to connect to existing scene geometry (default false)
---@return table<integer> entities Indexed table with handles to all spawned entities
---@see @https://www.teardowngame.com/modding/api.html#Spawn
function Spawn(xml, transform, allowStatic, jointExisting) end

---@param origin VectorType Origin in world space as vector
---@param direction VectorType Unit length direction as world space vector
---@param type string|nil Shot type, see description, default is 'bullet'
---@param strength number|nil Strength scaling, default is 1.0
---@param maxDist number|nil Maximum distance, default is 100.0
---@see @https://www.teardowngame.com/modding/api.html#Shoot
function Shoot(origin, direction, type, strength, maxDist) end

---@param origin VectorType Origin in world space as vector
---@param radius number Affected radius, in range 0.0 to 5.0
---@param type string|nil Paint type. Can be 'explosion' or 'spraycan'. Default is spraycan.
---@param probability number|nil Dithering probability between zero and one, default is 1.0
---@see @https://www.teardowngame.com/modding/api.html#Paint
function Paint(origin, radius, type, probability) end

---@param position VectorType Hole center point
---@param r0 number Hole radius for soft materials
---@param r1 number|nil Hole radius for medium materials. May not be bigger than r0. Default zero.
---@param r2 number|nil Hole radius for hard materials. May not be bigger than r1. Default zero.
---@param silent boolean|nil Make hole without playing any break sounds.
---@return number count Number of voxels that was cut out. This will be zero if there were no changes to any shape.
---@see @https://www.teardowngame.com/modding/api.html#MakeHole
function MakeHole(position, r0, r1, r2, silent) end

---@param pos VectorType Position in world space as vector
---@param size number Explosion size from 0.5 to 4.0
---@see @https://www.teardowngame.com/modding/api.html#Explosion
function Explosion(pos, size) end

---@param pos VectorType Position in world space as vector
---@see @https://www.teardowngame.com/modding/api.html#SpawnFire
function SpawnFire(pos) end

---@return number count Number of active fires in level
---@see @https://www.teardowngame.com/modding/api.html#GetFireCount
function GetFireCount() end

---@param origin VectorType World space position as vector
---@param maxDist number Maximum search distance
---@return boolean hit A fire was found within search distance
---@return VectorType pos Position of closest fire
---@see @https://www.teardowngame.com/modding/api.html#QueryClosestFire
function QueryClosestFire(origin, maxDist) end

---@param min VectorType Aabb minimum point
---@param max VectorType Aabb maximum point
---@return number count Number of active fires in bounding box
---@see @https://www.teardowngame.com/modding/api.html#QueryAabbFireCount
function QueryAabbFireCount(min, max) end

---@param min VectorType Aabb minimum point
---@param max VectorType Aabb maximum point
---@return number count Number of fires removed
---@see @https://www.teardowngame.com/modding/api.html#RemoveAabbFires
function RemoveAabbFires(min, max) end

---@return table transform Current camera transform
---@see @https://www.teardowngame.com/modding/api.html#GetCameraTransform
function GetCameraTransform() end

---@param transform table Desired camera transform
---@param fov number|nil Optional horizontal field of view in degrees (default: 90)
---@see @https://www.teardowngame.com/modding/api.html#SetCameraTransform
function SetCameraTransform(transform, fov) end

---@param degrees number Horizontal field of view in degrees (10-170)
---@see @https://www.teardowngame.com/modding/api.html#SetCameraFov
function SetCameraFov(degrees) end

---@param distance number Depth of field distance
---@param amount number|nil Optional amount of blur (default 1.0)
---@see @https://www.teardowngame.com/modding/api.html#SetCameraDof
function SetCameraDof(distance, amount) end

---@param pos table World space light position
---@param r number Red
---@param g number Green
---@param b number Blue
---@param intensity number|nil Intensity. Default is 1.0.
---@see @https://www.teardowngame.com/modding/api.html#PointLight
function PointLight(pos, r, g, b, intensity) end

---@param scale number Time scale 0.1 to 1.0
---@see @https://www.teardowngame.com/modding/api.html#SetTimeScale
function SetTimeScale(scale) end

---@see @https://www.teardowngame.com/modding/api.html#SetEnvironmentDefault
function SetEnvironmentDefault() end

---@param name string Property name
---@param value0 any Property value (type depends on property)
---@param value1 any|nil Extra property value (only some properties)
---@param value2 any|nil Extra property value (only some properties)
---@param value3 any|nil Extra property value (only some properties)
---@see @https://www.teardowngame.com/modding/api.html#SetEnvironmentProperty
function SetEnvironmentProperty(name, value0, value1, value2, value3) end

---@param name string Property name
---@return any value0 Property value (type depends on property)
---@return any value1 Property value (only some properties)
---@return any value2 Property value (only some properties)
---@return any value3 Property value (only some properties)
---@return any value4 Property value (only some properties)
---@see @https://www.teardowngame.com/modding/api.html#GetEnvironmentProperty
function GetEnvironmentProperty(name) end

---@see @https://www.teardowngame.com/modding/api.html#SetPostProcessingDefault
function SetPostProcessingDefault() end

---@param name string Property name
---@param value0 number Property value
---@param value1 number|nil Extra property value (only some properties)
---@param value2 number|nil Extra property value (only some properties)
---@see @https://www.teardowngame.com/modding/api.html#SetPostProcessingProperty
function SetPostProcessingProperty(name, value0, value1, value2) end

---@param name string Property name
---@return number value0 Property value
---@return number value1 Property value (only some properties)
---@return number value2 Property value (only some properties)
---@see @https://www.teardowngame.com/modding/api.html#GetPostProcessingProperty
function GetPostProcessingProperty(name) end

---@param p0 VectorType World space point as vector
---@param p1 VectorType World space point as vector
---@param r number|nil Red
---@param g number|nil Green
---@param b number|nil Blue
---@param a number|nil Alpha
---@see @https://www.teardowngame.com/modding/api.html#DrawLine
function DrawLine(p0, p1, r, g, b, a) end

---@param p0 VectorType World space point as vector
---@param p1 VectorType World space point as vector
---@param r number|nil Red
---@param g number|nil Green
---@param b number|nil Blue
---@param a number|nil Alpha
---@see @https://www.teardowngame.com/modding/api.html#DebugLine
function DebugLine(p0, p1, r, g, b, a) end

---@param p0 VectorType World space point as vector
---@param r number|nil Red
---@param g number|nil Green
---@param b number|nil Blue
---@param a number|nil Alpha
---@see @https://www.teardowngame.com/modding/api.html#DebugCross
function DebugCross(p0, r, g, b, a) end

---@param name string Name
---@param value string Value
---@see @https://www.teardowngame.com/modding/api.html#DebugWatch
function DebugWatch(name, value) end

---@param message string Message to display
---@see @https://www.teardowngame.com/modding/api.html#DebugPrint
function DebugPrint(message) end

---@see @https://www.teardowngame.com/modding/api.html#UiMakeInteractive
function UiMakeInteractive() end

---@see @https://www.teardowngame.com/modding/api.html#UiPush
function UiPush() end

---@see @https://www.teardowngame.com/modding/api.html#UiPop
function UiPop() end

---@return number width Width of draw context
---@see @https://www.teardowngame.com/modding/api.html#UiWidth
function UiWidth() end

---@return number height Height of draw context
---@see @https://www.teardowngame.com/modding/api.html#UiHeight
function UiHeight() end

---@return number center Half width of draw context
---@see @https://www.teardowngame.com/modding/api.html#UiCenter
function UiCenter() end

---@return number middle Half height of draw context
---@see @https://www.teardowngame.com/modding/api.html#UiMiddle
function UiMiddle() end

---@param r number Red channel
---@param g number Green channel
---@param b number Blue channel
---@param a number|nil Alpha channel. Default 1.0
---@see @https://www.teardowngame.com/modding/api.html#UiColor
function UiColor(r, g, b, a) end

---@param r number Red channel
---@param g number Green channel
---@param b number Blue channel
---@param a number|nil Alpha channel. Default 1.0
---@see @https://www.teardowngame.com/modding/api.html#UiColorFilter
function UiColorFilter(r, g, b, a) end

---@param x number X component
---@param y number Y component
---@see @https://www.teardowngame.com/modding/api.html#UiTranslate
function UiTranslate(x, y) end

---@param angle number Angle in degrees, counter clockwise
---@see @https://www.teardowngame.com/modding/api.html#UiRotate
function UiRotate(angle) end

---@param x number X component
---@param y number|nil Y component. Default value is x.
---@see @https://www.teardowngame.com/modding/api.html#UiScale
function UiScale(x, y) end

---@param width number Window width
---@param height number Window height
---@param clip boolean|nil Clip content outside window. Default is false.
---@param inherit boolean|nil Inherit current clip region (for nested clip regions)
---@see @https://www.teardowngame.com/modding/api.html#UiWindow
function UiWindow(width, height, clip, inherit) end

---@return number x0 Left
---@return number y0 Top
---@return number x1 Right
---@return number y1 Bottom
---@see @https://www.teardowngame.com/modding/api.html#UiSafeMargins
function UiSafeMargins() end

---@param alignment string Alignment keywords
---@see @https://www.teardowngame.com/modding/api.html#UiAlign
function UiAlign(alignment) end

---@see @https://www.teardowngame.com/modding/api.html#UiModalBegin
function UiModalBegin() end

---@see @https://www.teardowngame.com/modding/api.html#UiModalEnd
function UiModalEnd() end

---@see @https://www.teardowngame.com/modding/api.html#UiDisableInput
function UiDisableInput() end

---@see @https://www.teardowngame.com/modding/api.html#UiEnableInput
function UiEnableInput() end

---@return boolean receives True if current context receives input
---@see @https://www.teardowngame.com/modding/api.html#UiReceivesInput
function UiReceivesInput() end

---@return number x X coordinate
---@return number y Y coordinate
---@see @https://www.teardowngame.com/modding/api.html#UiGetMousePos
function UiGetMousePos() end

---@param w number Width
---@param h number Height
---@return boolean inside True if mouse pointer is within rectangle
---@see @https://www.teardowngame.com/modding/api.html#UiIsMouseInRect
function UiIsMouseInRect(w, h) end

---@param point VectorType 3D world position as vector
---@return number x X coordinate
---@return number y Y coordinate
---@return number distance Distance to point
---@see @https://www.teardowngame.com/modding/api.html#UiWorldToPixel
function UiWorldToPixel(point) end

---@param x number X coordinate
---@param y number Y coordinate
---@return VectorType direction 3D world direction as vector
---@see @https://www.teardowngame.com/modding/api.html#UiPixelToWorld
function UiPixelToWorld(x, y) end

---@param amount number Blur amount (0.0 to 1.0)
---@see @https://www.teardowngame.com/modding/api.html#UiBlur
function UiBlur(amount) end

---@param path string Path to TTF font file
---@param size number Font size (10 to 100)
---@see @https://www.teardowngame.com/modding/api.html#UiFont
function UiFont(path, size) end

---@return number size Font size
---@see @https://www.teardowngame.com/modding/api.html#UiFontHeight
function UiFontHeight() end

---@param text string Print text at cursor location
---@param move boolean|nil Automatically move cursor vertically. Default false.
---@return number w Width of text
---@return number h Height of text
---@see @https://www.teardowngame.com/modding/api.html#UiText
function UiText(text, move) end

---@param text string A text string
---@return number w Width of text
---@return number h Height of text
---@see @https://www.teardowngame.com/modding/api.html#UiGetTextSize
function UiGetTextSize(text) end

---@param width number Maximum width of text
---@see @https://www.teardowngame.com/modding/api.html#UiWordWrap
function UiWordWrap(width) end

---@param r number Red channel
---@param g number Green channel
---@param b number Blue channel
---@param a number Alpha channel
---@param thickness number|nil Outline thickness. Default is 0.1
---@see @https://www.teardowngame.com/modding/api.html#UiTextOutline
function UiTextOutline(r, g, b, a, thickness) end

---@param r number Red channel
---@param g number Green channel
---@param b number Blue channel
---@param a number Alpha channel
---@param distance number|nil Shadow distance. Default is 1.0
---@param blur number|nil Shadow blur. Default is 0.5
---@see @https://www.teardowngame.com/modding/api.html#UiTextShadow
function UiTextShadow(r, g, b, a, distance, blur) end

---@param w number Width
---@param h number Height
---@see @https://www.teardowngame.com/modding/api.html#UiRect
function UiRect(w, h) end

---@param path string Path to image (PNG or JPG format)
---@param x0 number|nil Lower x coordinate (default is 0)
---@param y0 number|nil Lower y coordinate (default is 0)
---@param x1 number|nil Upper x coordinate (default is image width)
---@param y1 number|nil Upper y coordinate (default is image height)
---@return number w Width of drawn image
---@return number h Height of drawn image
---@see @https://www.teardowngame.com/modding/api.html#UiImage
function UiImage(path, x0, y0, x1, y1) end

---@param path string Path to image (PNG or JPG format)
---@return number w Image width
---@return number h Image height
---@see @https://www.teardowngame.com/modding/api.html#UiGetImageSize
function UiGetImageSize(path) end

---@param path string Path to image (PNG or JPG format)
---@param width number Width
---@param height number Height
---@param borderWidth number Border width
---@param borderHeight number Border height
---@see @https://www.teardowngame.com/modding/api.html#UiImageBox
function UiImageBox(path, width, height, borderWidth, borderHeight) end

---@param path string Path to sound file (OGG format)
---@param volume number|nil Playback volume. Default 1.0
---@param pitch number|nil Playback pitch. Default 1.0
---@param pan number|nil Playback stereo panning (-1.0 to 1.0). Default 0.0.
---@see @https://www.teardowngame.com/modding/api.html#UiSound
function UiSound(path, volume, pitch, pan) end

---@param path string Path to looping sound file (OGG format)
---@param volume number|nil Playback volume. Default 1.0
---@see @https://www.teardowngame.com/modding/api.html#UiSoundLoop
function UiSoundLoop(path, volume) end

---@param amount number Mute by this amount (0.0 to 1.0)
---@param music boolean|nil Mute music as well
---@see @https://www.teardowngame.com/modding/api.html#UiMute
function UiMute(amount, music) end

---@param path string Path to image (PNG or JPG format)
---@param borderWidth number Border width
---@param borderHeight number Border height
---@param r number|nil Red multiply. Default 1.0
---@param g number|nil Green multiply. Default 1.0
---@param b number|nil Blue multiply. Default 1.0
---@param a number|nil Alpha channel. Default 1.0
---@see @https://www.teardowngame.com/modding/api.html#UiButtonImageBox
function UiButtonImageBox(path, borderWidth, borderHeight, r, g, b, a) end

---@param r number Red multiply
---@param g number Green multiply
---@param b number Blue multiply
---@param a number|nil Alpha channel. Default 1.0
---@see @https://www.teardowngame.com/modding/api.html#UiButtonHoverColor
function UiButtonHoverColor(r, g, b, a) end

---@param r number Red multiply
---@param g number Green multiply
---@param b number Blue multiply
---@param a number|nil Alpha channel. Default 1.0
---@see @https://www.teardowngame.com/modding/api.html#UiButtonPressColor
function UiButtonPressColor(r, g, b, a) end

---@param dist number Press distance
---@see @https://www.teardowngame.com/modding/api.html#UiButtonPressDist
function UiButtonPressDist(dist) end

---@param text string Text on button
---@param w number|nil Button width
---@param h number|nil Button height
---@return boolean pressed True if user clicked button
---@see @https://www.teardowngame.com/modding/api.html#UiTextButton
function UiTextButton(text, w, h) end

---@param path number Image path (PNG or JPG file)
---@return boolean pressed True if user clicked button
---@see @https://www.teardowngame.com/modding/api.html#UiImageButton
function UiImageButton(path) end

---@param w number Button width
---@param h number Button height
---@return boolean pressed True if user clicked button
---@see @https://www.teardowngame.com/modding/api.html#UiBlankButton
function UiBlankButton(w, h) end

---@param path number Image path (PNG or JPG file)
---@param axis string Drag axis, must be 'x' or 'y'
---@param current number Current value
---@param min number Minimum value
---@param max number Maximum value
---@return number value New value, same as current if not changed
---@return boolean done True if user is finished changing (released slider)
---@see @https://www.teardowngame.com/modding/api.html#UiSlider
function UiSlider(path, axis, current, min, max) end

---@return integer handle Handle to the screen running this script or zero if none.
---@see @https://www.teardowngame.com/modding/api.html#UiGetScreen
function UiGetScreen() end

