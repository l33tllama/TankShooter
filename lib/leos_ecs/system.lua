-- basic system part of ECS
local System = class('System')

function system:initialize()
  self.targets = {}
  self.active = true
end

function system:addEntity(entity)
  -- do I need a category??
  self.targets[entity.id] = entity
end

function system:removeEntity(entity)
  self.targets[entity.id] = nill
end