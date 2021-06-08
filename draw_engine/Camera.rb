class Camera
  attr_reader :width, :height, :offset_x, :offset_y
  
  def initialize(width, height)
      @width = width
      @height = height
      @offset_x = 0
      @offset_y = 0
  end

  def move(x,y)
      @offset_x = x
      @offset_y = y
  end

  # ? Add scale function
  # ? Add layer filter
  # ? Route all elements to camera
  # ? Add draw function
  # ? Overlays
  # ? Re-arrange scenes & camera
  # ? Add tracking / loci tracks
end