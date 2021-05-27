require 'gosu'
require './game_engine/character'
require './draw_engine/Point'
require './game_engine/Timer'
require './game_engine/projectile'

class Player < Character
  def initialize(master, position)
    super(master, position)

    @dash_anim = Timer.new(duration = 260)
    @dash_cooldown = Timer.new(duration = 150)
    @is_dash = false
  end

  def Move(direction, speed = 5.0)
    @position += (direction * speed)
  end

  def update
    handle_player_input
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
    if Gosu.button_down?(Gosu::KB_W)
      movement += Point.new(0, -0.5)
    elsif Gosu.button_down?(Gosu::KB_S)
      movement += Point.new(0, 0.5)
    end

    if Gosu.button_down?(Gosu::KB_A)
      movement += Point.new(-1, 0)
    elsif Gosu.button_down?(Gosu::KB_D)
      movement += Point.new(1, 0)
    end

    @is_dash ? Move(movement.direction, 7.5) : Move(movement.direction)
  end

  def button_down(id)
    case id
    when Gosu::MS_RIGHT 
      if @dash_cooldown.complete? && !@is_dash
        @is_dash = !@is_dash
        @dash_anim.restart_now
      end
    when Gosu::MS_LEFT
      mouse = Point.new(@master.mouse_x, @master.mouse_y)
      direction = (mouse - @position).direction * 50

      @master.add_element(Projectile.new(@master, @position_center + direction, mouse, 10.0))
    when Gosu::KB_SPACE
      puts @position.x.to_s + " " + @position.y.to_s
    end
  end
end
