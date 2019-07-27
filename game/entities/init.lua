local path = "game/entities/"

local squid = require(path .. 'squid')
local ink = require(path .. 'ink')
local enemy = require(path .. 'enemy')

return {
    squid = squid,
    ink = ink,
    enemy = enemy,
}