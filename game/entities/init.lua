local path = "game/entities/"

local squid = require(path .. 'squid')
local ink = require(path .. 'ink')
local enemy = require(path .. 'enemy')
local crystal = require(path .. 'crystal')
local kelp = require(path .. 'kelp')
local starfish = require(path .. 'starfish')

return {
    squid = squid,
    ink = ink,
    enemy = enemy,
    crystal = crystal,
    kelp = kelp,
    starfish = starfish,
}