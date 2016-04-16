--[[
  Initial file for leo's ECS implementation
  Creates a 'systems' object that holds all of the currently running systems,
  and updates them.
--]]

local path = ...
require(path .. '.system')
local List = dofile(path .. '/list.lua')

print("Hello from leos_ecs.lua")

-- create a list of systems
local systems = class('Systems')

function systems:initialize()
  self.systems_list = List.new()
end

function systems:addSystem(system)
  List.add(self.systems_list, system)
end  

function systems:removeSystem(system)
  List.remove(self.systems_list, system)
end

function systems:update(dt)
  for system,_ in self.systems_list do
    system:update(dt)
  end
end