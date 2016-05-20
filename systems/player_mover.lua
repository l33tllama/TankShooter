local PlayerMover = class("PlayerMover", System)

function PlayerMover:update(dt)
  for i, v in pairs(self.targets) do
    local pos = v:get("Position")
    local speed = v:get("PlayerSpeed").speed
    local speed_45 = v:get("PlayerSpeed").speed_45
    local rot = v:get("Rotation")
    
    local up = love.keyboard.isDown('w')
    local down = love.keyboard.isDown('s')
    local left = love.keyboard.isDown('a')
    local right = love.keyboard.isDown('d')
    
    
    if up == true and down == true then
    elseif left == true and right == true then
    elseif up == true and right == true then
      pos.x = pos.x + speed_45 * dt
      pos.y = pos.y - speed_45 * dt
      if rot then rot.angle = 360-45 end
    elseif up == true and left == true then
      pos.x = pos.x - speed_45 * dt
      pos.y = pos.y - speed_45 * dt
      if rot then rot.angle = 45 end
    elseif down == true and left == true then
      pos.x = pos.x - speed_45 * dt
      pos.y = pos.y + speed_45 * dt
      if rot then rot.angle = 135 end
    elseif down == true and right == true then
      pos.x = pos.x + speed_45 * dt
      pos.y = pos.y + speed_45 * dt
      if rot then rot.angle = 225 end 
    elseif up == true then
      pos.y = pos.y - speed * dt
      if rot then rot.angle = 0 end
    elseif down == true then
      pos.y = pos.y + speed * dt
      if rot then rot.angle = 180 end
    elseif left == true then
      pos.x = pos.x - speed * dt
      if rot then rot.angle = 90 end
    elseif right == true then
      pos.x = pos.x + speed * dt
      if rot then rot.angle = 270 end
    end
    
    
    --v:set("Position")
  end
end

function PlayerMover:requires()
  return {"Position", "PlayerSpeed"}
end

return PlayerMover