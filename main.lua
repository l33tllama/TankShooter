
gdt = 0

local tankImg
local tankX, tankY = 300, 300
local x, y = 0
local tankW, tankH = 0
local tankRot = 0
local tankSpd = 100

function love.load()
  tankImg = love.graphics.newImage("res/img/tank.png")
  tankW = tankImg:getWidth()
  tankH = tankImg:getHeight()
end

function love.update(dt)
  if love.keyboard.isDown("escape") == true then
    love.event.quit()
  end
  local twoKeys = false
  if love.keyboard.isDown('w') == true and love.keyboard.isDown('d') == true then
    tankY = tankY - tankSpd * dt * 0.707
    tankX = tankX + tankSpd * dt * 0.707
    tankRot = math.pi / 4
    twoKeys = true
  elseif  love.keyboard.isDown('d') == true and love.keyboard.isDown('s') == true then
    tankY = tankY + tankSpd * dt * 0.707
    tankX = tankX + tankSpd * dt * 0.707
    tankRot = math.pi * 0.75
    twoKeys = true
  elseif  love.keyboard.isDown('s') == true and love.keyboard.isDown('a') == true then
    tankY = tankY + tankSpd * dt * 0.707
    tankX = tankX - tankSpd * dt * 0.707
    tankRot = math.pi  * 1.25
    twoKeys = true
  elseif  love.keyboard.isDown('a') == true and love.keyboard.isDown('w') == true then
    tankY = tankY - tankSpd * dt * 0.707
    tankX = tankX - tankSpd * dt * 0.707
    tankRot = math.pi  * 1.75
    twoKeys = true
  end
  if not twoKeys == true then
    if love.keyboard.isDown("w") == true then
      tankY = tankY - tankSpd * dt
      tankRot = 0
    elseif love.keyboard.isDown('d') == true then
      tankX = tankX + tankSpd * dt
      tankRot = math.pi / 2
    elseif love.keyboard.isDown('s') == true then
      tankY = tankY + tankSpd * dt
      tankRot = math.pi
    elseif love.keyboard.isDown('a') == true then
      tankX = tankX - tankSpd * dt
      tankRot = 1.5 * math.pi
    end 
  end
  
  x, y = love.mouse.getPosition()
  
  gdt = dt
end


function love.draw()
  love.graphics.print("DeltaTime: " .. gdt, 10, 0)
  love.graphics.push()
  love.graphics.translate(tankX + tankW / 2, tankY + tankH / 2)
  love.graphics.rotate(tankRot)
  love.graphics.translate(-tankX - tankW / 2, -tankY - tankH / 2)
  love.graphics.draw(tankImg, tankX, tankY)
  love.graphics.pop()
end
