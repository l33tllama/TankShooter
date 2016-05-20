local Animation = class("Animation", System)

function Animation:draw()
  for i, v in pairs(self.targets) do
    local pos = v:get("Position")
    local scale = v:get("Scaleable")
    local drawable = v:get("Drawable")
    local anim = v:get("Animated")
    local rotation = v:get("Rotation")
    local img_sheet = anim.image
    local quads = anim.quads
    
    local quad = quads[1][1]
    
    --rotation.angle = (rotation.angle + rotation.step) % 360
    if rotation then
      local quad_id_c = (rotation.angle / rotation.step) % anim.cols
      
      local quad_id_r = math.floor(rotation.angle / (anim.cols * rotation.step))
      --print("drawing quad " .. quad_id_c .. ", " .. quad_id_r)
      quad = quads[quad_id_c + 1][quad_id_r + 1]
    end
       
    love.graphics.draw(img_sheet, quad, pos.x, pos.y)
  end
end

function Animation:requires()
  return {"Position", "Animated"}
end

return Animation