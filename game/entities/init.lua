local path = "game/entities/"

local squid = require(path .. 'squid')
local ink = require(path .. 'ink')
local enemy = require(path .. 'enemy')
local crystal = require(path .. 'crystal')


return {
    squid = squid,
    ink = ink,
    enemy = enemy,
    crystal = crystal,
}