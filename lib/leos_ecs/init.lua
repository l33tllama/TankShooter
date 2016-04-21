--[[
  Initial file for leo's ECS implementation
  Creates a 'systems' object that holds all of the currently running systems,
  and updates them.
--]]

local path = ...

--local List = require(path .. '.list')

print("Hello from leos_ecs.lua")
require(path .. '.system')
require(path .. '.component')
-- create a list of systems
local ecs = class('Systems')

function ecs:initialize()
  self.systems_list = {}
  self.systems_list["update"] = {}
  self.systems_list["draw"] = {}
  self.systemRegistry = {}
  self.entities = {}
  self.singleRequirements = {}
  self.allRequirements = {}
  self.entityLists = {}
  print('Created ecs..')
end

function ecs:addEntity(entity)
  local entity_id = #self.entities + 1
  entity.id = entity_id
  table.insert(self.entities, entity)
  
  for _, component in pairs(entity.components) do
    local name = component.class.name
    
    if not self.entityLists[name] then
      self.entityLists[name] = {}
    end
    self.entityLists[name][entity.id] = entity
    
    if self.singleRequirements[name] then
      for _, system in pairs(self.singleRequirements[name]) do
        print("Loading requirements for new entity.. " .. system.class.name)
        self:checkSystemRequirements(entity, system)
      end
    end
  end
end

function ecs:removeEntity(entity)
  table.remove(self.entities, entity)
end

function ecs:registerSystem(system)
  local name = system.class.name
  self.systemRegistry[name] = system
  
  if system:requires()[1] and type(system:requires()[1]) == "string" then
    for index, req in pairs(system:requires()) do
      if index == 1 then
        self.singleRequirements[req] = self.singleRequirements[req] or {}
        table.insert(self.singleRequirements[req], system)
      end
      self.allRequirements[req] = self.allRequirements[req] or {}
      table.insert(self.allRequirements[req], system)
    end
  end
end 

function ecs:callClassFunction(tb, func, args)
  for _, item in pairs(tb) do
    if item[func] then
      item[func](item, args)
    end
  end
end

function ecs:checkSystemRequirements(entity, system)
  local meetsrequirements = true
  local category = nil
  for index, req in pairs(system:requires()) do
    if type(req) == "string" then
      if not entity.components[req] then
        meetsrequirements = false
        print("Error: Entity does not have system: ".. req)
        break
      end
    elseif type(req) == table then
      for _, req2 in pairs(req) do
        if not entity.components[req2] then
          meetsrequirements = false
          print("Error: Entity does not have system: ".. req2)
          break
        end
      end
      if meetsrequirements == true then
        category = index
        system:addEntity(entity, category)
      end
    end
  end
  if meetsrequirements == true and category == nil then
    system:addEntity(entity)
  end
end

function ecs:addSystem(system)
  local name = system.class.name
  print("Adding system " .. name)
  if not (self.systemRegistry[name]) then
    self:registerSystem(system)
  end
  
  table.insert(self.systems_list, system)
  if system.draw then
    print("Adding a system that calls draw() " .. name)
    table.insert(self.systems_list["draw"], system)
  elseif system.update then
    print("Adding a system that calls update() " .. name)
    table.insert(self.systems_list["update"], system)
  end
  
  for _, entity in pairs(self.entities) do
    self:checkSystemRequirements(entity, system)
  end
end  

function ecs:removeSystem(system)
  table.remove(self.systems_list, system)
end

function ecs:update(dt)
  self:callClassFunction(self.systems_list["update"], "update", dt)
end

function ecs:draw(dt)
  for _, item in pairs(self.systems_list["draw"]) do
    if item.draw then
      item:draw()
    end
  end
  --self:callClassFunction(self.systems_list["draw"], "draw")
end

return ecs