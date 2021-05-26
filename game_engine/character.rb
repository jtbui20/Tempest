require 'gosu'
require './draw_engine/Point'
require './draw_engine/Collider'
require './draw_engine/Layers'
require './game_engine/Object'

module Element
  Flame, Water, Wind, Earth, Light, Shadow = 0..5
end

module ClassType
  
  Augmenter, Mage, Summoner = 0..2
end

module Stats
  HP, MP, Atk, Def, Res, Spell_Haste, Agi = 0..6
end

module SpellType
  Slash, Barrier, Movement, Projectile, Buff, Debuff = 0..5
end

class Character < GameObject
  attr_accessor :position, :collider, :dimensions

  def initialize(master, position)
    super master
    
    @img = Gosu::Image.new('assets/barrel_N.png')
    @dimensions = Point.new(@img.width, @img.height)
    @position = position

    @collider = Collider.new("hi", @position, Point.new(@img.width, @img.height), Layers::CHARACTERS)
  end

  def draw
    @img.draw(@position.x, @position.y, 1)
  end

  def update
    @collider.update(@position)
  end

  def handle_collision

  end
end
