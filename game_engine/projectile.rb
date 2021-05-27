require 'gosu'
require './draw_engine/Point'
require './draw_engine/Collider.rb'

class Projectile < GameObject
  attr_accessor :collider
  def initialize(master, position, destination, magnitude)
    super master

    @img = Gosu::Image.new('assets/projectile.png')
    @dimensions = Point.new(@img.width, @img.height)

    @position = position - @dimensions / 2
    @destination = destination - @dimensions / 2
    @direction = (destination - position).direction
    @magnitude = magnitude

    @collider = Collider.new("hi", @position, Point.new(@img.width, @img.height), Layers::DESTRUCTIBLE)
  end

  def update
    if @position.within_radius?(@destination, 15)
      @master.remove_element(self)
    else
      @position += @direction * @magnitude
    end

    @collider.update(@position)
  end

  def draw
    @img.draw(@position.x, @position.y, 2)
  end

  def handle_collision
    unless @collider.execute_collisions == []
      @master.remove_element(self)
    end
  end
end
