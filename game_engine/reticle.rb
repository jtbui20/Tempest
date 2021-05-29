require 'gosu'
require './draw_engine/Layers'
require './draw_engine/Point'
require './game_engine/Object'

class Reticle < GameObject
  attr_accessor :position
  def initialize(scene)
    super("Reticle", scene, Point.new(0,0), Layers::UI)
    @img = Gosu::Image.new("assets/reticle.png")
    @dimensions = Point.new(@img.width, @img.height)
  end

  def draw
    @img.draw(@position.x, @position.y, @layer)
  end

  def update
    @position = @master.mouse_pos - @dimensions / 2
  end
end