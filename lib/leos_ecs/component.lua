-- Basic component class
-- extends middleclass

Component = {}

Component.all = {}

function Component.create(name, fields, defaults)
  local component = class(name)
  
  if fields then
    defaults = defaults or {}
    component.initialize = function(self, ...)
      local args = {...}
      for index, field in ipairs(fields) do
        self[field] = args[index] or defaults[field]
      end
    end
  end
  
  -- add to all table for retrieval later in creating systems
  Component.all[component.name] = component
  
end


-- load requested components for systems that use various components
function Component.load(names)
  local components = {}
  
  for _, name in pairs(names) do
    components[#components+1] = Component.all[name]
  end
  
  return unpack(components)
end
  
