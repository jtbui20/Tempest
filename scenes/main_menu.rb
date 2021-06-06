require 'gosu'
require './draw_engine/Point'
require './draw_engine/Interactibles'
require './draw_engine/Scene'

class MAIN_MENU < Scene
  def initialize master
    super('Main Menu', master)
    @menu = Group.new("Select Menu", self,
             Button.new("vs_com_button", self, Point.new(10, 10), Point.new(500, 100), 'VS COM', method(:show_vs_com_difficulty)),
             Button.new("vs_player_button", self, Point.new(10, 120), Point.new(500, 100), 'VS PLAYER', method(:recall)),
             Button.new("tutorial_button", self, Point.new(10, 230), Point.new(500, 100), 'TUTORIAL', method(:show_tut_arena)),
             Button.new("mm_setting_button", self, Point.new(10, 340), Point.new(500, 100), 'SETTINGS', method(:recall)),
             Button.new("credits_button", self, Point.new(10, 450), Point.new(500, 100), 'CREDITS', method(:recall)))

    @diff_ui = Group.new("Select Difficulty Interface", self,
      Button.new("BG", self, Point.new(0, 0), Point.new(1280, 720), '', method(:close)),
      Button.new("BEG", self, Point.new(600, 10), Point.new(500, 100), 'BEGINNER', method(:show_chara_select)),
      Button.new("INT", self, Point.new(600, 120), Point.new(500, 100), 'INTERMEDIATE', method(:show_chara_select)),
      Button.new("MAST", self, Point.new(600, 230), Point.new(500, 100), 'MASTER', method(:show_chara_select)),
      Button.new("NIGHT", self, Point.new(600, 340), Point.new(500, 100), 'NIGHTMARE', method(:show_chara_select)),
      Button.new("OMEGA", self, Point.new(600, 450), Point.new(500, 100), 'OMEGA', method(:show_chara_select))
    )

    @diff_ui.elements[0].color_bg = 0x99454545

    self.add_element(@menu)
  end

  def recall(id)
    puts id.text
  end

  def show_vs_com_difficulty(_)
    self.add_element(@diff_ui)
  end  

  def show_tut_arena(_id)
    @master.unload_top
    require './scenes/tutorial'
    @master.add_scene(TUT_ARENA.new(@master))
    @master.load('Tutorial')
  end

  def show_chara_select(id)
    @master.unload_top
    require './scenes/chara_select'
    close(id)
    @master.add_scene(CHARA_SELECT.new(@master, ai: id))
    @master.load("CHARA_SELECT")
  end

  def close (id)
    self.remove_element(@diff_ui)
  end
end