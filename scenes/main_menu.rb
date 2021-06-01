require 'gosu'
require './draw_engine/Point'
require './draw_engine/Interactibles'
require './draw_engine/Scene'

class MAIN_MENU < Scene
  def initialize master
    super('Main Menu', master)
    @elements.push(Button.new("Button", self, Point.new(10, 10), Point.new(500, 100), 'VS COM', method(:show_vs_com_difficulty)))
             .push(Button.new("Button", self, Point.new(10, 120), Point.new(500, 100), 'VS PLAYER', method(:recall)))
             .push(Button.new("Button", self, Point.new(10, 230), Point.new(500, 100), 'TUTORIAL', method(:show_tut_arena)))
             .push(Button.new("Button", self, Point.new(10, 340), Point.new(500, 100), 'SETTINGS', method(:recall)))
             .push(Button.new("Button", self, Point.new(10, 450), Point.new(500, 100), 'CREDITS', method(:recall)))
  end

  def recall(id)
    puts id.text
  end

  def show_vs_com_difficulty(_id)
    require './scenes/vs_com_difficulty'
    @master.add_scene(VS_COM_DIFF.new(@master))
    @master.load('VS_COM_DIFF')
  end  

  def show_tut_arena(_id)
    @master.unload_top
    require './scenes/tutorial'
    @master.add_scene(TUT_ARENA.new(@master))
    @master.load('Tutorial')
  end
end