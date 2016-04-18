--[[
  Initial file for leo's ECS implementation
  Creates a 'systems' object that holds all of the currently running systems,
  and updates them.
--]]

local path = ...

local List = require(path .. '.list')

print("Hello from leos_ecs.lua")

-- create a list of systems
local ecs = class('Systems')

function ecs:initialize()
  self.systems_list = List.new()
  self.systems_list["update"] = List.new()
  self.systems_list["draw"] = List.new()
  self.entities = List.new()
  print('Created ecs..')
end

function ecs:addEntity(entity)
  local entity_id = #self.entities + 1
  entity.id = entity_id
  List.add(self.entities, entity)
end

function ecs:removeEntity(entity)
  List.remove(self.entities, entity)
end

function ecs:addSystem(system)
  List.add(self.systems_list, system)
  if system.draw then
    List.add(self.systems_list["draw"], system)
  elseif system.update then
    List.add(self.systems_list["update"], system)
  end
end  

function ecs:removeSystem(system)
  List.remove(self.systems_list, system)
end

function ecs:update(dt)
  List.callClassFunction(self.systems_list["update"], update, dt)
end

return ecs