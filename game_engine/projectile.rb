require 'gosu'
require './draw_engine/Point'
require './draw_engine/Collider.rb'

class Projectile < GameObject
  attr_accessor :collider, :atk
  def initialize(master, position, destination, magnitude, atk)
    super "Projectile", master, nil, Layers::DESTRUCTIBLE 

    @img = Gosu::Image.new('assets/projectile.png')
    @dimensions = Point.new(@img.width, @img.height)

    @position = position - @dimensions / 2
    @destination = destination - @dimensions / 2
    @direction = (destination - position).direction
    @magnitude = magnitude
    @atk = atk.call

    @hit_layers = [Layers::DESTRUCTIBLE, Layers::CHARACTERS]
    @collider = Collider.new(self, @position, Point.new(@img.width, @img.height), @hit_layers)
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
    @master.remove_element(self)
  end
end
