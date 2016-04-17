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
local ecs = class('Systems')

function ecs:initialize()
  self.systems_list = List.new()
  self.entities = {}
end

function ecs:addEntity(entity)
  local entity_id = #self.entities + 1
  entity.id = entity_id
end

function ecs:removeEntity(entity)
  self.entites[entity.id].alive = false
  self.entites[entity.id] = nil

function ecs:addSystem(system)
  List.add(self.systems_list, system)
end  

function ecs:removeSystem(system)
  List.remove(self.systems_list, system)
end

function ecs:update(dt)
  for system,_ in self.systems_list do
    system:update(dt)
  end
end

return ecs