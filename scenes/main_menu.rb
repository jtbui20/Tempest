require 'gosu'
require './draw_engine/Point'
require './draw_engine/Interactibles'
require './draw_engine/Scene'

class MAIN_MENU < Scene
  def initialize master
    super('Main Menu', master)
    @menu = Group.new("Select Menu", self,
      Frame.new("BG", self, Point.new(0,0), Point.new(@master.width, @master.height), 0xff_f1f1f1),
      Image.new("Circle", self, Point.new(1050,132), "assets/Circle.png", Point.new(3,3)),
      Text.new("Title", self, Point.new(900, 200), 64, -> {"TEMPEST"}),
      Button.new("vs_com_button", self, Point.new(10, 60), Point.new(500, 100), 'VS COM', method(:show_vs_com_difficulty)),
      Button.new("vs_player_button", self, Point.new(10, 170), Point.new(500, 100), 'VS PLAYER', method(:recall)),
      Button.new("tutorial_button", self, Point.new(10, 280), Point.new(500, 100), 'TUTORIAL', method(:show_tut_arena)),
      Button.new("mm_setting_button", self, Point.new(10, 390), Point.new(500, 100), 'SETTINGS', method(:recall)),
      Button.new("credits_button", self, Point.new(10, 500), Point.new(500, 100), 'CREDITS', method(:recall))
    )

    @diff_ui = Group.new("Select Difficulty Interface", self,
      Frame.new("BG", self, Point.new(0,0), Point.new(@master.width, @master.height), 0x99454545, method(:close_diff)),
      Button.new("BEG", self, Point.new(600, 10), Point.new(500, 100), 'BEGINNER', method(:show_chara_select)),
      Button.new("INT", self, Point.new(600, 120), Point.new(500, 100), 'INTERMEDIATE', method(:show_chara_select)),
      Button.new("MAST", self, Point.new(600, 230), Point.new(500, 100), 'MASTER', method(:show_chara_select)),
      Button.new("NIGHT", self, Point.new(600, 340), Point.new(500, 100), 'NIGHTMARE', method(:show_chara_select)),
      Button.new("OMEGA", self, Point.new(600, 450), Point.new(500, 100), 'OMEGA', method(:show_chara_select))
    )

    self.add_element(@menu)

    require './scenes/loading_overlay.rb'
    @master.add_scene(LOADING_OVERLAY.new(@master))
  end

  def recall(id)
    puts(id.text)
  end

  def show_vs_com_difficulty(_)
    self.add_element(@diff_ui)
  end

  def show_tut_arena(_)

    # @master.load("Loading Overlay")
    # loading = true

    @master.unload_top()
    require './scenes/tutorial'
    @master.add_scene(TUT_ARENA.new(@master))
    @master.load('Tutorial')
  end

  def show_chara_select(id)
    @master.unload_top()
    require './scenes/chara_select'
    @master.add_scene(CHARA_SELECT.new(@master, ai: id))
    @master.load("CHARA_SELECT")
  end

  def close_diff (id)
    self.remove_element(@diff_ui)
  end
end