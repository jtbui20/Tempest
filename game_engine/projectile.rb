require 'gosu'
require './draw_engine/Point'
require './draw_engine/Collider.rb'

class Projectile < GameObject
  attr_accessor :collider
  def initialize(master, position, destination, magnitude)
    super master
    @p = Gosu::Image.new('assets/projectile.png')
    @dimensions = Point.new(@p.width / 2, @p.height / 2)
    @position = position - @dimensions
    @magnitude = magnitude
    @direction = (destination - @dimensions - position).direction
    @destination = destination

    @collider = Collider.new("hi", @position, Point.new(@p.width, @p.height), Layers::DESTRUCTIBLE)
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
    @p.draw(@position.x, @position.y, 2)
  end

  def handle_collision
    unless @collider.execute_collisions == []
      @master.remove_element(self)
    end
  end
end
