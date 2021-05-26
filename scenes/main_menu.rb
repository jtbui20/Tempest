require 'gosu'
require './draw_engine/Point'
require './draw_engine/Interactibles'
require './draw_engine/Scene'

class MAIN_MENU < Scene
  def initialize master
    super('Main Menu', master)
    @elements.push(Button.new(10, 10, 500, 100, 'VS COM', method(:show_vs_com_difficulty)))
             .push(Button.new(10, 120, 500, 100, 'VS PLAYER', method(:recall)))
             .push(Button.new(10, 230, 500, 100, 'TUTORIAL', method(:show_tut_arena)))
             .push(Button.new(10, 340, 500, 100, 'SETTINGS', method(:recall)))
             .push(Button.new(10, 450, 500, 100, 'CREDITS', method(:recall)))
  end

  def recall(id)
    puts id.text
  end

  def show_vs_com_difficulty(_id)
    @master.add_scene(VS_COM_DIFF.new(@master))
    @master.load('VS_COM_DIFF')
  end  

  def show_tut_arena(_id)
    @master.unload_top
    @master.add_scene(TUT_ARENA.new(@master))
    @master.load('Tutorial')
  end
end