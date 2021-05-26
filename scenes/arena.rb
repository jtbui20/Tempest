require 'gosu'
require './draw_engine/Point'
require './draw_engine/iso_grid'
require './game_engine/character'
require './game_engine/projectile'

class ARENA < Scene
  def initialize master
    super('Arena', master)
    t = Gosu::Image.new("assets/dirt_N.png")
    @grid = Grid.new(t, 10, 10, $WIDTH, $HEIGHT)
    @character = Character.new(Point.new(500,500))
    @reticle = Gosu::Image.new("assets/reticle.png")
    @bullets = Array.new()
  end

  def draw
    @grid.draw
    @character.draw
    @reticle.draw(mouse_x - @reticle.width / 2, mouse_y - @reticle.height / 2, 3)
    for i in @bullets do
      i.draw
    end
  end

  def update
    handle_player_input
  end

  def handle_player_input
    movement = Point.new(0,0)
    if button_down?(Gosu::KB_W)
      movement += Point.new(0,-0.5)
    elsif button_down?(Gosu::KB_S)
      movement += Point.new(0,0.5)
    end

    if button_down?(Gosu::KB_A)
      movement += Point.new(-1,0)
    elsif button_down?(Gosu::KB_D)
      movement += Point.new(1,0)
    end

    if button_down?(Gosu::MS_RIGHT)
      @character.Move(movement.direction, 10.0)
    else
      @character.Move(movement.direction)
    end

    if button_down?(Gosu::MS_LEFT)
      @bullets.push(
        Projectile.new(Point.new(@character.position.x, @character.position.y), Point.new(mouse_x,mouse_y), 10.0)
      )
    end
  end
end