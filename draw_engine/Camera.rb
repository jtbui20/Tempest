class Camera
  attr_reader :width, :height, :offset_x, :offset._y
  
  def initialize (width, height)
      @width = width
      @height = height
      @offset_x = @offset_y = 0
  end

  def move (x,y)
      @offset_x = x
      @offset_y = y
  end
  # Add readjust function
end