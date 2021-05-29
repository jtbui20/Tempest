require 'gosu'
require './draw_engine/Point'
require './draw_engine/Collider'
require './draw_engine/Layers'
require './game_engine/Object'
require './game_engine/Stats.rb'
require './game_engine/projectile.rb'

class Character < GameObject
  attr_accessor :position, :collider, :dimensions, :character_stats

  def initialize(name, master, position)
    super name, master, position, Layers::CHARACTERS
    
    @img = Gosu::Image.new('assets/barrel_N.png')
    @dimensions = Point.new(@img.width, @img.height)
    @position = position
    @position_center = position + (@dimensions / 2)

    @hit_layers = [Layers::DESTRUCTIBLE, Layers::CHARACTERS]
    @collider = Collider.new(self, @position, Point.new(@img.width, @img.height), @hit_layers)
    @character_stats = CharacterStats.new(ClassType::Augmenter, [[Stats::ATK, true, 10], [Stats::DEF, false, 10]] , "")
  end

  def draw
    @img.draw(@position.x, @position.y, 1)
  end

  def update
    @position_center = position + (@dimensions / 2)
    @collider.update(@position)
    if @character_stats.hp <= 0;
      puts "ded"
      @master.remove_element(self)
    end
  end

  def handle_collision
    @collider.execute_collisions.each do |other|
      if other.is_a?(Projectile)
        @character_stats.hp -= 10
      end
    end
  end
end
