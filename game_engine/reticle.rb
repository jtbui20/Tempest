require 'gosu'
require './draw_engine/Layers'
require './draw_engine/Point'
require './game_engine/Object'

class Reticle < GameObject
  attr_accessor :position
  def initialize(scene)
    super(scene)
    @img = Gosu::Image.new("assets/reticle.png")
  end

  def draw
    @img.draw(@position.x, @position.y, Layers::UI)
  end

  def update
    @position = Point.new(@master.mouse_x - @img.width / 2, @master.mouse_y - @img.height / 2)
    
  end
end