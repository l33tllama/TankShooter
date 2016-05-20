local Animated = Component.create("Animated")

function Animated:initialize(sheet_image, sheet_rows, sheet_cols, sprite_width, sprite_height, play_speed)
  self.image = sheet_image
  self.rows = sheet_rows
  self.cols = sheet_cols
  self.current_frame = 0
  self.quads = {}
  self.width = sprite_width
  self.height = sprite_height
  self.sheet_width = self.cols * self.width
  self.sheet_height = self.rows * self.height
  
  for col=0, self.cols, 1 do
    self.quads[col + 1] = {}
    for row=0, self.rows, 1 do
      self.quads[col + 1][row + 1] = love.graphics.newQuad(row * self.width ,col * self.height, 
        self.width, self.height, self.sheet_width, self.sheet_height)
     end
   end  
end