-- barebones basic entity class
local entity = class('Entity')

function entity:initialize(name)
  self.components = {}
  self.name = name
end

function entity:add(component)
  local name = component.class.name
  self.components[name] = component
end

function entity:remove(component)
  local name = component.class.name
  if self.components[name] then
    self.components[name] = nil
  end
end
   