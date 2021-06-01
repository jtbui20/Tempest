require 'gosu'
require './draw_engine/Point'
require './draw_engine/Grids'
require './game_engine/player'
require './game_engine/character'
require './game_engine/reticle'
require './draw_engine/Interactibles'

class TUT_ARENA < Scene
  def initialize master
    super('Tutorial', master)
    
    t = Gosu::Image.new("assets/training_room_tiles-01.png")
    @grid = TopDownGrid.new(t, 10, 10, @master.width, @master.height)
    @player = Player.new(self, Point.new(500,500))
    @filler = Character.new("Character", self, Point.new(800, 200))

    @elements << @filler
    @elements << @player

    gen_ui
    @is_clickable = false
    puts find_in_scene("Player")
  end

  def finalize_init
    @elements.push(Reticle.new(self))
    @full_init = !@full_init
  end

  def gen_ui
    @elements << ProgressBar.new("PBar", self, Point.new(20, 20), Point.new(498, 38), 0, -> {0}, @player.character_stats.get_hp_max, @player.character_stats.get_hp, 0xff_00ff00, 0xff_ff0000)
    @elements << ProgressBar.new("PBar", self, Point.new(748, 20), Point.new(498, 38), 1, -> {0}, @filler.character_stats.get_hp_max, @filler.character_stats.get_hp, 0xff_00ff00, 0xffff0000)
    @elements << Text.new("Timer", )
  end

  def draw
    @grid.draw
    @elements.each { |i| i.draw}
  end

  def update
    unless @full_init
      finalize_init
    end

    super
  end

  def button_down(id)
    @player.button_down(id)
  end
end