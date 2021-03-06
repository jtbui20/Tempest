# * Player defines control based inputs and client side player behaviour.
# * Due to the external conditions, inputs and logic behaviour were implemented together to produce a functional demonstration.
# * The use of OOP Principle: Inheritance & Polymorphism, was justified as a Player is a Character, and contains the functionality and behaviour of a Character.

require 'gosu'
require './game_engine/Character'
require './draw_engine/Point'
require './game_engine/Timer'
require './game_engine/projectile'
require './draw_engine/anchors'
require './game_engine/Buffs'
require './game_engine/CharacterAttributes'
require './draw_engine/CharAnimController.rb'

class Player < Character
  def initialize(master, position)
    super("PlayerA", master, position)

    @dash_anim = Timer.new(duration = 260)
    @dash_cooldown = Timer.new(duration = 150)
    @img = Gosu::Image.load_tiles("assets/NewWizard.png", 48, 48)
    @anim = CharAnimController.new()
    @direction = Point.new(0,0)

    @speed = 0
    @is_dash = false
    @is_char_lock = false

    set_anim_observers()
    buff_test()
  end

  def set_anim_observers
    @anim.set_observer(:speed, -> { @speed * @direction.magnitude })
         .set_observer(:angle, -> { @direction.angle_between_vector(Point.new(1,0)) })
  end

  def draw
    frame = (Gosu.milliseconds / @anim.duration) % @anim.getState.duration
    flip_fix = (@anim.vert_flip == -1) ? 48 * 2 : 0
    @img[frame + @anim.getState.start].draw(@position.x + flip_fix, @position.y,  @layer, 2 * @anim.vert_flip, 2)
  end

  def Move(direction, speed = 5.0)
    @speed = speed * @character_stats.get_agi.call
    @position += (direction * @speed)
  end

  def update
    handle_player_input
    @anim.update
    @dash_anim.update
    @dash_cooldown.update

    if @is_dash && @dash_anim.complete?
      @is_dash = !@is_dash
      @dash_cooldown.restart_now
    end
    
    super
  end

  def handle_player_input
    movement = Point.new(0, 0)
    unless @is_char_lock
      # ! N/S 0.5 & 30deg
      # ! N/S 1 & 45 deg
      if Gosu.button_down?(Gosu::KB_W)
        movement += Point.new(0, -1)
      elsif Gosu.button_down?(Gosu::KB_S)
        movement += Point.new(0, 1)
      end

      if Gosu.button_down?(Gosu::KB_A)
        movement += Point.new(-1, 0)
      elsif Gosu.button_down?(Gosu::KB_D)
        movement += Point.new(1, 0)
      end
    end

    @direction = movement.direction
    @is_dash ? Move(@direction, 10) : Move(@direction)
  end

  def button_down(id)
    case id
    when Gosu::MS_RIGHT 
      if @dash_cooldown.complete? && !@is_dash
        @is_dash = !@is_dash
        @dash_anim.restart_now
      end
    when Gosu::MS_LEFT
      mouse = @master.mouse_pos
      direction = (mouse - @position).direction * 50

      @master.add_element(Projectile.new(@master, @position_center + direction, mouse, 10.0, @character_stats.get_atk.call))
    when Gosu::KB_SPACE
      puts @character_stats.get_current_buff.to_s
      puts @direction.angle_between_vector(Point.new(1,0))
    when Gosu::KB_Y
      @character_stats.trigger_buff(@buffA)
      puts "resolve"
    when Gosu::KB_U
      @character_stats.trigger_buff(@buffB)
    when Gosu::KB_J
      @character_stats.trigger_buff(@debuffA)
    when Gosu::KB_I
      puts "Attack : #{@character_stats.gmods.get_total(Stats::ATK)}"
      puts "Defense : #{@character_stats.gmods.get_total(Stats::DEF)}"
      puts "Haste : #{@character_stats.gmods.get_total(Stats::HASTE)}"
      puts "Agility : #{@character_stats.gmods.get_total(Stats::AGI)}"
    when Gosu::KB_K
      @character_stats.hp -= 100
    end
  end

  def buff_test
    @buffA = Buff.new("It works!", 1, 30,
      Modifier.new(@gmods, "Attack", Stats::ATK, 1.25),
      Modifier.new(@gmods, "Haste", Stats::HASTE, 1.5))
    @buffB = Buff.new("Buffing system implemented!", 1, 45,
      Modifier.new(@gmods, "Agility", Stats::AGI, 1.5),
      Modifier.new(@gmods, "Defence", Stats::DEF, 1.3))
    @debuffA = Buff.new("Def Down", 0, 45,
      Modifier.new(@gmods, "Attack", Stats::ATK, 0.5))
  end

  def gen_select_circle
    # TODO: Stop camera pan, draw UI elements
    # TODO: UI element reports back to Player
    # TODO: Player reports to SkillManager
  end
end
