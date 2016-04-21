-- basic system part of ECS
System = class('System')

function System:requires() return {} end

function System:initialize()
  self.targets = {}
  self.active = true
end

function System:addEntity(entity, category)
  if category then
    if not self.targets[category] then
      self.targets[category] = {}
    end
    self.targets[category][entity.id] = entity
  end
  self.targets[entity.id] = entity
end

function System:removeEntity(entity)
 if table.firstElement(self.targets) then
        if table.firstElement(self.targets).class then
            self.targets[entity.id] = nil
        else
            -- Removing entities from their respective category target list.
            for index, _ in pairs(self.targets) do
                if component then
                    for _, req in pairs(self:requires()[index]) do
                        if req == component then
                            self.targets[index][entity.id] = nil
                            break
                        end
                    end
                else
                    self.targets[index][entity.id] = nil
                end
            end
        end
    end
end