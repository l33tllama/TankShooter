local Position = Component.create("Position")

print("Hello from Position")

function Position:initialize(x, y)
  if x then self.x = x end
  if y then self.y = y end
end