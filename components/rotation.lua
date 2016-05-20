local Rotation = Component.create("Rotation")

function Rotation:initialize(angle, step)
  self.angle = angle
  self.step = step
end