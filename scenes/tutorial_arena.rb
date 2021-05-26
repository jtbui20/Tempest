require 'gosu'
require './draw_engine/Point'
require './draw_engine/iso_grid'
require './game_engine/player'
require './game_engine/character'
require './game_engine/reticle'

class TUT_ARENA < Scene
  def initialize master
    super('Tutorial', master)
    
    t = Gosu::Image.new("assets/dirt_N.png")
    @grid = Grid.new(t, 10, 10, @master.width, @master.height)
    @player = Player.new(self, Point.new(500,500))
    @filler = Character.new(self, Point.new(800, 200))

    @elements.push (@filler)
    @elements.push (@player)

    @is_clickable = false
  end

  def finalize_init
    @elements.push(Reticle.new(self))
    @full_init = !@full_init
  end

  def draw
    @grid.draw
    @elements.each { |i| i.draw}
  end

  def update
    unless @full_init
      finalize_init
    end

    collidables = @elements.reject{ |c| !defined?(c.collider)}
    collidables.each do |i|
      collidables.each do |j|
        unless i == j
          if i.collider.collision_2d?(j.collider.position, j.collider.dimensions)
              i.collider.add_collision(j)
          end
        end
      end
      i.handle_collision
    end
    collidables.each { |i| i.collider.clear_collisions}
    @elements.each { |i| i.update}
  end

  def button_down(id)
    @player.button_down(id)
  end
end