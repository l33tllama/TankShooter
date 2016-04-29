local PlayerSpeed = Component.create("PlayerSpeed")

function PlayerSpeed:initialize(speed)
  if speed then 
    self.speed = speed
    self.speed_45 = self.speed * (1/math.sqrt(2)) 
  end
  
end