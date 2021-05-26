require 'gosu'
require './draw_engine/Point'
require './draw_engine/Layers'
require './draw_engine/GosuDrawExtensions'

class Collider
  attr_accessor :position, :dimensions, :collisions
  def initialize (master, position, dimensions, layer)
    @position = position
    @dimensions = dimensions
    @master = master
    @layer = layer

    @collisions = []
    @hitbox_visible = true
  end

  def add_collision (item)
    unless @collisions.include? item
      @collisions << item
    end
  end

  def execute_collisions
    @collisions
  end

  def clear_collisions
    @collisions = []
  end

  def collision_1d? (other_position)
    @position <= other_position && @other_position < @position + @dimensions
  end

  # https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection
  def collision_2d? (other_position, other_dimensions)
    @position.x <= other_position.x + other_dimensions.x &&
    @position.x + @dimensions.x >= other_position.x &&
    @position.y <= other_position.y + other_dimensions.y &&
    @position.y + @dimensions.y >= other_position.y
  end

  def update (position)
    @position = position
  end
end