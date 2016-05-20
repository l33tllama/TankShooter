-- Tank shooter
require 'luarocks.loader'
class = require 'middleclass'

ECS = require 'lib/leos_ecs'
Entity = require 'lib/leos_ecs.entity'

-- Load components
require 'components.drawable'
require 'components.position'
require 'components.scaleable'
require 'components.player_speed'
require 'components.animated'
require 'components.rotation'

-- Load systems
local PlayerMover = require 'systems.player_mover'()
local SpritePainter = require 'systems.sprite_painter'()
local Animation = require 'systems.animation'()

gdt = 0

local tankImg
local tankX, tankY = 32, 32
local x, y = 0
local tankW, tankH = 0
local tankRot = 0
local tankSpd = 100
local fps_delay = 0.5
local dt_count = 0
local last_fps = 0

local fixed_res = {x = 128, y = 96}
local window_size = {width = 320, height = 240}

local scale = {}

love.window.setMode(window_size.width, window_size.height)

function love.load()
  
  tankImg = love.graphics.newImage("res/img/tank-base.png")
  tankImg:setFilter("nearest", "nearest")
  tankBaseSheet = love.graphics.newImage("res/img/tank-base-sheet.png")
  tankBaseSheet:setFilter("nearest", "nearest")
  --Font:setFilter("nearest", "nearest")
  tankW = tankImg:getWidth()
  tankH = tankImg:getHeight()
  scale.x = love.graphics.getWidth() / fixed_res.x
  scale.y = love.graphics.getHeight() / fixed_res.y
  --love.window.setMode(fixed_res.x, fixed_res.y)
  
  local Drawable, Position, Scaleable, PlayerSpeed = Component.load({"Drawable", "Position",
   "Scaleable", "PlayerSpeed"})
  local Animated, Rotation = Component.load({"Animated", "Rotation"})
  
  ecs = ECS()
  
  local tank = Entity()
  --tank:addComponent(Drawable(tankImg, 0))
  tank:addComponent(Scaleable(0.5, 0.5))
  tank:addComponent(Position(32, 32))
  tank:addComponent(Rotation(0, 45))
  tank:addComponent(Animated(tankBaseSheet, 3, 3, 32, 32, 1))
  tank:addComponent(PlayerSpeed(50))
  ecs:addSystem(PlayerMover)
  --ecs:addSystem(SpritePainter)
  ecs:addSystem(Animation)
  ecs:addEntity(tank)
  
  --ecs:removeEntity(tank)
  
end

function round(dt, num, idp)
  if dt_count <= 0 then
    local mult = 10^(idp or 0)
    last_fps = math.floor(num * mult + 0.5) / mult
    dt_count = fps_delay
  end
  dt_count = dt_count - dt
  return last_fps
end

function love.update(dt)
    
  ecs:update(dt)
  
  if love.keyboard.isDown("escape") == true then
    love.event.quit()
  end
  
  round(dt, 1/dt, 2)

end

function love.draw()
  ecs:draw()
end
