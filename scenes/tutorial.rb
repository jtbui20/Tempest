require 'gosu'
require './draw_engine/Point'
require './draw_engine/Grids'
require './game_engine/player'
require './game_engine/character'
require './game_engine/reticle'
require './draw_engine/Interactibles'
require './game_engine/Timer.rb'

class TUT_ARENA < Scene
  def initialize master
    super('Tutorial', master)
    
    @grid = TopDownGrid.new(Gosu::Image.new("assets/training_room_tiles-01.png"), 10, 10, @master.width, @master.height)

    @player = Player.new(self, Point.new(500,500))
    @filler = Character.new("PlayerB", self, Point.new(800, 200))

    self.add_element(@filler, @player)
    
    @timer = Timer.new(99000, nil, false)
    @is_clickable = false

    gen_ui()
    puts self.find_in_scene("Player")
  end

  def finalize_init
    self.add_element(Reticle.new(self))
    @full_init = !@full_init
  end

  def gen_ui
    self.add_element(
      ProgressBar.new("HP Bar PlayerA", self, Point.new(20, 20), Point.new(498, 38), 0, -> {0}, @player.character_stats.get_hp_max, @player.character_stats.get_hp, 0xff_00ff00, 0xff_ff0000),
      ProgressBar.new("HP Bar PlayerB", self, Point.new(748, 20), Point.new(498, 38), 1, -> {0}, @filler.character_stats.get_hp_max, @filler.character_stats.get_hp, 0xff_00ff00, 0xffff0000),
      Text.new("Timer", self, Point.new(600, 20), 64, -> {@timer.milliseconds_to_seconds(@timer.get_remaining)})
    )
  end

  def draw
    @grid.draw
    @elements.each { |i| i.draw}
  end

  def update
    finalize_init unless @full_init
    @timer.update
    if @player.character_stats.get_hp.call <= 0
      self.add_element(
        Text.new("Victory", self, Point.new(300, 100), 48, -> {"WINNER"}),
        Text.new("Loser", self, Point.new(900, 100), 48, -> {"LOSER"})
      )
    elsif @filler.character_stats.get_hp.call <= 0
      self.add_element(
        Text.new("Victory", self, Point.new(900, 100), 48, -> {"WINNER"}),
        Text.new("Loser", self, Point.new(300, 100), 48, -> {"LOSER"})
      )
    end
    super
  end

  def button_down(id)
    @player.button_down(id)
  end
end