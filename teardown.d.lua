
--[[
Teardown uses Lua version 5.1 as scripting language.
The API can be found here: https://www.teardowngame.com/modding/api.html
The Lua 5.1 reference manual can be found here: https://www.lua.org/manual/5.1/

Created with HypnoTox's Teardown API Stub Generator, available at: https://github.com/hypnotox/teardown-api-stub-generator
]]

--[[ Classes ]]

---@class TVec:table
---@see @https://www.teardowngame.com/modding/api.html#Vec
local defaultVector = {0, 0, 0}

---@class TQuat:table
---@see @https://www.teardowngame.com/modding/api.html#Quat
local defaultQuaternion = {0, 0, 0, 0}

---@class TTransform:table
---@field pos TVec Vector representing transform position
---@field rot TQuat Quaternion representing transform rotation
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

---@param name string Parameter name
---@param default number Default parameter value
---@return number value Parameter value
---@see @https://www.teardowngame.com/modding/api.html#GetColorParam
function GetColorParam(name, default) end

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

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return string name Name of last pressed key, empty if no key is pressed
---@see @https://www.teardowngame.com/modding/api.html#InputLastPressedKey
function InputLastPressedKey(playerId) end

---@param input string The input identifier
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean pressed True if input was pressed during last frame
---@see @https://www.teardowngame.com/modding/api.html#InputPressed
function InputPressed(input, playerId) end

---@param input string The input identifier
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean pressed True if input was released during last frame
---@see @https://www.teardowngame.com/modding/api.html#InputReleased
function InputReleased(input, playerId) end

---@param input string The input identifier
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean pressed True if input is currently held down
---@see @https://www.teardowngame.com/modding/api.html#InputDown
function InputDown(input, playerId) end

---@param input string The input identifier
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number value Depends on input type
---@see @https://www.teardowngame.com/modding/api.html#InputValue
function InputValue(input, playerId) end

---Client only.
---@see @https://www.teardowngame.com/modding/api.html#InputClear
function InputClear() end

---Client only.
---@see @https://www.teardowngame.com/modding/api.html#InputResetOnTransition
function InputResetOnTransition() end

---@return number value Last device id
---@see @https://www.teardowngame.com/modding/api.html#LastInputDevice
function LastInputDevice() end

---@param variable string Name of number variable in the global context
---@param value number The new value
---@param transition string|nil Transition type. See description.
---@param time number|nil Transition time (seconds)
---@see @https://www.teardowngame.com/modding/api.html#SetValue
function SetValue(variable, value, transition, time) end

---@param tableId table Id of the table
---@param memberName string Name of the member
---@param newValue number New value
---@param type string Transition type
---@param length number Transition length
---@see @https://www.teardowngame.com/modding/api.html#SetValueInTable
function SetValueInTable(tableId, memberName, newValue, type, length) end

---@param title string Text on button
---@param location string|nil Button location. If 'bottom_bar' - bottom bar, if 'main_bottom' - below 'Main menu' button, if 'main_top' - above 'Main menu' button. Default 'bottom_bar'.
---@param disabled boolean|nil Disable button. Button will be rendered as grayed out. Default is false. Only available when used with 'bottom_bar'.
---@return boolean clicked True if clicked, false otherwise
---@see @https://www.teardowngame.com/modding/api.html#PauseMenuButton
function PauseMenuButton(title, location, disabled) end

---@param path string Path to file
---@return boolean exists True if file exists
---@see @https://www.teardowngame.com/modding/api.html#HasFile
function HasFile(path) end

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

---@param playerId number Player ID of the recipient. Use 0 to broadcast to every player.
---@param fn string Name of the function to be invoked. This function must exist within issuing script.
---@param ... any|nil Optional parameters to send to the recipent(s). Arguments should match the signature of the specified function.
---@see @https://www.teardowngame.com/modding/api.html#ClientCall
function ClientCall(playerId, fn, ...) end

---@param fn string Name of the function to be invoked. This function must exist within issuing script.
---@param ... any|nil Optional parameters to send to the server. Arguments should match the signature of the specified function.
---@see @https://www.teardowngame.com/modding/api.html#ServerCall
function ServerCall(fn, ...) end

---@param key string Registry key to clear
---@see @https://www.teardowngame.com/modding/api.html#ClearKey
function ClearKey(key) end

---@param parent string The parent registry key
---@return table children Indexed table of strings with child keys
---@see @https://www.teardowngame.com/modding/api.html#ListKeys
function ListKeys(parent) end

---@param key string Registry key
---@return boolean exists True if key exists
---@see @https://www.teardowngame.com/modding/api.html#HasKey
function HasKey(key) end

---@param key string Registry key
---@param value number Desired value
---@param sync boolean|nil Synchronize to clients
---@see @https://www.teardowngame.com/modding/api.html#SetInt
function SetInt(key, value, sync) end

---@param key string Registry key
---@return number value Integer value of registry node or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#GetInt
function GetInt(key) end

---@param key string Registry key
---@param value number Desired value
---@param sync boolean|nil Synchronize to clients
---@see @https://www.teardowngame.com/modding/api.html#SetFloat
function SetFloat(key, value, sync) end

---@param key string Registry key
---@return number value Float value of registry node or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#GetFloat
function GetFloat(key) end

---@param key string Registry key
---@param value boolean Desired value
---@param sync boolean|nil Synchronize to clients
---@see @https://www.teardowngame.com/modding/api.html#SetBool
function SetBool(key, value, sync) end

---@param key string Registry key
---@return boolean value Boolean value of registry node or false if not found
---@see @https://www.teardowngame.com/modding/api.html#GetBool
function GetBool(key) end

---@param key string Registry key
---@param value string Desired value
---@param sync boolean|nil Synchronize to clients
---@see @https://www.teardowngame.com/modding/api.html#SetString
function SetString(key, value, sync) end

---@param key string Registry key
---@return string value String value of registry node or '' if not found
---@see @https://www.teardowngame.com/modding/api.html#GetString
function GetString(key) end

---@param key string Registry key
---@param r number Desired red channel value
---@param g number Desired green channel value
---@param b number Desired blue channel value
---@param a number|nil Desired alpha channel value
---@see @https://www.teardowngame.com/modding/api.html#SetColor
function SetColor(key, r, g, b, a) end

---@param key string Registry key
---@return number r Desired red channel value
---@return number g Desired green channel value
---@return number b Desired blue channel value
---@return number a Desired alpha channel value
---@see @https://www.teardowngame.com/modding/api.html#GetColor
function GetColor(key) end

---@param key string Translation key
---@param default string|nil Default value
---@return string value Translation
---@see @https://www.teardowngame.com/modding/api.html#GetTranslatedStringByKey
function GetTranslatedStringByKey(key, default) end

---@param key string Translation key
---@return boolean value True if translation exists
---@see @https://www.teardowngame.com/modding/api.html#HasTranslationByKey
function HasTranslationByKey(key) end

---@param id number Language id (enum)
---@see @https://www.teardowngame.com/modding/api.html#LoadLanguageTable
function LoadLanguageTable(id) end

---@param id number|nil User id
---@return string value User nickname
---@see @https://www.teardowngame.com/modding/api.html#GetUserNickname
function GetUserNickname(id) end

---@param type string Event type
---@return number value Number of event available
---@see @https://www.teardowngame.com/modding/api.html#GetEventCount
function GetEventCount(type) end

---@param eventName string Event name
---@param ... any|nil Optional parameters to send with the event.
---@see @https://www.teardowngame.com/modding/api.html#PostEvent
function PostEvent(eventName, ...) end

---@param type string Event type
---@param index number Event index (starting with one)
---@return any returnValues Return values depending on event type
---@see @https://www.teardowngame.com/modding/api.html#GetEvent
function GetEvent(type, index) end

---@param x number|nil X value
---@param y number|nil Y value
---@param z number|nil Z value
---@return TVec vec New vector
---@see @https://www.teardowngame.com/modding/api.html#Vec
function Vec(x, y, z) end

---@param org TVec A vector
---@return TVec new Copy of org vector
---@see @https://www.teardowngame.com/modding/api.html#VecCopy
function VecCopy(org) end

---@param vector TVec Vector
---@return string str String representation
---@see @https://www.teardowngame.com/modding/api.html#VecStr
function VecStr(vector) end

---@param vec TVec A vector
---@return number length Length (magnitude) of the vector
---@see @https://www.teardowngame.com/modding/api.html#VecLength
function VecLength(vec) end

---@param vec TVec A vector
---@return TVec norm A vector of length 1.0
---@see @https://www.teardowngame.com/modding/api.html#VecNormalize
function VecNormalize(vec) end

---@param vec TVec A vector
---@param scale number A scale factor
---@return TVec norm A scaled version of input vector
---@see @https://www.teardowngame.com/modding/api.html#VecScale
function VecScale(vec, scale) end

---@param a TVec Vector
---@param b TVec Vector
---@return TVec c New vector with sum of a and b
---@see @https://www.teardowngame.com/modding/api.html#VecAdd
function VecAdd(a, b) end

---@param a TVec Vector
---@param b TVec Vector
---@return TVec c New vector representing a-b
---@see @https://www.teardowngame.com/modding/api.html#VecSub
function VecSub(a, b) end

---@param a TVec Vector
---@param b TVec Vector
---@return number c Dot product of a and b
---@see @https://www.teardowngame.com/modding/api.html#VecDot
function VecDot(a, b) end

---@param a TVec Vector
---@param b TVec Vector
---@return TVec c Cross product of a and b (also called vector product)
---@see @https://www.teardowngame.com/modding/api.html#VecCross
function VecCross(a, b) end

---@param a TVec Vector
---@param b TVec Vector
---@param t number fraction (usually between 0.0 and 1.0)
---@return TVec c Linearly interpolated vector between a and b, using t
---@see @https://www.teardowngame.com/modding/api.html#VecLerp
function VecLerp(a, b, t) end

---@param x number|nil X value
---@param y number|nil Y value
---@param z number|nil Z value
---@param w number|nil W value
---@return TQuat quat New quaternion
---@see @https://www.teardowngame.com/modding/api.html#Quat
function Quat(x, y, z, w) end

---@param org TQuat Quaternion
---@return TQuat new Copy of org quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatCopy
function QuatCopy(org) end

---@param axis TVec Rotation axis, unit vector
---@param angle number Rotation angle in degrees
---@return TQuat quat New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatAxisAngle
function QuatAxisAngle(axis, angle) end

---@param normal0 TVec Unit vector
---@param normal1 TVec Unit vector
---@return TQuat quat New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatDeltaNormals
function QuatDeltaNormals(normal0, normal1) end

---@param vector0 TVec Vector
---@param vector1 TVec Vector
---@return TQuat quat New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatDeltaVectors
function QuatDeltaVectors(vector0, vector1) end

---@param x number Angle around X axis in degrees, sometimes also called roll or bank
---@param y number Angle around Y axis in degrees, sometimes also called yaw or heading
---@param z number Angle around Z axis in degrees, sometimes also called pitch or attitude
---@return TQuat quat New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatEuler
function QuatEuler(x, y, z) end

---@param xAxis TVec X axis
---@param zAxis TVec Z axis
---@return TQuat quat Quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatAlignXZ
function QuatAlignXZ(xAxis, zAxis) end

---@param quat TQuat Quaternion
---@return number x Angle around X axis in degrees, sometimes also called roll or bank
---@return number y Angle around Y axis in degrees, sometimes also called yaw or heading
---@return number z Angle around Z axis in degrees, sometimes also called pitch or attitude
---@see @https://www.teardowngame.com/modding/api.html#GetQuatEuler
function GetQuatEuler(quat) end

---@param eye TVec Vector representing the camera location
---@param target TVec Vector representing the point to look at
---@return TQuat quat New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatLookAt
function QuatLookAt(eye, target) end

---@param a TQuat Quaternion
---@param b TQuat Quaternion
---@param t number fraction (usually between 0.0 and 1.0)
---@return TQuat c New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatSlerp
function QuatSlerp(a, b, t) end

---@param quat TQuat Quaternion
---@return string str String representation
---@see @https://www.teardowngame.com/modding/api.html#QuatStr
function QuatStr(quat) end

---@param a TQuat Quaternion
---@param b TQuat Quaternion
---@return TQuat c New quaternion
---@see @https://www.teardowngame.com/modding/api.html#QuatRotateQuat
function QuatRotateQuat(a, b) end

---@param a TQuat Quaternion
---@param vec TVec Vector
---@return TVec vec Rotated vector
---@see @https://www.teardowngame.com/modding/api.html#QuatRotateVec
function QuatRotateVec(a, vec) end

---@param pos TVec|nil Vector representing transform position
---@param rot TQuat|nil Quaternion representing transform rotation
---@return TTransform transform New transform
---@see @https://www.teardowngame.com/modding/api.html#Transform
function Transform(pos, rot) end

---@param org TTransform Transform
---@return TTransform new Copy of org transform
---@see @https://www.teardowngame.com/modding/api.html#TransformCopy
function TransformCopy(org) end

---@param transform TTransform Transform
---@return string str String representation
---@see @https://www.teardowngame.com/modding/api.html#TransformStr
function TransformStr(transform) end

---@param parent TTransform Transform
---@param child TTransform Transform
---@return TTransform transform New transform
---@see @https://www.teardowngame.com/modding/api.html#TransformToParentTransform
function TransformToParentTransform(parent, child) end

---@param parent TTransform Transform
---@param child TTransform Transform
---@return TTransform transform New transform
---@see @https://www.teardowngame.com/modding/api.html#TransformToLocalTransform
function TransformToLocalTransform(parent, child) end

---@param t TTransform Transform
---@param v TVec Vector
---@return TVec r Transformed vector
---@see @https://www.teardowngame.com/modding/api.html#TransformToParentVec
function TransformToParentVec(t, v) end

---@param t TTransform Transform
---@param v TVec Vector
---@return TVec r Transformed vector
---@see @https://www.teardowngame.com/modding/api.html#TransformToLocalVec
function TransformToLocalVec(t, v) end

---@param t TTransform Transform
---@param p TVec Vector representing position
---@return TVec r Transformed position
---@see @https://www.teardowngame.com/modding/api.html#TransformToParentPoint
function TransformToParentPoint(t, p) end

---@param t TTransform Transform
---@param p TVec Vector representing position
---@return TVec r Transformed position
---@see @https://www.teardowngame.com/modding/api.html#TransformToLocalPoint
function TransformToLocalPoint(t, p) end

---@param seed number Random seed
---@see @https://www.teardowngame.com/modding/api.html#SetRandomSeed
function SetRandomSeed(seed) end

---@return boolean result Random true/false
---@see @https://www.teardowngame.com/modding/api.html#GetRandomBool
function GetRandomBool() end

---@param min number Lower number
---@param max number Upper number
---@return number result Random number in given range, including max.
---@see @https://www.teardowngame.com/modding/api.html#GetRandomInt
function GetRandomInt(min, max) end

---@param min number Lower number
---@param max number Upper number
---@return number result Random number in given range, including max.
---@see @https://www.teardowngame.com/modding/api.html#GetRandomFloat
function GetRandomFloat(min, max) end

---@param length number|nil Optional length use to scale the generated direction.
---@return TVec vector Random direction with unit length
---@see @https://www.teardowngame.com/modding/api.html#GetRandomDirection
function GetRandomDirection(length) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@param type string|nil Entity type ('body', 'shape', 'light', 'location' etc.)
---@return number handle Handle to first entity with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindEntity
function FindEntity(tag, global, type) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@param type string|nil Entity type ('body', 'shape', 'light', 'location' etc.)
---@return table list Indexed table with handles to all entities with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindEntities
function FindEntities(tag, global, type) end

---@param handle number Entity handle
---@param tag string|nil Tag name
---@param recursive boolean|nil Search recursively
---@param type string|nil Entity type ('body', 'shape', 'light', 'location' etc.)
---@return table list Indexed table with child elements of the entity
---@see @https://www.teardowngame.com/modding/api.html#GetEntityChildren
function GetEntityChildren(handle, tag, recursive, type) end

---@param handle number Entity handle
---@param tag string|nil Tag name
---@param type string|nil Entity type ('body', 'shape', 'light', 'location' etc.)
---@return number handle 
---@see @https://www.teardowngame.com/modding/api.html#GetEntityParent
function GetEntityParent(handle, tag, type) end

---@param handle number Entity handle
---@param tag string Tag name
---@param value string|nil Tag value
---@see @https://www.teardowngame.com/modding/api.html#SetTag
function SetTag(handle, tag, value) end

---@param handle number Entity handle
---@param tag string Tag name
---@see @https://www.teardowngame.com/modding/api.html#RemoveTag
function RemoveTag(handle, tag) end

---@param handle number Entity handle
---@param tag string Tag name
---@return boolean exists Returns true if entity has tag
---@see @https://www.teardowngame.com/modding/api.html#HasTag
function HasTag(handle, tag) end

---@param handle number Entity handle
---@param tag string Tag name
---@return string value Returns the tag value, if any. Empty string otherwise.
---@see @https://www.teardowngame.com/modding/api.html#GetTagValue
function GetTagValue(handle, tag) end

---@param handle number Entity handle
---@return table tags Indexed table of tags on entity
---@see @https://www.teardowngame.com/modding/api.html#ListTags
function ListTags(handle) end

---@param handle number Entity handle
---@return string description The description string
---@see @https://www.teardowngame.com/modding/api.html#GetDescription
function GetDescription(handle) end

---@param handle number Entity handle
---@param description string The description string
---@see @https://www.teardowngame.com/modding/api.html#SetDescription
function SetDescription(handle, description) end

---@param handle number Entity handle
---@see @https://www.teardowngame.com/modding/api.html#Delete
function Delete(handle) end

---@param handle number Entity handle
---@return boolean exists Returns true if the entity pointed to by handle still exists
---@see @https://www.teardowngame.com/modding/api.html#IsHandleValid
function IsHandleValid(handle) end

---@param handle number Entity handle
---@return string type Type name of the provided entity
---@see @https://www.teardowngame.com/modding/api.html#GetEntityType
function GetEntityType(handle) end

---@param handle number Entity handle
---@param property string Property name
---@return any value Property value
---@see @https://www.teardowngame.com/modding/api.html#GetProperty
function GetProperty(handle, property) end

---@param handle number Entity handle
---@param property string Property name
---@param value any Property value
---@see @https://www.teardowngame.com/modding/api.html#SetProperty
function SetProperty(handle, property, value) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return number handle Handle to first body with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindBody
function FindBody(tag, global) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return table list Indexed table with handles to all bodies with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindBodies
function FindBodies(tag, global) end

---@param handle number Body handle
---@return TTransform transform Transform of the body
---@see @https://www.teardowngame.com/modding/api.html#GetBodyTransform
function GetBodyTransform(handle) end

---@param handle number Body handle
---@param transform TTransform Desired transform
---@see @https://www.teardowngame.com/modding/api.html#SetBodyTransform
function SetBodyTransform(handle, transform) end

---@param handle number Body handle
---@return number mass Body mass. Static bodies always return zero mass.
---@see @https://www.teardowngame.com/modding/api.html#GetBodyMass
function GetBodyMass(handle) end

---@param handle number Body handle
---@return boolean dynamic Return true if body is dynamic
---@see @https://www.teardowngame.com/modding/api.html#IsBodyDynamic
function IsBodyDynamic(handle) end

---@param handle number Body handle
---@param dynamic boolean True for dynamic. False for static.
---@see @https://www.teardowngame.com/modding/api.html#SetBodyDynamic
function SetBodyDynamic(handle, dynamic) end

---@param handle number Body handle (should be a dynamic body)
---@param velocity TVec Vector with linear velocity
---@see @https://www.teardowngame.com/modding/api.html#SetBodyVelocity
function SetBodyVelocity(handle, velocity) end

---@param handle number Body handle (should be a dynamic body)
---@return TVec velocity Linear velocity as vector
---@see @https://www.teardowngame.com/modding/api.html#GetBodyVelocity
function GetBodyVelocity(handle) end

---@param handle number Body handle (should be a dynamic body)
---@param pos TVec World space point as vector
---@return TVec velocity Linear velocity on body at pos as vector
---@see @https://www.teardowngame.com/modding/api.html#GetBodyVelocityAtPos
function GetBodyVelocityAtPos(handle, pos) end

---@param handle number Body handle (should be a dynamic body)
---@param angVel TVec Vector with angular velocity
---@see @https://www.teardowngame.com/modding/api.html#SetBodyAngularVelocity
function SetBodyAngularVelocity(handle, angVel) end

---@param handle number Body handle (should be a dynamic body)
---@return TVec angVel Angular velocity as vector
---@see @https://www.teardowngame.com/modding/api.html#GetBodyAngularVelocity
function GetBodyAngularVelocity(handle) end

---@param handle number Body handle
---@return boolean active Return true if body is active
---@see @https://www.teardowngame.com/modding/api.html#IsBodyActive
function IsBodyActive(handle) end

---@param handle number Body handle
---@param active boolean Set to tru if body should be active (simulated)
---@see @https://www.teardowngame.com/modding/api.html#SetBodyActive
function SetBodyActive(handle, active) end

---@param handle number Body handle (should be a dynamic body)
---@param position TVec World space position as vector
---@param impulse TVec World space impulse as vector
---@see @https://www.teardowngame.com/modding/api.html#ApplyBodyImpulse
function ApplyBodyImpulse(handle, position, impulse) end

---@param handle number Body handle
---@return table list Indexed table of shape handles
---@see @https://www.teardowngame.com/modding/api.html#GetBodyShapes
function GetBodyShapes(handle) end

---@param body number Body handle
---@return number handle Get parent vehicle for body, or zero if not part of vehicle
---@see @https://www.teardowngame.com/modding/api.html#GetBodyVehicle
function GetBodyVehicle(body) end

---@param body number Body handle
---@return number handle Get parent animator for body, or zero if not part of an animator hierarchy
---@see @https://www.teardowngame.com/modding/api.html#GetBodyAnimator
function GetBodyAnimator(body) end

---@param body number Body handle
---@return number playerId Get parent player for body, or zero if not part of a player animator hierarchy
---@see @https://www.teardowngame.com/modding/api.html#GetBodyPlayer
function GetBodyPlayer(body) end

---@param handle number Body handle
---@return TVec min Vector representing the AABB lower bound
---@return TVec max Vector representing the AABB upper bound
---@see @https://www.teardowngame.com/modding/api.html#GetBodyBounds
function GetBodyBounds(handle) end

---@param handle number Body handle
---@return TVec point Vector representing local center of mass in body space
---@see @https://www.teardowngame.com/modding/api.html#GetBodyCenterOfMass
function GetBodyCenterOfMass(handle) end

---@param handle number Body handle
---@param maxDist number Maximum visible distance
---@param rejectTransparent boolean|nil See through transparent materials. Default false.
---@param playerId number|nil Player ID. On player, zero means local player.
---@return boolean visible Return true if body is visible
---@see @https://www.teardowngame.com/modding/api.html#IsBodyVisible
function IsBodyVisible(handle, maxDist, rejectTransparent, playerId) end

---@param handle number Body handle
---@return boolean broken Return true if body is broken
---@see @https://www.teardowngame.com/modding/api.html#IsBodyBroken
function IsBodyBroken(handle) end

---@param handle number Body handle
---@return boolean result Return true if body is in any way connected to a static body
---@see @https://www.teardowngame.com/modding/api.html#IsBodyJointedToStatic
function IsBodyJointedToStatic(handle) end

---@param handle number Body handle
---@param r number|nil Red
---@param g number|nil Green
---@param b number|nil Blue
---@param a number|nil Alpha
---@see @https://www.teardowngame.com/modding/api.html#DrawBodyOutline
function DrawBodyOutline(handle, r, g, b, a) end

---@param handle number Body handle
---@param amount number Amount
---@see @https://www.teardowngame.com/modding/api.html#DrawBodyHighlight
function DrawBodyHighlight(handle, amount) end

---@param body number Body handle
---@param origin TVec World space point
---@return boolean hit True if a point was found
---@return TVec point World space closest point
---@return TVec normal World space normal at closest point
---@return number shape Handle to closest shape
---@see @https://www.teardowngame.com/modding/api.html#GetBodyClosestPoint
function GetBodyClosestPoint(body, origin) end

---@param bodyA number First body handle (zero for static)
---@param bodyB number Second body handle (zero for static)
---@param point TVec World space point
---@param dir TVec World space direction
---@param relVel number Desired relative velocity along the provided direction
---@param min number|nil Minimum impulse (default: -infinity)
---@param max number|nil Maximum impulse (default: infinity)
---@see @https://www.teardowngame.com/modding/api.html#ConstrainVelocity
function ConstrainVelocity(bodyA, bodyB, point, dir, relVel, min, max) end

---@param bodyA number First body handle (zero for static)
---@param bodyB number Second body handle (zero for static)
---@param dir TVec World space direction
---@param relAngVel number Desired relative angular velocity along the provided direction
---@param min number|nil Minimum angular impulse (default: -infinity)
---@param max number|nil Maximum angular impulse (default: infinity)
---@see @https://www.teardowngame.com/modding/api.html#ConstrainAngularVelocity
function ConstrainAngularVelocity(bodyA, bodyB, dir, relAngVel, min, max) end

---@param bodyA number First body handle (zero for static)
---@param bodyB number Second body handle (zero for static)
---@param pointA TVec World space point for first body
---@param pointB TVec World space point for second body
---@param maxVel number|nil Maximum relative velocity (default: infinite)
---@param maxImpulse number|nil Maximum impulse (default: infinite)
---@see @https://www.teardowngame.com/modding/api.html#ConstrainPosition
function ConstrainPosition(bodyA, bodyB, pointA, pointB, maxVel, maxImpulse) end

---@param bodyA number First body handle (zero for static)
---@param bodyB number Second body handle (zero for static)
---@param quatA TQuat World space orientation for first body
---@param quatB TQuat World space orientation for second body
---@param maxAngVel number|nil Maximum relative angular velocity (default: infinite)
---@param maxAngImpulse number|nil Maximum angular impulse (default: infinite)
---@see @https://www.teardowngame.com/modding/api.html#ConstrainOrientation
function ConstrainOrientation(bodyA, bodyB, quatA, quatB, maxAngVel, maxAngImpulse) end

---@return number body Handle to the static world body
---@see @https://www.teardowngame.com/modding/api.html#GetWorldBody
function GetWorldBody() end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return number handle Handle to first shape with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindShape
function FindShape(tag, global) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return table list Indexed table with handles to all shapes with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindShapes
function FindShapes(tag, global) end

---@param handle number Shape handle
---@return TTransform transform Return shape transform in body space
---@see @https://www.teardowngame.com/modding/api.html#GetShapeLocalTransform
function GetShapeLocalTransform(handle) end

---@param handle number Shape handle
---@param transform TTransform Shape transform in body space
---@see @https://www.teardowngame.com/modding/api.html#SetShapeLocalTransform
function SetShapeLocalTransform(handle, transform) end

---@param handle number Shape handle
---@return TTransform transform Return shape transform in world space
---@see @https://www.teardowngame.com/modding/api.html#GetShapeWorldTransform
function GetShapeWorldTransform(handle) end

---@param handle number Shape handle
---@return number handle Body handle
---@see @https://www.teardowngame.com/modding/api.html#GetShapeBody
function GetShapeBody(handle) end

---@param shape number Shape handle
---@return table list Indexed table with joints connected to shape
---@see @https://www.teardowngame.com/modding/api.html#GetShapeJoints
function GetShapeJoints(shape) end

---@param shape number Shape handle
---@return table list Indexed table of lights owned by shape
---@see @https://www.teardowngame.com/modding/api.html#GetShapeLights
function GetShapeLights(shape) end

---@param handle number Shape handle
---@return TVec min Vector representing the AABB lower bound
---@return TVec max Vector representing the AABB upper bound
---@see @https://www.teardowngame.com/modding/api.html#GetShapeBounds
function GetShapeBounds(handle) end

---@param handle number Shape handle
---@param scale number Scale factor for emissiveness
---@see @https://www.teardowngame.com/modding/api.html#SetShapeEmissiveScale
function SetShapeEmissiveScale(handle, scale) end

---@param handle number Shape handle
---@param density number New density for the shape
---@see @https://www.teardowngame.com/modding/api.html#SetShapeDensity
function SetShapeDensity(handle, density) end

---@param handle number Shape handle
---@param pos TVec Position in world space
---@param includeUnphysical boolean|nil Include unphysical voxels in the search. Default false.
---@return string type Material type
---@return number r Red
---@return number g Green
---@return number b Blue
---@return number a Alpha
---@return number entry Palette entry for voxel (zero if empty)
---@see @https://www.teardowngame.com/modding/api.html#GetShapeMaterialAtPosition
function GetShapeMaterialAtPosition(handle, pos, includeUnphysical) end

---@param handle number Shape handle
---@param x number X integer coordinate
---@param y number Y integer coordinate
---@param z number Z integer coordinate
---@return string type Material type
---@return number r Red
---@return number g Green
---@return number b Blue
---@return number a Alpha
---@return number entry Palette entry for voxel (zero if empty)
---@see @https://www.teardowngame.com/modding/api.html#GetShapeMaterialAtIndex
function GetShapeMaterialAtIndex(handle, x, y, z) end

---@param handle number Shape handle
---@return number xsize Size in voxels along x axis
---@return number ysize Size in voxels along y axis
---@return number zsize Size in voxels along z axis
---@return number scale The size of one voxel in meters (with default scale it is 0.1)
---@see @https://www.teardowngame.com/modding/api.html#GetShapeSize
function GetShapeSize(handle) end

---@param handle number Shape handle
---@return number count Number of voxels in shape
---@see @https://www.teardowngame.com/modding/api.html#GetShapeVoxelCount
function GetShapeVoxelCount(handle) end

---@param handle number Shape handle
---@param maxDist number Maximum visible distance
---@param rejectTransparent boolean|nil See through transparent materials. Default false.
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server(host) player.
---@return boolean visible Return true if shape is visible
---@see @https://www.teardowngame.com/modding/api.html#IsShapeVisible
function IsShapeVisible(handle, maxDist, rejectTransparent, playerId) end

---@param handle number Shape handle
---@return boolean broken Return true if shape is broken
---@see @https://www.teardowngame.com/modding/api.html#IsShapeBroken
function IsShapeBroken(handle) end

---@param handle number Shape handle
---@param r number|nil Red
---@param g number|nil Green
---@param b number|nil Blue
---@param a number Alpha
---@see @https://www.teardowngame.com/modding/api.html#DrawShapeOutline
function DrawShapeOutline(handle, r, g, b, a) end

---@param handle number Shape handle
---@param amount number Amount
---@see @https://www.teardowngame.com/modding/api.html#DrawShapeHighlight
function DrawShapeHighlight(handle, amount) end

---@param handle number Shape handle
---@param layer number Layer bits (0-255)
---@param mask number Mask bits (0-255)
---@see @https://www.teardowngame.com/modding/api.html#SetShapeCollisionFilter
function SetShapeCollisionFilter(handle, layer, mask) end

---@param handle number Shape handle
---@return number layer Layer bits (0-255)
---@return number mask Mask bits (0-255)
---@see @https://www.teardowngame.com/modding/api.html#GetShapeCollisionFilter
function GetShapeCollisionFilter(handle) end

---@param body number Body handle
---@param transform TTransform Shape transform in body space
---@param refShape string|number Handle to reference shape or path to vox file
---@return number newShape Handle of new shape
---@see @https://www.teardowngame.com/modding/api.html#CreateShape
function CreateShape(body, transform, refShape) end

---@param shape number Shape handle
---@see @https://www.teardowngame.com/modding/api.html#ClearShape
function ClearShape(shape) end

---@param shape number Shape handle
---@param xmi number Lower X coordinate
---@param ymi number Lower Y coordinate
---@param zmi number Lower Z coordinate
---@param xma number Upper X coordinate
---@param yma number Upper Y coordinate
---@param zma number Upper Z coordinate
---@return boolean resized Resized successfully
---@return TVec offset Offset vector in shape local space
---@see @https://www.teardowngame.com/modding/api.html#ResizeShape
function ResizeShape(shape, xmi, ymi, zmi, xma, yma, zma) end

---@param shape number Shape handle
---@param body number Body handle
---@param transform TTransform|nil New local shape transform. Default is existing local transform.
---@see @https://www.teardowngame.com/modding/api.html#SetShapeBody
function SetShapeBody(shape, body, transform) end

---@param src number Source shape handle
---@param dst number Destination shape handle
---@see @https://www.teardowngame.com/modding/api.html#CopyShapeContent
function CopyShapeContent(src, dst) end

---@param src number Source shape handle
---@param dst number Destination shape handle
---@see @https://www.teardowngame.com/modding/api.html#CopyShapePalette
function CopyShapePalette(src, dst) end

---@param shape number Shape handle
---@return table entries Palette material entries
---@see @https://www.teardowngame.com/modding/api.html#GetShapePalette
function GetShapePalette(shape) end

---@param shape number Shape handle
---@param entry number Material entry
---@return string type Type
---@return number red Red value
---@return number green Green value
---@return number blue Blue value
---@return number alpha Alpha value
---@return number reflectivity Range 0 to 1
---@return number shininess Range 0 to 1
---@return number metallic Range 0 to 1
---@return number emissive Range 0 to 32
---@see @https://www.teardowngame.com/modding/api.html#GetShapeMaterial
function GetShapeMaterial(shape, entry) end

---@param type string One of 'sphere', 'cube' or 'noise'
---@param size number Size of brush in voxels (must be in range 1 to 16)
---@param indexOrPath string|number Material index or path to brush vox file
---@param object string|nil Optional object in brush vox file if brush vox file is used
---@see @https://www.teardowngame.com/modding/api.html#SetBrush
function SetBrush(type, size, indexOrPath, object) end

---@param shape number Handle to shape
---@param x0 number Start X coordinate
---@param y0 number Start Y coordinate
---@param z0 number Start Z coordinate
---@param x1 number End X coordinate
---@param y1 number End Y coordinate
---@param z1 number End Z coordinate
---@param paint boolean|nil Paint mode. Default is false.
---@param noOverwrite boolean|nil Only fill in voxels if space isn't already occupied. Default is false.
---@see @https://www.teardowngame.com/modding/api.html#DrawShapeLine
function DrawShapeLine(shape, x0, y0, z0, x1, y1, z1, paint, noOverwrite) end

---@param shape number Handle to shape
---@param x0 number Start X coordinate
---@param y0 number Start Y coordinate
---@param z0 number Start Z coordinate
---@param x1 number End X coordinate
---@param y1 number End Y coordinate
---@param z1 number End Z coordinate
---@see @https://www.teardowngame.com/modding/api.html#DrawShapeBox
function DrawShapeBox(shape, x0, y0, z0, x1, y1, z1) end

---@param shape number Handle to shape
---@param x number X coordinate to extrude
---@param y number Y coordinate to extrude
---@param z number Z coordinate to extrude
---@param dx number X component of extrude direction, should be -1, 0 or 1
---@param dy number Y component of extrude direction, should be -1, 0 or 1
---@param dz number Z component of extrude direction, should be -1, 0 or 1
---@param steps number Length of extrusion in voxels
---@param mode string Extrusion mode, one of 'exact', 'material', 'geometry'. Default is 'exact'
---@see @https://www.teardowngame.com/modding/api.html#ExtrudeShape
function ExtrudeShape(shape, x, y, z, dx, dy, dz, steps, mode) end

---@param shape number Source handle
---@return TVec offset Offset vector in shape local space
---@see @https://www.teardowngame.com/modding/api.html#TrimShape
function TrimShape(shape) end

---@param shape number Source handle
---@param removeResidual boolean Remove residual shapes (default false)
---@return table newShapes List of shape handles created
---@see @https://www.teardowngame.com/modding/api.html#SplitShape
function SplitShape(shape, removeResidual) end

---@param shape number Input shape
---@return number shape Shape handle after merge
---@see @https://www.teardowngame.com/modding/api.html#MergeShape
function MergeShape(shape) end

---@param shape number Input shape
---@return boolean disconnected True if shape disconnected (has detached parts)
---@see @https://www.teardowngame.com/modding/api.html#IsShapeDisconnected
function IsShapeDisconnected(shape) end

---@param shape number Input shape
---@return boolean disconnected True if static shape has detached parts
---@see @https://www.teardowngame.com/modding/api.html#IsStaticShapeDetached
function IsStaticShapeDetached(shape) end

---@param shape number Shape handle
---@param origin TVec World space point
---@return boolean hit True if a point was found
---@return TVec point World space closest point
---@return TVec normal World space normal at closest point
---@see @https://www.teardowngame.com/modding/api.html#GetShapeClosestPoint
function GetShapeClosestPoint(shape, origin) end

---@param a number Handle to first shape
---@param b number Handle to second shape
---@return boolean touching True is shapes a and b are touching each other
---@see @https://www.teardowngame.com/modding/api.html#IsShapeTouching
function IsShapeTouching(a, b) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return number handle Handle to first location with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindLocation
function FindLocation(tag, global) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return table list Indexed table with handles to all locations with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindLocations
function FindLocations(tag, global) end

---@param handle number Location handle
---@return TTransform transform Transform of the location
---@see @https://www.teardowngame.com/modding/api.html#GetLocationTransform
function GetLocationTransform(handle) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return number handle Handle to first joint with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindJoint
function FindJoint(tag, global) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return table list Indexed table with handles to all joints with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindJoints
function FindJoints(tag, global) end

---@param joint number Joint handle
---@return boolean broken True if joint is broken
---@see @https://www.teardowngame.com/modding/api.html#IsJointBroken
function IsJointBroken(joint) end

---@param joint number Joint handle
---@return string type Joint type
---@see @https://www.teardowngame.com/modding/api.html#GetJointType
function GetJointType(joint) end

---@param joint number Joint handle
---@param shape number Shape handle
---@return number other Other shape handle
---@see @https://www.teardowngame.com/modding/api.html#GetJointOtherShape
function GetJointOtherShape(joint, shape) end

---@param joint number Joint handle
---@return number shapes Shape handles
---@see @https://www.teardowngame.com/modding/api.html#GetJointShapes
function GetJointShapes(joint) end

---@param joint number Joint handle
---@param velocity number Desired velocity
---@param strength number|nil Desired strength. Default is infinite. Zero to disable.
---@see @https://www.teardowngame.com/modding/api.html#SetJointMotor
function SetJointMotor(joint, velocity, strength) end

---@param joint number Joint handle
---@param target number Desired movement target
---@param maxVel number|nil Maximum velocity to reach target. Default is infinite.
---@param strength number|nil Desired strength. Default is infinite. Zero to disable.
---@see @https://www.teardowngame.com/modding/api.html#SetJointMotorTarget
function SetJointMotorTarget(joint, target, maxVel, strength) end

---@param joint number Joint handle
---@return number min Minimum joint limit (angle or distance)
---@return number max Maximum joint limit (angle or distance)
---@see @https://www.teardowngame.com/modding/api.html#GetJointLimits
function GetJointLimits(joint) end

---@param joint number Joint handle
---@return number movement Current joint position or angle
---@see @https://www.teardowngame.com/modding/api.html#GetJointMovement
function GetJointMovement(joint) end

---@param body number Body handle (must be dynamic)
---@return table bodies Handles to all dynamic bodies in the jointed structure. The input handle will also be included.
---@see @https://www.teardowngame.com/modding/api.html#GetJointedBodies
function GetJointedBodies(body) end

---@param joint number Joint handle
---@param shape number Shape handle
---@see @https://www.teardowngame.com/modding/api.html#DetachJointFromShape
function DetachJointFromShape(joint, shape) end

---@param joint number Joint handle
---@return number amount Number of points in a rope or zero if invalid
---@see @https://www.teardowngame.com/modding/api.html#GetRopeNumberOfPoints
function GetRopeNumberOfPoints(joint) end

---@param joint number Joint handle
---@param index number The point index, starting at 1
---@return TVec pos World position of the point, or nil, if invalid
---@see @https://www.teardowngame.com/modding/api.html#GetRopePointPosition
function GetRopePointPosition(joint, index) end

---@param joint number Joint handle
---@return TVec min Lower point of rope bounds in world space
---@return TVec max Upper point of rope bounds in world space
---@see @https://www.teardowngame.com/modding/api.html#GetRopeBounds
function GetRopeBounds(joint) end

---@param joint number Rope type joint handle
---@param point TVec Point of break as world space vector
---@see @https://www.teardowngame.com/modding/api.html#BreakRope
function BreakRope(joint, point) end

---@param handle number Animator handle
---@param begname string Name of the start-bone of the chain
---@param endname string Name of the end-bone of the chain
---@param target TVec World target position that the 'endname' bone should reach
---@param weight number|nil Weight [0,1] of this animation, default is 1.0
---@param history number|nil How much of the previous frames result [0,1] that should be used when start the IK search, default is 0.0
---@param flag boolean|nil TRUE if constraints should be used, default is TRUE
---@see @https://www.teardowngame.com/modding/api.html#SetAnimatorPositionIK
function SetAnimatorPositionIK(handle, begname, endname, target, weight, history, flag) end

---@param handle number Animator handle
---@param begname string Name of the start-bone of the chain
---@param endname string Name of the end-bone of the chain
---@param transform TTransform World target transform that the 'endname' bone should reach
---@param weight number|nil Weight [0,1] of this animation, default is 1.0
---@param history number|nil How much of the previous frames result [0,1] that should be used when start the IK search, default is 0.0
---@param locktarget boolean|nil TRUE if the end-bone should be fixed to the target-transform, FALSE if IK solution is used
---@param useconstraints boolean|nil TRUE if constraints should be used, default is TRUE
---@see @https://www.teardowngame.com/modding/api.html#SetAnimatorTransformIK
function SetAnimatorTransformIK(handle, begname, endname, transform, weight, history, locktarget, useconstraints) end

---@param handle number Animator handle
---@param begname string Name of the start-bone of the chain
---@param endname string Name of the end-bone of the chain
---@return number length Length of the bone chain between 'start-bone' and 'end-bone'
---@see @https://www.teardowngame.com/modding/api.html#GetBoneChainLength
function GetBoneChainLength(handle, begname, endname) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return number handle Handle to first animator with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindAnimator
function FindAnimator(tag, global) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return table list Indexed table with handles to all animators with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindAnimators
function FindAnimators(tag, global) end

---@param handle number Animator handle
---@return TTransform transform World space transform of the animator
---@see @https://www.teardowngame.com/modding/api.html#GetAnimatorTransform
function GetAnimatorTransform(handle) end

---@param handle number Animator handle
---@param name string Name of the location node
---@return TTransform transform World space transform of the animator
---@see @https://www.teardowngame.com/modding/api.html#GetAnimatorAdjustTransformIK
function GetAnimatorAdjustTransformIK(handle, name) end

---@param handle number Animator handle
---@param transform TTransform Desired transform
---@see @https://www.teardowngame.com/modding/api.html#SetAnimatorTransform
function SetAnimatorTransform(handle, transform) end

---@param handle number Animator handle
---@see @https://www.teardowngame.com/modding/api.html#MakeRagdoll
function MakeRagdoll(handle) end

---@param handle number Animator handle
---@param time number|nil Transition time
---@see @https://www.teardowngame.com/modding/api.html#UnRagdoll
function UnRagdoll(handle, time) end

---@param handle number Animator handle
---@param name string Animation name
---@param weight number|nil Weight [0,1] of this animation, default is 1.0
---@param filter string|nil Name of the bone and its subtree that will be affected
---@return number handle Handle to the instance that can be used with PlayAnimationInstance, zero if clip reached its end
---@see @https://www.teardowngame.com/modding/api.html#PlayAnimation
function PlayAnimation(handle, name, weight, filter) end

---@param handle number Animator handle
---@param name string Animation name
---@param weight number|nil Weight [0,1] of this animation, default is 1.0
---@param filter string|nil Name of the bone and its subtree that will be affected
---@see @https://www.teardowngame.com/modding/api.html#PlayAnimationLoop
function PlayAnimationLoop(handle, name, weight, filter) end

---@param handle number Animator handle
---@param instance number Instance handle
---@param weight number|nil Weight [0,1] of this animation, default is 1.0
---@param speed number|nil Weight [0,1] of this animation, default is 1.0
---@return number handle Handle to the instance that can be used with PlayAnimationInstance, zero if clip reached its end
---@see @https://www.teardowngame.com/modding/api.html#PlayAnimationInstance
function PlayAnimationInstance(handle, instance, weight, speed) end

---@param handle number Animator handle
---@param instance number Instance handle
---@see @https://www.teardowngame.com/modding/api.html#StopAnimationInstance
function StopAnimationInstance(handle, instance) end

---@param handle number Animator handle
---@param name string Animation name
---@param time number Time in the animation
---@param weight number|nil Weight [0,1] of this animation, default is 1.0
---@param filter string|nil Name of the bone and its subtree that will be affected
---@see @https://www.teardowngame.com/modding/api.html#PlayAnimationFrame
function PlayAnimationFrame(handle, name, time, weight, filter) end

---@param handle number Animator handle
---@param weight number|nil Weight [0,1] of this group, default is 1.0
---@param filter string|nil Name of the bone and its subtree that will be affected
---@see @https://www.teardowngame.com/modding/api.html#BeginAnimationGroup
function BeginAnimationGroup(handle, weight, filter) end

---@param handle number Animator handle
---@see @https://www.teardowngame.com/modding/api.html#EndAnimationGroup
function EndAnimationGroup(handle) end

---@param handle number Animator handle
---@see @https://www.teardowngame.com/modding/api.html#PlayAnimationInstances
function PlayAnimationInstances(handle) end

---@param handle number Animator handle
---@return table list Indexed table with animation names
---@see @https://www.teardowngame.com/modding/api.html#GetAnimationClipNames
function GetAnimationClipNames(handle) end

---@param handle number Animator handle
---@param name string Animation name
---@return number time Total duration of the animation
---@see @https://www.teardowngame.com/modding/api.html#GetAnimationClipDuration
function GetAnimationClipDuration(handle, name) end

---@param handle number Animator handle
---@param name string Animation name
---@param fadein number Fadein time of the animation
---@param fadeout number Fadeout time of the animation
---@see @https://www.teardowngame.com/modding/api.html#SetAnimationClipFade
function SetAnimationClipFade(handle, name, fadein, fadeout) end

---@param handle number Animator handle
---@param name string Animation name
---@param speed number Sets the speed factor of the animation
---@see @https://www.teardowngame.com/modding/api.html#SetAnimationClipSpeed
function SetAnimationClipSpeed(handle, name, speed) end

---@param handle number Animator handle
---@param name string Animation name
---@param begoffset number Time offset from the beginning of the animation
---@param endoffset number|nil Time offset, positive value means from the beginning and negative value means from the end, zero(default) means at end
---@see @https://www.teardowngame.com/modding/api.html#TrimAnimationClip
function TrimAnimationClip(handle, name, begoffset, endoffset) end

---@param handle number Animator handle
---@param name string Animation name
---@return number time Time of the current playposition in the animation
---@see @https://www.teardowngame.com/modding/api.html#GetAnimationClipLoopPosition
function GetAnimationClipLoopPosition(handle, name) end

---@param handle number Animator handle
---@param instance number Instance handle
---@return number time Time of the current playposition in the animation
---@see @https://www.teardowngame.com/modding/api.html#GetAnimationInstancePosition
function GetAnimationInstancePosition(handle, instance) end

---@param handle number Animator handle
---@param name string Animation name
---@param time number Time in the animation
---@see @https://www.teardowngame.com/modding/api.html#SetAnimationClipLoopPosition
function SetAnimationClipLoopPosition(handle, name, time) end

---@param handle number Animator handle
---@param name string Bone name
---@param quat TQuat Orientation of the bone
---@param weight number|nil Weight [0,1] default is 1.0
---@see @https://www.teardowngame.com/modding/api.html#SetBoneRotation
function SetBoneRotation(handle, name, quat, weight) end

---@param handle number Animator handle
---@param name string Bone name
---@param point table World space point as vector
---@param weight number|nil Weight [0,1] default is 1.0
---@see @https://www.teardowngame.com/modding/api.html#SetBoneLookAt
function SetBoneLookAt(handle, name, point, weight) end

---@param handle number Animator handle
---@param name string Bone name
---@param quat TQuat Additive orientation
---@param weight number|nil Weight [0,1] default is 1.0
---@see @https://www.teardowngame.com/modding/api.html#RotateBone
function RotateBone(handle, name, quat, weight) end

---@param handle number Animator handle
---@return table list Indexed table with bone-names
---@see @https://www.teardowngame.com/modding/api.html#GetBoneNames
function GetBoneNames(handle) end

---@param handle number Animator handle
---@param name string Bone name
---@return number handle Handle to the bone's body, or zero if no bone is present.
---@see @https://www.teardowngame.com/modding/api.html#GetBoneBody
function GetBoneBody(handle, name) end

---@param handle number Animator handle
---@param name string Bone name
---@return TTransform transform World space transform of the bone
---@see @https://www.teardowngame.com/modding/api.html#GetBoneWorldTransform
function GetBoneWorldTransform(handle, name) end

---@param handle number Animator handle
---@param name string Bone name
---@return TTransform transform Local space transform of the bone in bindpose
---@see @https://www.teardowngame.com/modding/api.html#GetBoneBindPoseTransform
function GetBoneBindPoseTransform(handle, name) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return number handle Handle to first light with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindLight
function FindLight(tag, global) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return table list Indexed table with handles to all lights with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindLights
function FindLights(tag, global) end

---@param handle number Light handle
---@param enabled boolean Set to true if light should be enabled
---@see @https://www.teardowngame.com/modding/api.html#SetLightEnabled
function SetLightEnabled(handle, enabled) end

---@param handle number Light handle
---@param r number Red value
---@param g number Green value
---@param b number Blue value
---@see @https://www.teardowngame.com/modding/api.html#SetLightColor
function SetLightColor(handle, r, g, b) end

---@param handle number Light handle
---@param intensity number Desired intensity of the light
---@see @https://www.teardowngame.com/modding/api.html#SetLightIntensity
function SetLightIntensity(handle, intensity) end

---@param handle number Light handle
---@return TTransform transform World space light transform
---@see @https://www.teardowngame.com/modding/api.html#GetLightTransform
function GetLightTransform(handle) end

---@param handle number Light handle
---@return number handle Shape handle or zero if not attached to shape
---@see @https://www.teardowngame.com/modding/api.html#GetLightShape
function GetLightShape(handle) end

---@param handle number Light handle
---@return boolean active True if light is currently emitting light
---@see @https://www.teardowngame.com/modding/api.html#IsLightActive
function IsLightActive(handle) end

---@param handle number Light handle
---@param point TVec World space point as vector
---@return boolean affected Return true if point is in light cone and range
---@see @https://www.teardowngame.com/modding/api.html#IsPointAffectedByLight
function IsPointAffectedByLight(handle, point) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number handle Handle of the player's flashlight
---@see @https://www.teardowngame.com/modding/api.html#GetFlashlight
function GetFlashlight(playerId) end

---@param handle number Handle of the light
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#SetFlashlight
function SetFlashlight(handle, playerId) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return number handle Handle to first trigger with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindTrigger
function FindTrigger(tag, global) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return table list Indexed table with handles to all triggers with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindTriggers
function FindTriggers(tag, global) end

---@param handle number Trigger handle
---@return TTransform transform Current trigger transform in world space
---@see @https://www.teardowngame.com/modding/api.html#GetTriggerTransform
function GetTriggerTransform(handle) end

---@param handle number Trigger handle
---@param transform TTransform Desired trigger transform in world space
---@see @https://www.teardowngame.com/modding/api.html#SetTriggerTransform
function SetTriggerTransform(handle, transform) end

---@param handle number Trigger handle
---@return TVec min Lower point of trigger bounds in world space
---@return TVec max Upper point of trigger bounds in world space
---@see @https://www.teardowngame.com/modding/api.html#GetTriggerBounds
function GetTriggerBounds(handle) end

---@param trigger number Trigger handle
---@param body number Body handle
---@return boolean inside True if body is in trigger volume
---@see @https://www.teardowngame.com/modding/api.html#IsBodyInTrigger
function IsBodyInTrigger(trigger, body) end

---@param trigger number Trigger handle
---@param vehicle number Vehicle handle
---@return boolean inside True if vehicle is in trigger volume
---@see @https://www.teardowngame.com/modding/api.html#IsVehicleInTrigger
function IsVehicleInTrigger(trigger, vehicle) end

---@param trigger number Trigger handle
---@param shape number Shape handle
---@return boolean inside True if shape is in trigger volume
---@see @https://www.teardowngame.com/modding/api.html#IsShapeInTrigger
function IsShapeInTrigger(trigger, shape) end

---@param trigger number Trigger handle
---@param point TVec Word space point as vector
---@return boolean inside True if point is in trigger volume
---@see @https://www.teardowngame.com/modding/api.html#IsPointInTrigger
function IsPointInTrigger(trigger, point) end

---@param point TVec Point
---@return boolean value True if point is inside scene boundaries or if there are no boundaries
---@return number dist Distance to the scene boundaries. Zero if there are no boundaries or if point is outside.
---@see @https://www.teardowngame.com/modding/api.html#IsPointInBoundaries
function IsPointInBoundaries(point) end

---@param handle number Trigger handle
---@param demolision boolean|nil If true, small debris and vehicles are ignored
---@return boolean empty True if trigger is empty
---@return TVec maxpoint World space point of highest point (largest Y coordinate) if not empty
---@see @https://www.teardowngame.com/modding/api.html#IsTriggerEmpty
function IsTriggerEmpty(handle, demolision) end

---@param trigger number Trigger handle
---@param point TVec Word space point as vector
---@return number distance Positive if point is outside, negative if inside
---@see @https://www.teardowngame.com/modding/api.html#GetTriggerDistance
function GetTriggerDistance(trigger, point) end

---@param trigger number Trigger handle
---@param point TVec Word space point as vector
---@return TVec closest Closest point in trigger as vector
---@see @https://www.teardowngame.com/modding/api.html#GetTriggerClosestPoint
function GetTriggerClosestPoint(trigger, point) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return number handle Handle to first screen with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindScreen
function FindScreen(tag, global) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return table list Indexed table with handles to all screens with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindScreens
function FindScreens(tag, global) end

---@param screen number Screen handle
---@param enabled boolean True if screen should be enabled
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetScreenEnabled
function SetScreenEnabled(screen, enabled) end

---@param screen number Screen handle
---@return boolean enabled True if screen is enabled
---@see @https://www.teardowngame.com/modding/api.html#IsScreenEnabled
function IsScreenEnabled(screen) end

---@param screen number Screen handle
---@return number shape Shape handle or zero if none
---@see @https://www.teardowngame.com/modding/api.html#GetScreenShape
function GetScreenShape(screen) end

---@param screen number Screen handle
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#GetScreenPlayer
function GetScreenPlayer(screen, playerId) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return number handle Handle to first vehicle with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindVehicle
function FindVehicle(tag, global) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return table list Indexed table with handles to all vehicles with specified tag
---@see @https://www.teardowngame.com/modding/api.html#FindVehicles
function FindVehicles(tag, global) end

---@param vehicle number Vehicle handle
---@return TTransform transform Transform of vehicle
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleTransform
function GetVehicleTransform(vehicle) end

---@param vehicle number Vehicle handle
---@return table transforms Transforms of vehicle exhausts
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleExhaustTransforms
function GetVehicleExhaustTransforms(vehicle) end

---@param vehicle number Vehicle handle
---@return table transforms Transforms of vehicle vitals
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleVitalTransforms
function GetVehicleVitalTransforms(vehicle) end

---@param vehicle number Vehicle handle
---@return table transforms Vehicle bodies handles
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleBodies
function GetVehicleBodies(vehicle) end

---@param vehicle number Vehicle handle
---@return number body Main body of vehicle
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleBody
function GetVehicleBody(vehicle) end

---@param vehicle number Vehicle handle
---@return number health Vehicle health (zero to one)
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleHealth
function GetVehicleHealth(vehicle) end

---@param vehicle number Vehicle handle
---@return table params Vehicle params
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleParams
function GetVehicleParams(vehicle) end

---@param handle number Vehicle handler
---@param param string Param name
---@param value number Param value
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetVehicleParam
function SetVehicleParam(handle, param, value) end

---@param vehicle number Vehicle handle
---@return TVec pos Driver position as vector in vehicle space
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleDriverPos
function GetVehicleDriverPos(vehicle) end

---@param vehicle number Vehicle handle
---@return TVec pos World space position of the next available seat. {0, 0, 0} if none is available.
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleAvailableSeatPos
function GetVehicleAvailableSeatPos(vehicle) end

---@param vehicle number Vehicle handle
---@return number steering Driver steering value -1 to 1
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleSteering
function GetVehicleSteering(vehicle) end

---@param vehicle number Vehicle handle
---@return number drive Driver drive value -1 to 1
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleDrive
function GetVehicleDrive(vehicle) end

---@param vehicle number Vehicle handle
---@param drive number Reverse/forward control -1 to 1
---@param steering number Left/right control -1 to 1
---@param handbrake boolean Handbrake control
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#DriveVehicle
function DriveVehicle(vehicle, drive, steering, handbrake) end

---@param vehicle number Vehicle handle
---@param name string Name of location
---@return TTransform transform World transform
---@see @https://www.teardowngame.com/modding/api.html#GetVehicleLocationWorldTransform
function GetVehicleLocationWorldTransform(vehicle, name) end

---@param vehicle number Vehicle handle
---@return number count Number of passengers
---@return number seats Number of seats
---@return boolean hasDriver If vehicle has a driver
---@see @https://www.teardowngame.com/modding/api.html#GetVehiclePassengerCount
function GetVehiclePassengerCount(vehicle) end

---@param vehicle number Vehicle handle
---@param health number Set vehicle health (between zero and one)
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetVehicleHealth
function SetVehicleHealth(vehicle, health) end

---@param tag string|nil Tag name
---@param global boolean|nil Search in entire scene
---@return number handle Handle to first rig with specified tag or zero if not found
---@see @https://www.teardowngame.com/modding/api.html#FindRig
function FindRig(tag, global) end

---@param rig number Rig handle
---@return TTransform transform World transform, nil if rig is missing
---@see @https://www.teardowngame.com/modding/api.html#GetRigWorldTransform
function GetRigWorldTransform(rig) end

---@param rig number Rig handle
---@param transform TTransform New world transform
---@see @https://www.teardowngame.com/modding/api.html#SetRigWorldTransform
function SetRigWorldTransform(rig, transform) end

---@param rig number Rig handle
---@param name string Name of location
---@return TTransform transform World transform, nil if rig is missing or location is missing
---@see @https://www.teardowngame.com/modding/api.html#GetRigLocationWorldTransform
function GetRigLocationWorldTransform(rig, name) end

---@param rig number Rig handle
---@param name string Name of location
---@param transform TTransform New world transform
---@see @https://www.teardowngame.com/modding/api.html#SetRigLocationWorldTransform
function SetRigLocationWorldTransform(rig, name, transform) end

---@param rig number Rig handle
---@param name string Name of location
---@return TTransform transform Local transform, nil if rig is missing or location is missing
---@see @https://www.teardowngame.com/modding/api.html#GetRigLocationLocalTransform
function GetRigLocationLocalTransform(rig, name) end

---@param rig number Rig handle
---@param name string Name of location
---@param transform TTransform New world transform
---@see @https://www.teardowngame.com/modding/api.html#SetRigLocationLocalTransform
function SetRigLocationLocalTransform(rig, name, transform) end

---@return table name List of all player Ids
---@see @https://www.teardowngame.com/modding/api.html#GetAllPlayers
function GetAllPlayers() end

---@return number count Number of max players for the session. Returns 1 for non-multiplayer.
---@see @https://www.teardowngame.com/modding/api.html#GetMaxPlayers
function GetMaxPlayers() end

---@return number count Number of players
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerCount
function GetPlayerCount() end

---@return table playerIds List of added player Ids
---@see @https://www.teardowngame.com/modding/api.html#GetAddedPlayers
function GetAddedPlayers() end

---@return table playerIds List of removed player Ids
---@see @https://www.teardowngame.com/modding/api.html#GetRemovedPlayers
function GetRemovedPlayers() end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return string name Player name
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerName
function GetPlayerName(playerId) end

---@return number GetLocalPlayer Local player ID.
---@see @https://www.teardowngame.com/modding/api.html#GetLocalPlayer
function GetLocalPlayer() end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean IsPlayerLocal Whether a player is the local player.
---@see @https://www.teardowngame.com/modding/api.html#IsPlayerLocal
function IsPlayerLocal(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return string character Character id
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerCharacter
function GetPlayerCharacter(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean IsPlayerHost Whether a player is the host
---@see @https://www.teardowngame.com/modding/api.html#IsPlayerHost
function IsPlayerHost(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean IsPlayerValid Whether a player is valid (existing player)
---@see @https://www.teardowngame.com/modding/api.html#IsPlayerValid
function IsPlayerValid(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TVec position Player center position
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerPos
function GetPlayerPos(playerId) end

---@param position TVec Start position of the search
---@param maxdist number|nil Max search distance
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean hit TRUE if hit, FALSE otherwise.
---@return TVec startpos Player can modify start position when close to walls etc
---@return TVec endpos Hit position
---@return TVec direction Direction from start position to end position
---@return TVec hitnormal Normal of the hitpoint
---@return number hitdist Distance of the hit
---@return number hitentity Handle of the entitiy being hit
---@return string hitmaterial Name of the material being hit
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerAimInfo
function GetPlayerAimInfo(position, maxdist, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number pitch Current player pitch angle
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerPitch
function GetPlayerPitch(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number yaw Current player yaw angle
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerYaw
function GetPlayerYaw(playerId) end

---@param pitch number Pitch.
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerPitch
function SetPlayerPitch(pitch, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number recoil Current player crouch
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerCrouch
function GetPlayerCrouch(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TTransform transform Current player transform
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerTransform
function GetPlayerTransform(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return table transform Current player transform, including pitch (look up/down)
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerTransformWithPitch
function GetPlayerTransformWithPitch(playerId) end

---@param transform TTransform Desired player transform
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerTransform
function SetPlayerTransform(transform, playerId) end

---@param transform table Desired player transform
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerTransformWithPitch
function SetPlayerTransformWithPitch(transform, playerId) end

---@param vel TVec Desired ground velocity
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerGroundVelocity
function SetPlayerGroundVelocity(vel, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TTransform transform Current player eye transform
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerEyeTransform
function GetPlayerEyeTransform(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TTransform transform Current player camera transform
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerCameraTransform
function GetPlayerCameraTransform(playerId) end

---@param transform TTransform Desired player camera offset transform
---@param stackable boolean|nil True if eye offset should summ up with multiple calls per tick
---@param playerId number|nil Player ID. On client, zero means client player.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerCameraOffsetTransform
function SetPlayerCameraOffsetTransform(transform, stackable, playerId) end

---@param transform TTransform Desired player spawn transform
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerSpawnTransform
function SetPlayerSpawnTransform(transform, playerId) end

---@param health number Desired player spawn health (between zero and one)
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerSpawnHealth
function SetPlayerSpawnHealth(health, playerId) end

---@param id string Tool unique identifier
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerSpawnTool
function SetPlayerSpawnTool(id, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TVec velocity Player velocity in world space as vector
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerVelocity
function GetPlayerVelocity(playerId) end

---@param vehicle number Handle to vehicle or zero to not drive.
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerVehicle
function SetPlayerVehicle(vehicle, playerId) end

---@param animator number Handle to animator or zero for no animator
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerAnimator
function SetPlayerAnimator(animator, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number animator Handle to animator or zero for no animator
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerAnimator
function GetPlayerAnimator(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return table bodies Get bodies associated with a player
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerBodies
function GetPlayerBodies(playerId) end

---@param velocity TVec Player velocity in world space as vector
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerVelocity
function SetPlayerVelocity(velocity, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number handle Current vehicle handle, or zero if not in vehicle
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerVehicle
function GetPlayerVehicle(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean isGrounded Whether the player is grounded
---@see @https://www.teardowngame.com/modding/api.html#IsPlayerGrounded
function IsPlayerGrounded(playerId) end

---@param handle number Vehicle handle
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean isDriver Whether the player is driver for this vehicle
---@see @https://www.teardowngame.com/modding/api.html#IsPlayerVehicleDriver
function IsPlayerVehicleDriver(handle, playerId) end

---@param handle number Vehicle handle
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean isPassenger Whether the player is a passenger of this vehicle
---@see @https://www.teardowngame.com/modding/api.html#IsPlayerVehiclePassenger
function IsPlayerVehiclePassenger(handle, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean isGrounded Whether the player is jumping or not
---@see @https://www.teardowngame.com/modding/api.html#IsPlayerJumping
function IsPlayerJumping(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean contact Whether the player is grounded
---@return number shape Handle to shape
---@return TVec point Point of contact
---@return TVec normal Normal of contact
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerGroundContact
function GetPlayerGroundContact(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number handle Handle to grabbed shape or zero if not grabbing.
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerGrabShape
function GetPlayerGrabShape(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number handle Handle to grabbed body or zero if not grabbing.
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerGrabBody
function GetPlayerGrabBody(playerId) end

---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#ReleasePlayerGrab
function ReleasePlayerGrab(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TVec pos The world space grab point.
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerGrabPoint
function GetPlayerGrabPoint(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number handle Handle to picked shape or zero if nothing is picked
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerPickShape
function GetPlayerPickShape(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number handle Handle to picked body or zero if nothing is picked
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerPickBody
function GetPlayerPickBody(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number handle Handle to interactable shape or zero
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerInteractShape
function GetPlayerInteractShape(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number handle Handle to interactable body or zero
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerInteractBody
function GetPlayerInteractBody(playerId) end

---@param handle number Handle to screen or zero for no screen
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerScreen
function SetPlayerScreen(handle, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number handle Handle to interacted screen or zero if none
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerScreen
function GetPlayerScreen(playerId) end

---@param health number Set player health (between zero and one)
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerHealth
function SetPlayerHealth(health, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number health Current player health
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerHealth
function GetPlayerHealth(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean canusetool If the player currenty can use tool.
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerCanUseTool
function GetPlayerCanUseTool(playerId) end

---@param state boolean State of player regeneration
---@param player number|nil Player ID change regeneration for
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerRegenerationState
function SetPlayerRegenerationState(state, player) end

---@param toolId string Set Tool ID
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerTool
function SetPlayerTool(toolId, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return string toolId Get Tool ID
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerTool
function GetPlayerTool(playerId) end

---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#RespawnPlayer
function RespawnPlayer(playerId) end

---@param transform TTransform Transform
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#RespawnPlayerAtTransform
function RespawnPlayerAtTransform(transform, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number speed Current player base walking speed
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerWalkingSpeed
function GetPlayerWalkingSpeed(playerId) end

---@param speed number Set player walking speed
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerWalkingSpeed
function SetPlayerWalkingSpeed(speed, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number speed Current player walking speed while crouched
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerCrouchSpeedScale
function GetPlayerCrouchSpeedScale(playerId) end

---@param speed number Set player walking speed while crouched
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerCrouchSpeedScale
function SetPlayerCrouchSpeedScale(speed, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number speed Current player walking speed when hurt
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerHurtSpeedScale
function GetPlayerHurtSpeedScale(playerId) end

---@param speed number Set player walking speed when hurt
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerHurtSpeedScale
function SetPlayerHurtSpeedScale(speed, playerId) end

---@param parameter string Parameter name
---@param player number|nil Player ID. On player, zero means local player.
---@return any value Parameter value
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerParam
function GetPlayerParam(parameter, player) end

---@param parameter string Parameter name
---@param value any Parameter value
---@param player number|nil Player ID. On player, zero means local player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerParam
function SetPlayerParam(parameter, value, player) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerHidden
function SetPlayerHidden(playerId) end

---@param id string Tool unique identifier
---@param name string Tool name to show in hud
---@param file string Path to vox file or prefab xml
---@param group number|nil Tool group for this tool (1-6) Default is 6.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#RegisterTool
function RegisterTool(id, name, file, group) end

---@param toolId string Tool ID
---@param ammo number The default ammo pickup amount
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetToolAmmoPickupAmount
function SetToolAmmoPickupAmount(toolId, ammo) end

---@param toolId string Tool ID
---@return number ammo The default ammo pickup amount
---@see @https://www.teardowngame.com/modding/api.html#GetToolAmmoPickupAmount
function GetToolAmmoPickupAmount(toolId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number handle Handle to currently visible tool body or zero if none
---@see @https://www.teardowngame.com/modding/api.html#GetToolBody
function GetToolBody(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TTransform right Transform of right hand relative to the tool body origin, or nil if the right hand is not used
---@return TTransform left Transform of left hand, or nil if left hand is not used
---@see @https://www.teardowngame.com/modding/api.html#GetToolHandPoseLocalTransform
function GetToolHandPoseLocalTransform(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TTransform right Transform of right hand in world space, or nil if the right hand is not used
---@return TTransform left Transform of left hand, or nil if left hand is not used
---@see @https://www.teardowngame.com/modding/api.html#GetToolHandPoseWorldTransform
function GetToolHandPoseWorldTransform(playerId) end

---@param right TTransform Transform of right hand relative to the tool body origin, or nil if right hand is not used
---@param left TTransform Transform of left hand, or nil if left hand is not used
---@param playerId number|nil Player ID. On client, zero means client player.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetToolHandPoseLocalTransform
function SetToolHandPoseLocalTransform(right, left, playerId) end

---@param name string Name of location
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TTransform location Transform of a tool location in tool space or nil if location is not found.
---@see @https://www.teardowngame.com/modding/api.html#GetToolLocationLocalTransform
function GetToolLocationLocalTransform(name, playerId) end

---@param name string Name of location
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TTransform location Transform of a tool location in world space or nil if the location is not found or if there is no visible tool body.
---@see @https://www.teardowngame.com/modding/api.html#GetToolLocationWorldTransform
function GetToolLocationWorldTransform(name, playerId) end

---@param transform TTransform Tool body transform
---@param sway number|nil Tool sway amount. Default is 1.0
---@param playerId number|nil Player ID. On client, zero means client player.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetToolTransform
function SetToolTransform(transform, sway, playerId) end

---@param zoom number Zoom factor
---@param zoomSensitivity number|nil Input sensitivity when zoomed in. Default is 1.0.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetToolAllowedZoom
function SetToolAllowedZoom(zoom, zoomSensitivity) end

---@param transform TTransform Tool body transform
---@param playerId number|nil Player ID. On client, zero means client player.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetToolTransformOverride
function SetToolTransformOverride(transform, playerId) end

---@param offset TVec Tool body offset
---@param playerId number|nil Player ID. On client, zero means client player.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetToolOffset
function SetToolOffset(offset, playerId) end

---@param toolId string Tool ID
---@param ammo number Total ammo
---@param playerId number|nil Player ID. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetToolAmmo
function SetToolAmmo(toolId, ammo, playerId) end

---@param toolId string Tool ID
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number ammo Total ammo for tool
---@see @https://www.teardowngame.com/modding/api.html#GetToolAmmo
function GetToolAmmo(toolId, playerId) end

---@param toolId string Tool ID
---@param enabled boolean Tool enabled
---@param playerId number|nil Player ID
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetToolEnabled
function SetToolEnabled(toolId, enabled, playerId) end

---@param toolId string Tool ID
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean enabled Tool enabled for player
---@see @https://www.teardowngame.com/modding/api.html#IsToolEnabled
function IsToolEnabled(toolId, playerId) end

---@param orientation TQuat Base orientation
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerOrientation
function SetPlayerOrientation(orientation, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerOrientation
function GetPlayerOrientation(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TVec up Up vector of the player
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerUp
function GetPlayerUp(playerId) end

---@param rig number Rig handle
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerRig
function SetPlayerRig(rig, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return number rig Rig handle
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerRig
function GetPlayerRig(playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return TTransform transform World transform, nil if player doesnt have a rig
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerRigWorldTransform
function GetPlayerRigWorldTransform(playerId) end

---@param rigId number Unique rig-id, -1 means all rigs
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#ClearPlayerRig
function ClearPlayerRig(rigId, playerId) end

---@param rigId number Unique id
---@param name string Name of location
---@param location table Rig Local transform of the location
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerRigLocationLocalTransform
function SetPlayerRigLocationLocalTransform(rigId, name, location, playerId) end

---@param rigId number Unique id
---@param location table New world transform
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerRigTransform
function SetPlayerRigTransform(rigId, location, playerId) end

---@param name string Name of location
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return table location Transform of a location in world space
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerRigLocationWorldTransform
function GetPlayerRigLocationWorldTransform(name, playerId) end

---@param rigId number Unique id
---@param tag string Tag
---@param playerId number|nil Player ID. On client, zero means client player.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerRigTags
function SetPlayerRigTags(rigId, tag, playerId) end

---@param tag string Tag name
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean exists Returns true if entity has tag
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerRigHasTag
function GetPlayerRigHasTag(tag, playerId) end

---@param tag string Tag name
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return string value Returns the tag value, if any. Empty string otherwise.
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerRigTagValue
function GetPlayerRigTagValue(tag, playerId) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@return boolean inuse If color is used or not
---@return number r Red channel value
---@return number g Green channel value
---@return number b Blue channel value
---@see @https://www.teardowngame.com/modding/api.html#GetPlayerColor
function GetPlayerColor(playerId) end

---@param r number Red value
---@param g number Green value
---@param b number Blue value
---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#SetPlayerColor
function SetPlayerColor(r, g, b, playerId) end

---@param targetPlayerId number Target player ID
---@param damage number Damage to apply to target player
---@param cause string|nil The cause of damage
---@param instigatingPlayerId number|nil Instigating player ID.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#ApplyPlayerDamage
function ApplyPlayerDamage(targetPlayerId, damage, cause, instigatingPlayerId) end

---@param player number Player to disable input for
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#DisablePlayerInput
function DisablePlayerInput(player) end

---@param playerId number Player to disable
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#DisablePlayer
function DisablePlayer(playerId) end

---@param playerId number Check if player is disabled
---@see @https://www.teardowngame.com/modding/api.html#IsPlayerDisabled
function IsPlayerDisabled(playerId) end

---@param playerId number Player for which damage should be disabled
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#DisablePlayerDamage
function DisablePlayerDamage(playerId) end

---@param path string Path to ogg sound file
---@param nominalDistance number|nil The distance in meters this sound is recorded at. Affects attenuation, default is 10.0
---@return number handle Sound handle
---@see @https://www.teardowngame.com/modding/api.html#LoadSound
function LoadSound(path, nominalDistance) end

---@param handle number Sound handle
---@see @https://www.teardowngame.com/modding/api.html#UnloadSound
function UnloadSound(handle) end

---@param path string Path to ogg sound file
---@param nominalDistance number|nil The distance in meters this sound is recorded at. Affects attenuation, default is 10.0
---@return number handle Loop handle
---@see @https://www.teardowngame.com/modding/api.html#LoadLoop
function LoadLoop(path, nominalDistance) end

---@param handle number Loop handle
---@see @https://www.teardowngame.com/modding/api.html#UnloadLoop
function UnloadLoop(handle) end

---@param handle number Loop handle
---@param nominalDistance number User index
---@return boolean flag TRUE if sound applied to gamepad speaker, FALSE otherwise.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetSoundLoopUser
function SetSoundLoopUser(handle, nominalDistance) end

---@param handle number Sound handle
---@param pos TVec|nil World position as vector. Default is player position.
---@param volume number|nil Playback volume. Default is 1.0
---@param registerVolume boolean|nil Register position and volume of this sound for GetLastSound. Default is true
---@param pitch number|nil Playback pitch. Default 1.0
---@return number handle Sound play handle
---@see @https://www.teardowngame.com/modding/api.html#PlaySound
function PlaySound(handle, pos, volume, registerVolume, pitch) end

---@param handle number Sound handle
---@param user number Index of user to play.
---@param pos TVec|nil World position as vector. Default is player position.
---@param volume number|nil Playback volume. Default is 1.0
---@param registerVolume boolean|nil Register position and volume of this sound for GetLastSound. Default is true
---@param pitch number|nil Playback pitch. Default 1.0
---@return number handle Sound play handle
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#PlaySoundForUser
function PlaySoundForUser(handle, user, pos, volume, registerVolume, pitch) end

---@param handle number Sound play handle
---@see @https://www.teardowngame.com/modding/api.html#StopSound
function StopSound(handle) end

---@param handle number Sound play handle
---@return boolean playing True if sound is playing, false otherwise.
---@see @https://www.teardowngame.com/modding/api.html#IsSoundPlaying
function IsSoundPlaying(handle) end

---@param handle number Sound play handle
---@return number progress Current sound progress in seconds.
---@see @https://www.teardowngame.com/modding/api.html#GetSoundProgress
function GetSoundProgress(handle) end

---@param handle number Sound play handle
---@param progress number Progress in seconds
---@see @https://www.teardowngame.com/modding/api.html#SetSoundProgress
function SetSoundProgress(handle, progress) end

---@param handle number Loop handle
---@param pos TVec|nil World position as vector. Default is player position.
---@param volume number|nil Playback volume. Default is 1.0
---@param registerVolume boolean|nil Register position and volume of this sound for GetLastSound. Default is true
---@param pitch number|nil Playback pitch. Default 1.0
---@see @https://www.teardowngame.com/modding/api.html#PlayLoop
function PlayLoop(handle, pos, volume, registerVolume, pitch) end

---@param handle number Loop handle
---@return number progress Current music progress in seconds.
---@see @https://www.teardowngame.com/modding/api.html#GetSoundLoopProgress
function GetSoundLoopProgress(handle) end

---@param handle number Loop handle
---@param progress number|nil Progress in seconds. Default 0.0.
---@see @https://www.teardowngame.com/modding/api.html#SetSoundLoopProgress
function SetSoundLoopProgress(handle, progress) end

---@param path string Music path
---@see @https://www.teardowngame.com/modding/api.html#PlayMusic
function PlayMusic(path) end

---@see @https://www.teardowngame.com/modding/api.html#StopMusic
function StopMusic() end

---@return boolean playing True if music is playing, false otherwise.
---@see @https://www.teardowngame.com/modding/api.html#IsMusicPlaying
function IsMusicPlaying() end

---@param paused boolean True to pause, false to resume.
---@see @https://www.teardowngame.com/modding/api.html#SetMusicPaused
function SetMusicPaused(paused) end

---@return number progress Current music progress in seconds.
---@see @https://www.teardowngame.com/modding/api.html#GetMusicProgress
function GetMusicProgress() end

---@param progress number|nil Progress in seconds. Default 0.0.
---@see @https://www.teardowngame.com/modding/api.html#SetMusicProgress
function SetMusicProgress(progress) end

---@param volume number Music volume.
---@see @https://www.teardowngame.com/modding/api.html#SetMusicVolume
function SetMusicVolume(volume) end

---@param wet number Music low pass filter 0.0 - 1.0.
---@see @https://www.teardowngame.com/modding/api.html#SetMusicLowPass
function SetMusicLowPass(wet) end

---@param path string Path to sprite. Must be PNG or JPG format.
---@return number handle Sprite handle
---@see @https://www.teardowngame.com/modding/api.html#LoadSprite
function LoadSprite(path) end

---@param handle number Sprite handle
---@param transform TTransform Transform
---@param width number Width in meters
---@param height number Height in meters
---@param r number|nil Red color. Default 1.0.
---@param g number|nil Green color. Default 1.0.
---@param b number|nil Blue color. Default 1.0.
---@param a number|nil Alpha. Default 1.0.
---@param depthTest boolean|nil Depth test enabled. Default false.
---@param additive boolean|nil Additive blending enabled. Default false.
---@param fogAffected boolean|nil Enable distance fog effect. Default false.
---@see @https://www.teardowngame.com/modding/api.html#DrawSprite
function DrawSprite(handle, transform, width, height, r, g, b, a, depthTest, additive, fogAffected) end

---@param layers string Space separate list of layers
---@see @https://www.teardowngame.com/modding/api.html#QueryRequire
function QueryRequire(layers) end

---@param layers string Space separate list of layers
---@see @https://www.teardowngame.com/modding/api.html#QueryInclude
function QueryInclude(layers) end

---@param mask number Mask bits (0-255)
---@see @https://www.teardowngame.com/modding/api.html#QueryCollisionMask
function QueryCollisionMask(mask) end

---@param handle number Animator handle
---@see @https://www.teardowngame.com/modding/api.html#QueryRejectAnimator
function QueryRejectAnimator(handle) end

---@param vehicle number Vehicle handle
---@see @https://www.teardowngame.com/modding/api.html#QueryRejectVehicle
function QueryRejectVehicle(vehicle) end

---@param body number Body handle
---@see @https://www.teardowngame.com/modding/api.html#QueryRejectBody
function QueryRejectBody(body) end

---@param bodies table Array with bodies handles
---@see @https://www.teardowngame.com/modding/api.html#QueryRejectBodies
function QueryRejectBodies(bodies) end

---@param shape number Shape handle
---@see @https://www.teardowngame.com/modding/api.html#QueryRejectShape
function QueryRejectShape(shape) end

---@param shapes table Array with shapes handles
---@see @https://www.teardowngame.com/modding/api.html#QueryRejectShapes
function QueryRejectShapes(shapes) end

---@param playerId number|nil Player ID. On client, zero means client player. On server, zero means server (host) player.
---@see @https://www.teardowngame.com/modding/api.html#QueryRejectPlayer
function QueryRejectPlayer(playerId) end

---@param origin TVec Raycast origin as world space vector
---@param direction TVec Unit length raycast direction as world space vector
---@param maxDist number Raycast maximum distance. Keep this as low as possible for good performance.
---@param radius number|nil Raycast thickness. Default zero.
---@param rejectTransparent boolean|nil Raycast through transparent materials. Default false.
---@return boolean hit True if raycast hit something
---@return number dist Hit distance from origin
---@return TVec normal World space normal at hit point
---@return number shape Handle to hit shape
---@see @https://www.teardowngame.com/modding/api.html#QueryRaycast
function QueryRaycast(origin, direction, maxDist, radius, rejectTransparent) end

---@param origin TVec Raycast origin as world space vector
---@param direction TVec Unit length raycast direction as world space vector
---@param maxDist number Raycast maximum distance. Keep this as low as possible for good performance.
---@param radius number|nil Raycast thickness. Default zero.
---@return boolean hit True if raycast hit something
---@return number dist Hit distance from origin
---@return number joint Handle to hit joint of rope type
---@see @https://www.teardowngame.com/modding/api.html#QueryRaycastRope
function QueryRaycastRope(origin, direction, maxDist, radius) end

---@param origin TVec Raycast origin as world space vector
---@param direction TVec Unit length raycast direction as world space vector
---@param maxDist number Raycast maximum distance. Keep this as low as possible for good performance.
---@return boolean hit True if raycast hit something
---@return number dist Hit distance from origin
---@return TVec hitPos Hit point as world space vector
---@see @https://www.teardowngame.com/modding/api.html#QueryRaycastWater
function QueryRaycastWater(origin, direction, maxDist) end

---@param origin TVec Shot ray origin as world space vector
---@param direction TVec Unit length direction as world space vector
---@param maxDist number Shot maximum distance. Keep this as low as possible for good performance.
---@param radius number|nil Ray thickness. Default zero.
---@param playerId number|nil Instigating player, will be ignored during hit detection.
---@return boolean didHit If it was a valid hit.
---@return number dist Distance along direction where the hit was registered.
---@return number shape Handle to hit shape, zero if it did not hit a shape
---@return number playerId PlayerId of hit player, zero if it did not hit a player
---@return number playerDamageFactor 1.0 for a hit on the torso, and less for a lower body hit. Applicable only if a player was hit. Use this to scale the damage.
---@return TVec normal Normal vector of the hit
---@see @https://www.teardowngame.com/modding/api.html#QueryShot
function QueryShot(origin, direction, maxDist, radius, playerId) end

---@param origin TVec World space point
---@param maxDist number Maximum distance. Keep this as low as possible for good performance.
---@return boolean hit True if a point was found
---@return TVec point World space closest point
---@return TVec normal World space normal at closest point
---@return number shape Handle to closest shape
---@see @https://www.teardowngame.com/modding/api.html#QueryClosestPoint
function QueryClosestPoint(origin, maxDist) end

---@param min TVec Aabb minimum point
---@param max TVec Aabb maximum point
---@return table list Indexed table with handles to all shapes in the aabb
---@see @https://www.teardowngame.com/modding/api.html#QueryAabbShapes
function QueryAabbShapes(min, max) end

---@param min TVec Aabb minimum point
---@param max TVec Aabb maximum point
---@return table list Indexed table with handles to all bodies in the aabb
---@see @https://www.teardowngame.com/modding/api.html#QueryAabbBodies
function QueryAabbBodies(min, max) end

---@param start TVec World space start point
---@param endPoint TVec World space target point
---@param maxDist number|nil Maximum path length before giving up. Default is infinite.
---@param targetRadius number|nil Maximum allowed distance to target in meters. Default is 2.0
---@param type string|nil Type of path. Can be 'low', 'standart', 'water', 'flying'. Default is 'standart'
---@see @https://www.teardowngame.com/modding/api.html#QueryPath
function QueryPath(start, endPoint, maxDist, targetRadius, type) end

---@return number id Path planner id
---@see @https://www.teardowngame.com/modding/api.html#CreatePathPlanner
function CreatePathPlanner() end

---@param id number Path planner id
---@see @https://www.teardowngame.com/modding/api.html#DeletePathPlanner
function DeletePathPlanner(id) end

---@param id number Path planner id
---@param start TVec World space start point
---@param endPoint TVec World space target point
---@param maxDist number|nil Maximum path length before giving up. Default is infinite.
---@param targetRadius number|nil Maximum allowed distance to target in meters. Default is 2.0
---@param type string|nil Type of path. Can be 'low', 'standart', 'water', 'flying'. Default is 'standart'
---@see @https://www.teardowngame.com/modding/api.html#PathPlannerQuery
function PathPlannerQuery(id, start, endPoint, maxDist, targetRadius, type) end

---@param id number|nil Path planner id. Default value is 0.
---@see @https://www.teardowngame.com/modding/api.html#AbortPath
function AbortPath(id) end

---@param id number|nil Path planner id. Default value is 0.
---@return string state Current path planning state
---@see @https://www.teardowngame.com/modding/api.html#GetPathState
function GetPathState(id) end

---@param id number|nil Path planner id. Default value is 0.
---@return number length Length of last path planning result (in meters)
---@see @https://www.teardowngame.com/modding/api.html#GetPathLength
function GetPathLength(id) end

---@param dist number The distance along path. Should be between zero and result from GetPathLength()
---@param id number|nil Path planner id. Default value is 0.
---@return TVec point The path point dist meters along the path
---@see @https://www.teardowngame.com/modding/api.html#GetPathPoint
function GetPathPoint(dist, id) end

---@return number volume Volume of loudest sound played last frame
---@return TVec position World position of loudest sound played last frame
---@see @https://www.teardowngame.com/modding/api.html#GetLastSound
function GetLastSound() end

---@param point TVec World point as vector
---@return boolean inWater True if point is in water
---@return number depth Depth of point into water, or zero if not in water
---@see @https://www.teardowngame.com/modding/api.html#IsPointInWater
function IsPointInWater(point) end

---@param point TVec World point as vector
---@return TVec vel Wind at provided position
---@see @https://www.teardowngame.com/modding/api.html#GetWindVelocity
function GetWindVelocity(point) end

---@see @https://www.teardowngame.com/modding/api.html#ParticleReset
function ParticleReset() end

---@param type string Type of particle. Can be 'smoke' or 'plain'.
---@see @https://www.teardowngame.com/modding/api.html#ParticleType
function ParticleType(type) end

---@param type number Tile in the particle texture atlas (0-15)
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

---@param pos TVec World space point as vector
---@param velocity TVec World space velocity as vector
---@param lifetime number Particle lifetime in seconds
---@see @https://www.teardowngame.com/modding/api.html#SpawnParticle
function SpawnParticle(pos, velocity, lifetime) end

---@param xml string File name or xml string
---@param transform TTransform Spawn transform
---@param allowStatic boolean|nil Allow spawning static shapes and bodies (default false)
---@param jointExisting boolean|nil Allow joints to connect to existing scene geometry (default false)
---@return table entities Indexed table with handles to all spawned entities
---@see @https://www.teardowngame.com/modding/api.html#Spawn
function Spawn(xml, transform, allowStatic, jointExisting) end

---@param xml string File name or xml string
---@param layer string Vox layer name
---@param transform TTransform Spawn transform
---@param allowStatic boolean|nil Allow spawning static shapes and bodies (default false)
---@param jointExisting boolean|nil Allow joints to connect to existing scene geometry (default false)
---@return table entities Indexed table with handles to all spawned entities
---@see @https://www.teardowngame.com/modding/api.html#SpawnLayer
function SpawnLayer(xml, layer, transform, allowStatic, jointExisting) end

---@param id string Tool ID
---@param transform TTransform Spawn transform
---@param allowStatic boolean|nil Allow spawning static shapes and bodies (default false)
---@param voxScale number|nil Applies a scale to voxels (default 1.0)
---@return table entities Indexed table with handles to all spawned entities
---@see @https://www.teardowngame.com/modding/api.html#SpawnTool
function SpawnTool(id, transform, allowStatic, voxScale) end

---@param id number An id to identify the marker, typically player ID or body ID.
---@param tag string A tag to help distinguish markers.
---@param name string Name of the marker.
---@param category string Used to group markers together in map target list.
---@param showLabelOnMap boolean name label will be shown on map if true
---@param info string Additional information about the marker, displayed when selected.
---@param pos TVec The world position of the marker.
---@param color TVec The color of the marker, as a Vec table (e.g. Vec(1, 0, 0) for red)
---@param infoImage string|nil Path to the image to be displayed in the info section.
---@param dotIcon string|nil Path to the image used to represent the marker on map.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#AddMapMarker
function AddMapMarker(id, tag, name, category, showLabelOnMap, info, pos, color, infoImage, dotIcon) end

---@return number id id of map marker that was selected this tick.
---@return string tag the corresponding tag.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SelectedMapMarker
function SelectedMapMarker() end

---@param origin TVec Origin in world space as vector
---@param direction TVec Unit length direction as world space vector
---@param type string|nil Shot type, see description, default is 'bullet'
---@param strength number|nil Strength scaling, default is 1.0
---@param maxDist number|nil Maximum distance, default is 100.0
---@param playerId number|nil Instigating player. Can be skipped for non-player shots (helicopters etc.)
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#Shoot
function Shoot(origin, direction, type, strength, maxDist, playerId) end

---@param origin TVec Origin in world space as vector
---@param radius number Affected radius, in range 0.0 to 5.0
---@param type string|nil Paint type. Can be 'explosion' or 'spraycan'. Default is spraycan.
---@param probability number|nil Dithering probability between zero and one, default is 1.0
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#Paint
function Paint(origin, radius, type, probability) end

---@param origin TVec Origin in world space as vector
---@param radius number Affected radius, in range 0.0 to 5.0
---@param red number red color value, in range 0.0 to 1.0
---@param green number green color value, in range 0.0 to 1.0
---@param blue number blue color value, in range 0.0 to 1.0
---@param alpha number|nil alpha channel value, in range 0.0 to 1.0
---@param probability number|nil Dithering probability between zero and one, default is 1.0
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#PaintRGBA
function PaintRGBA(origin, radius, red, green, blue, alpha, probability) end

---@param position TVec Hole center point
---@param r0 number Hole radius for soft materials
---@param r1 number|nil Hole radius for medium materials. May not be bigger than r0. Default zero.
---@param r2 number|nil Hole radius for hard materials. May not be bigger than r1. Default zero.
---@param silent boolean|nil Make hole without playing any break sounds.
---@return number count Number of voxels that was cut out. This will be zero if there were no changes to any shape.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#MakeHole
function MakeHole(position, r0, r1, r2, silent) end

---@param pos TVec Position in world space as vector
---@param size number Explosion size from 0.5 to 4.0
---@param instigatingPlayerId number|nil Instigating player ID.
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#Explosion
function Explosion(pos, size, instigatingPlayerId) end

---@param pos TVec Position in world space as vector
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SpawnFire
function SpawnFire(pos) end

---@return number count Number of active fires in level
---@see @https://www.teardowngame.com/modding/api.html#GetFireCount
function GetFireCount() end

---@param origin TVec World space position as vector
---@param maxDist number Maximum search distance
---@return boolean hit A fire was found within search distance
---@return TVec pos Position of closest fire
---@see @https://www.teardowngame.com/modding/api.html#QueryClosestFire
function QueryClosestFire(origin, maxDist) end

---@param min TVec Aabb minimum point
---@param max TVec Aabb maximum point
---@return number count Number of active fires in bounding box
---@see @https://www.teardowngame.com/modding/api.html#QueryAabbFireCount
function QueryAabbFireCount(min, max) end

---@param min TVec Aabb minimum point
---@param max TVec Aabb maximum point
---@return number count Number of fires removed
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#RemoveAabbFires
function RemoveAabbFires(min, max) end

---@return TTransform transform Current camera transform
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#GetCameraTransform
function GetCameraTransform() end

---@param transform TTransform Desired camera transform
---@param fov number|nil Optional horizontal field of view in degrees (default: 90)
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetCameraTransform
function SetCameraTransform(transform, fov) end

---@param transition boolean Use transition
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#RequestFirstPerson
function RequestFirstPerson(transition) end

---@param transition boolean Use transition
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#RequestThirdPerson
function RequestThirdPerson(transition) end

---@param transform TTransform Desired camera offset transform
---@param stackable boolean|nil True if camera offset should summ up with multiple calls per tick
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetCameraOffsetTransform
function SetCameraOffsetTransform(transform, stackable) end

---@param handle number Body or shape handle
---@param ignoreRotation boolean|nil True to ignore rotation and use position only, false to use full transform
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#AttachCameraTo
function AttachCameraTo(handle, ignoreRotation) end

---@param bodyHandle number Handle of a body, shapes of which should be
---@param mainShapeIdx number Optional index of a shape among the given
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetPivotClipBody
function SetPivotClipBody(bodyHandle, mainShapeIdx) end

---@param strength number Normalized strength of shaking
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#ShakeCamera
function ShakeCamera(strength) end

---@param degrees number Horizontal field of view in degrees (10-170)
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetCameraFov
function SetCameraFov(degrees) end

---@param distance number Depth of field distance
---@param amount number|nil Optional amount of blur (default 1.0)
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetCameraDof
function SetCameraDof(distance, amount) end

---Client only.
---@see @https://www.teardowngame.com/modding/api.html#DisableMotionBlur
function DisableMotionBlur() end

---@param health number health value where anything lower results in blurred vision
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetLowHealthBlurThreshold
function SetLowHealthBlurThreshold(health) end

---@param pos TVec World space light position
---@param r number Red
---@param g number Green
---@param b number Blue
---@param intensity number|nil Intensity. Default is 1.0.
---@see @https://www.teardowngame.com/modding/api.html#PointLight
function PointLight(pos, r, g, b, intensity) end

---@param scale number Time scale 0.0 to 2.0
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetTimeScale
function SetTimeScale(scale) end

---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetEnvironmentDefault
function SetEnvironmentDefault() end

---@param name string Property name
---@param value0 any Property value (type depends on property)
---@param value1 any|nil Extra property value (only some properties)
---@param value2 any|nil Extra property value (only some properties)
---@param value3 any|nil Extra property value (only some properties)
---Server only.
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

---@param p0 TVec World space point as vector
---@param p1 TVec World space point as vector
---@param r number|nil Red
---@param g number|nil Green
---@param b number|nil Blue
---@param a number|nil Alpha
---@see @https://www.teardowngame.com/modding/api.html#DrawLine
function DrawLine(p0, p1, r, g, b, a) end

---@param p0 TVec World space point as vector
---@param p1 TVec World space point as vector
---@param r number|nil Red
---@param g number|nil Green
---@param b number|nil Blue
---@param a number|nil Alpha
---@see @https://www.teardowngame.com/modding/api.html#DebugLine
function DebugLine(p0, p1, r, g, b, a) end

---@param p0 TVec World space point as vector
---@param r number|nil Red
---@param g number|nil Green
---@param b number|nil Blue
---@param a number|nil Alpha
---@see @https://www.teardowngame.com/modding/api.html#DebugCross
function DebugCross(p0, r, g, b, a) end

---@param transform TTransform The transform
---@param scale number|nil Length of the axis
---@see @https://www.teardowngame.com/modding/api.html#DebugTransform
function DebugTransform(transform, scale) end

---@param name string Name
---@param value any Value
---@param lineWrapping boolean|nil True if you need to wrap Table lines. Works only with tables.
---@see @https://www.teardowngame.com/modding/api.html#DebugWatch
function DebugWatch(name, value, lineWrapping) end

---@param message string Message to display
---@param lineWrapping boolean|nil True if you need to wrap Table lines. Works only with tables.
---@see @https://www.teardowngame.com/modding/api.html#DebugPrint
function DebugPrint(message, lineWrapping) end

---@param eventName string Event name
---@param listenerFunction string Listener function name
---@see @https://www.teardowngame.com/modding/api.html#RegisterListenerTo
function RegisterListenerTo(eventName, listenerFunction) end

---@param eventName string Event name
---@param listenerFunction string Listener function name
---@see @https://www.teardowngame.com/modding/api.html#UnregisterListener
function UnregisterListener(eventName, listenerFunction) end

---@param eventName string Event name
---@param args string|nil Event parameters
---@see @https://www.teardowngame.com/modding/api.html#TriggerEvent
function TriggerEvent(eventName, args) end

---@param filepath string Path to Haptic effect to play
---@return string handle Haptic effect handle
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#LoadHaptic
function LoadHaptic(filepath) end

---@param leftMotorRumble number Amount of rumble for left motor
---@param rightMotorRumble number Amount of rumble for right motor
---@param leftTriggerRumble number Amount of rumble for left trigger
---@param rightTriggerRumble number Amount of rumble for right trigger
---@return string handle Haptic effect handle
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#CreateHaptic
function CreateHaptic(leftMotorRumble, rightMotorRumble, leftTriggerRumble, rightTriggerRumble) end

---@param handle string Handle of haptic effect
---@param amplitude number Amplidute used for calculation of Haptic effect.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#PlayHaptic
function PlayHaptic(handle, amplitude) end

---@param handle string Handle of haptic effect
---@param direction TVec Direction in which effect must be played
---@param amplitude number Amplidute used for calculation of Haptic effect.
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#PlayHapticDirectional
function PlayHapticDirectional(handle, direction, amplitude) end

---@param handle string Handle of haptic effect
---@return boolean flag is current Haptic playing or not
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#HapticIsPlaying
function HapticIsPlaying(handle) end

---@param id string Tool unique identifier
---@param handle string Handle of haptic effect
---@param amplitude number|nil Amplitude multiplier. Default (1.0)
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#SetToolHaptic
function SetToolHaptic(id, handle, amplitude) end

---@param handle string Handle of haptic effect
---Client only.
---@see @https://www.teardowngame.com/modding/api.html#StopHaptic
function StopHaptic(handle) end

---@param shape number Shape handle
---@param pos TVec World space point as vector
---@param amount number amount of heat
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#AddHeat
function AddHeat(shape, pos, amount) end

---@return number area Number representing the area of the boundary.
---@see @https://www.teardowngame.com/modding/api.html#GetBoundaryArea
function GetBoundaryArea() end

---@return TVec min Vector representing the AABB lower bound
---@return TVec max Vector representing the AABB upper bound
---@see @https://www.teardowngame.com/modding/api.html#GetBoundaryBounds
function GetBoundaryBounds() end

---@return TVec vector Gravity vector
---@see @https://www.teardowngame.com/modding/api.html#GetGravity
function GetGravity() end

---@param vec TVec Gravity vector
---Server only.
---@see @https://www.teardowngame.com/modding/api.html#SetGravity
function SetGravity(vec) end

---@return number fps Frames per second
---@see @https://www.teardowngame.com/modding/api.html#GetFps
function GetFps() end

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

---@see @https://www.teardowngame.com/modding/api.html#UiResetColor
function UiResetColor() end

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

---@return number x X scale
---@return number y Y scale
---@see @https://www.teardowngame.com/modding/api.html#UiGetScale
function UiGetScale() end

---@param width number Rect width
---@param height number Rect height
---@param inherit boolean|nil True if must include the parent's clip rect
---@see @https://www.teardowngame.com/modding/api.html#UiClipRect
function UiClipRect(width, height, inherit) end

---@param width number Window width
---@param height number Window height
---@param clip boolean|nil Clip content outside window. Default is false.
---@param inherit boolean|nil Inherit current clip region (for nested clip regions)
---@see @https://www.teardowngame.com/modding/api.html#UiWindow
function UiWindow(width, height, clip, inherit) end

---@return number tl_x Top left x
---@return number tl_y Top left y
---@return number br_x Bottom right x
---@return number br_y Bottom right y
---@see @https://www.teardowngame.com/modding/api.html#UiGetCurrentWindow
function UiGetCurrentWindow() end

---@param x number X
---@param y number Y
---@return boolean val True if
---@see @https://www.teardowngame.com/modding/api.html#UiIsInCurrentWindow
function UiIsInCurrentWindow(x, y) end

---@param w number Width
---@param h number Height
---@return boolean value True if rect is fully clipped
---@see @https://www.teardowngame.com/modding/api.html#UiIsRectFullyClipped
function UiIsRectFullyClipped(w, h) end

---@param x number X
---@param y number Y
---@return boolean value True if point is in clip region
---@see @https://www.teardowngame.com/modding/api.html#UiIsInClipRegion
function UiIsInClipRegion(x, y) end

---@param w number Width
---@param h number Height
---@return boolean value True if rect is not overlapping clip region
---@see @https://www.teardowngame.com/modding/api.html#UiIsFullyClipped
function UiIsFullyClipped(w, h) end

---@return number x0 Left
---@return number y0 Top
---@return number x1 Right
---@return number y1 Bottom
---@see @https://www.teardowngame.com/modding/api.html#UiSafeMargins
function UiSafeMargins() end

---@return table value Canvas width and height
---@see @https://www.teardowngame.com/modding/api.html#UiCanvasSize
function UiCanvasSize() end

---@param alignment string Alignment keywords
---@see @https://www.teardowngame.com/modding/api.html#UiAlign
function UiAlign(alignment) end

---@param alignment string Alignment keyword
---@see @https://www.teardowngame.com/modding/api.html#UiTextAlignment
function UiTextAlignment(alignment) end

---@param force boolean|nil Pass true if you need to increase the priority of this modal in the context
---@see @https://www.teardowngame.com/modding/api.html#UiModalBegin
function UiModalBegin(force) end

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

---@return number x X coordinate
---@return number y Y coordinate
---@see @https://www.teardowngame.com/modding/api.html#UiGetCanvasMousePos
function UiGetCanvasMousePos() end

---@param w number Width
---@param h number Height
---@return boolean inside True if mouse pointer is within rectangle
---@see @https://www.teardowngame.com/modding/api.html#UiIsMouseInRect
function UiIsMouseInRect(w, h) end

---@param point TVec 3D world position as vector
---@return number x X coordinate
---@return number y Y coordinate
---@return number distance Distance to point
---@see @https://www.teardowngame.com/modding/api.html#UiWorldToPixel
function UiWorldToPixel(point) end

---@param x number X coordinate
---@param y number Y coordinate
---@return TVec direction 3D world direction as vector
---@see @https://www.teardowngame.com/modding/api.html#UiPixelToWorld
function UiPixelToWorld(x, y) end

---@see @https://www.teardowngame.com/modding/api.html#UiGetCursorPos
function UiGetCursorPos() end

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
---@param maxChars number|nil Maximum amount of characters. Default 100000.
---@return number w Width of text
---@return number h Height of text
---@return number x End x-position of text.
---@return number y End y-position of text.
---@return string linkId Link id of clicked link
---@see @https://www.teardowngame.com/modding/api.html#UiText
function UiText(text, move, maxChars) end

---@param disable boolean Enable or disable wildcard [[...]] substitution support in UiText
---@see @https://www.teardowngame.com/modding/api.html#UiTextDisableWildcards
function UiTextDisableWildcards(disable) end

---@param uniform boolean Enable or disable fixed line height for text rendering
---@see @https://www.teardowngame.com/modding/api.html#UiTextUniformHeight
function UiTextUniformHeight(uniform) end

---@param text string A text string
---@return number w Width of text
---@return number h Height of text
---@return number x Offset x-component of text AABB
---@return number y Offset y-component of text AABB
---@see @https://www.teardowngame.com/modding/api.html#UiGetTextSize
function UiGetTextSize(text) end

---@param space number Space between lines
---@param text string , ... A text strings
---@return number w Width of biggest line
---@return number h Height of all lines combined with interval
---@see @https://www.teardowngame.com/modding/api.html#UiMeasureText
function UiMeasureText(space, text) end

---@param text string Text
---@return number count Symbols count
---@see @https://www.teardowngame.com/modding/api.html#UiGetSymbolsCount
function UiGetSymbolsCount(text) end

---@param text string Text
---@param from number From element index
---@param to number To element index
---@return string substring Substring
---@see @https://www.teardowngame.com/modding/api.html#UiTextSymbolsSub
function UiTextSymbolsSub(text, from, to) end

---@param width number Maximum width of text
---@see @https://www.teardowngame.com/modding/api.html#UiWordWrap
function UiWordWrap(width) end

---@param value number Text linespacing
---@see @https://www.teardowngame.com/modding/api.html#UiTextLineSpacing
function UiTextLineSpacing(value) end

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

---@param width number Rectangle width
---@param height number Rectangle height
---@param thickness number Rectangle outline thickness
---@see @https://www.teardowngame.com/modding/api.html#UiRectOutline
function UiRectOutline(width, height, thickness) end

---@param width number Rectangle width
---@param height number Rectangle height
---@param roundingRadius number Round corners radius
---@see @https://www.teardowngame.com/modding/api.html#UiRoundedRect
function UiRoundedRect(width, height, roundingRadius) end

---@param width number Rectangle width
---@param height number Rectangle height
---@param roundingRadius number Round corners radius
---@param thickness number Rectangle outline thickness
---@see @https://www.teardowngame.com/modding/api.html#UiRoundedRectOutline
function UiRoundedRectOutline(width, height, roundingRadius, thickness) end

---@param radius number Circle radius
---@see @https://www.teardowngame.com/modding/api.html#UiCircle
function UiCircle(radius) end

---@param radius number Circle radius
---@param thickness number Circle outline thickness
---@see @https://www.teardowngame.com/modding/api.html#UiCircleOutline
function UiCircleOutline(radius, thickness) end

---@param path string Path to image (PNG or JPG format)
---@see @https://www.teardowngame.com/modding/api.html#UiFillImage
function UiFillImage(path) end

---@param amount number Blur amount (0.0 to 1.0)
---@see @https://www.teardowngame.com/modding/api.html#UiBackgroundBlur
function UiBackgroundBlur(amount) end

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
---@see @https://www.teardowngame.com/modding/api.html#UiUnloadImage
function UiUnloadImage(path) end

---@param path string Path to image (PNG or JPG format)
---@return boolean exists Does the image exists at the specified path
---@see @https://www.teardowngame.com/modding/api.html#UiHasImage
function UiHasImage(path) end

---@param path string Path to image (PNG or JPG format)
---@return number w Image width
---@return number h Image height
---@see @https://www.teardowngame.com/modding/api.html#UiGetImageSize
function UiGetImageSize(path) end

---@param path string Path to image (PNG or JPG format)
---@param width number Width
---@param height number Height
---@param borderWidth number|nil Border width. Default 0
---@param borderHeight number|nil Border height. Default 0
---@see @https://www.teardowngame.com/modding/api.html#UiImageBox
function UiImageBox(path, width, height, borderWidth, borderHeight) end

---@param path string Path to sound file (OGG format)
---@param volume number|nil Playback volume. Default 1.0
---@param pitch number|nil Playback pitch. Default 1.0
---@param panAzimuth number|nil Playback stereo panning azimuth (-PI to PI). Default 0.0.
---@param panDepth number|nil Playback stereo panning depth (0.0 to 1.0). Default 1.0.
---@see @https://www.teardowngame.com/modding/api.html#UiSound
function UiSound(path, volume, pitch, panAzimuth, panDepth) end

---@param path string Path to looping sound file (OGG format)
---@param volume number|nil Playback volume. Default 1.0
---@param pitch number|nil Playback pitch. Default 1.0
---@see @https://www.teardowngame.com/modding/api.html#UiSoundLoop
function UiSoundLoop(path, volume, pitch) end

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

---@param distX number Press distance along X axis
---@param distY number Press distance along Y axis
---@see @https://www.teardowngame.com/modding/api.html#UiButtonPressDist
function UiButtonPressDist(distX, distY) end

---@param type number One of the enum value
---@see @https://www.teardowngame.com/modding/api.html#UiButtonTextHandling
function UiButtonTextHandling(type) end

---@param text string Text on button
---@param w number|nil Button width
---@param h number|nil Button height
---@return boolean pressed True if user clicked button
---@see @https://www.teardowngame.com/modding/api.html#UiTextButton
function UiTextButton(text, w, h) end

---@param path string Image path (PNG or JPG file)
---@return boolean pressed True if user clicked button
---@see @https://www.teardowngame.com/modding/api.html#UiImageButton
function UiImageButton(path) end

---@param w number Button width
---@param h number Button height
---@return boolean pressed True if user clicked button
---@see @https://www.teardowngame.com/modding/api.html#UiBlankButton
function UiBlankButton(w, h) end

---@param path string Image path (PNG or JPG file)
---@param axis string Drag axis, must be 'x' or 'y'
---@param current number Current value
---@param min number Minimum value
---@param max number Maximum value
---@return number value New value, same as current if not changed
---@return boolean done True if user is finished changing (released slider)
---@see @https://www.teardowngame.com/modding/api.html#UiSlider
function UiSlider(path, axis, current, min, max) end

---@param r number Red channel
---@param g number Green channel
---@param b number Blue channel
---@param a number Alpha channel
---@see @https://www.teardowngame.com/modding/api.html#UiSliderHoverColorFilter
function UiSliderHoverColorFilter(r, g, b, a) end

---@param width number Thumb width
---@param height number Thumb height
---@see @https://www.teardowngame.com/modding/api.html#UiSliderThumbSize
function UiSliderThumbSize(width, height) end

---@return number handle Handle to the screen running this script or zero if none.
---@see @https://www.teardowngame.com/modding/api.html#UiGetScreen
function UiGetScreen() end

---@param w number Width of the component
---@param h number Height of the component
---@return string id Generated ID of the component which can be used to get an info about the component state
---@see @https://www.teardowngame.com/modding/api.html#UiNavComponent
function UiNavComponent(w, h) end

---@param ignore boolean|nil Whether ignore the navigation in a current UI scope or not.
---@see @https://www.teardowngame.com/modding/api.html#UiIgnoreNavigation
function UiIgnoreNavigation(ignore) end

---@see @https://www.teardowngame.com/modding/api.html#UiResetNavigation
function UiResetNavigation() end

---@see @https://www.teardowngame.com/modding/api.html#UiNavSkipUpdate
function UiNavSkipUpdate() end

---@param id string Navigation id of the component
---@return boolean focus Flag whether the component in focus on not
---@see @https://www.teardowngame.com/modding/api.html#UiIsComponentInFocus
function UiIsComponentInFocus(id) end

---@param id string|nil Name of navigation group. If not presented, will be generated automatically.
---@return string id Generated ID of the group which can be used to get an info about the group state
---@see @https://www.teardowngame.com/modding/api.html#UiNavGroupBegin
function UiNavGroupBegin(id) end

---@see @https://www.teardowngame.com/modding/api.html#UiNavGroupEnd
function UiNavGroupEnd() end

---@param w number Width of the component
---@param h number Height of the component
---@see @https://www.teardowngame.com/modding/api.html#UiNavGroupSize
function UiNavGroupSize(w, h) end

---@param id string Id of the component
---@see @https://www.teardowngame.com/modding/api.html#UiForceFocus
function UiForceFocus(id) end

---@return string id Id of the focused component
---@see @https://www.teardowngame.com/modding/api.html#UiFocusedComponentId
function UiFocusedComponentId() end

---@param n number|nil Take n-th parent of the focused component insetad of the component itself
---@return table rect Rect object with info about the component bounding rectangle
---@see @https://www.teardowngame.com/modding/api.html#UiFocusedComponentRect
function UiFocusedComponentRect(n) end

---@return number x Width
---@return number y Height
---@see @https://www.teardowngame.com/modding/api.html#UiGetItemSize
function UiGetItemSize() end

---@param value boolean 
---@see @https://www.teardowngame.com/modding/api.html#UiAutoTranslate
function UiAutoTranslate(value) end

---@see @https://www.teardowngame.com/modding/api.html#UiBeginFrame
function UiBeginFrame() end

---@see @https://www.teardowngame.com/modding/api.html#UiResetFrame
function UiResetFrame() end

---@param width number Width
---@param height number Height
---@see @https://www.teardowngame.com/modding/api.html#UiFrameOccupy
function UiFrameOccupy(width, height) end

---@return number width Width of content drawn between since UiBeginFrame was called
---@return number height Height of content drawn between since UiBeginFrame was called
---@see @https://www.teardowngame.com/modding/api.html#UiEndFrame
function UiEndFrame() end

---@param skip boolean Should skip item
---@see @https://www.teardowngame.com/modding/api.html#UiFrameSkipItem
function UiFrameSkipItem(skip) end

---@return number frameNo Frame number since the level start
---@see @https://www.teardowngame.com/modding/api.html#UiGetFrameNo
function UiGetFrameNo() end

---@return number index Language index
---@see @https://www.teardowngame.com/modding/api.html#UiGetLanguage
function UiGetLanguage() end

---@param state number 
---@see @https://www.teardowngame.com/modding/api.html#UiSetCursorState
function UiSetCursorState(state) end

