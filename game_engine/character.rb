# * Character defines the underlying foundation of a character within the screen, particularly event handlers or logic handlers.
# * It was evident through design that there would be multiple characters.
# * The use of OOP Principles: Abstractation & Inheritance, was used to cater for the flexibility.

require 'gosu'
require './draw_engine/Point'
require './draw_engine/Collider'
require './draw_engine/Layers'
require './game_engine/Object'
require './game_engine/CharacterStats'
require './game_engine/projectile.rb'
require './game_engine/CharacterAttributes'

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

  def draw()
    @img.draw(@position.x, @position.y, 1)
  end

  def update()
    @position_center = position + (@dimensions / 2)
    @collider.update(@position)
    if @character_stats.hp <= 0;
      puts "ded"
      @master.remove_element(self)
    end
  end

  def handle_collision()
    @collider.execute_collisions.each do |other|
      if other.is_a?(Projectile)
        @character_stats.hp -= (other.atk / @character_stats.get_def.call)
        @character_stats.hp = 0 if @character_stats.hp <= 0
      end
    end
  end
end
