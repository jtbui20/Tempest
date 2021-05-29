require 'gosu'
require './draw_engine/Point'
require './draw_engine/Interactibles'
require './draw_engine/Scene'

class VS_COM_DIFF < Scene
  def initialize master
    super("VS_COM_DIFF", master)
    bg = Button.new("Button", self, Point.new(0, 0), Point.new(1280, 720), '', method(:close))
    bg.color_bg = 0x99454545
    @elements = []
                .push(bg)
                .push(Button.new("Button", self, Point.new(600, 10), Point.new(500, 100), 'BEGINNER', method(:com_diff_select)))
                .push(Button.new("Button", self, Point.new(600, 120), Point.new(500, 100), 'INTERMEDIATE', method(:com_diff_select)))
                .push(Button.new("Button", self, Point.new(600, 230), Point.new(500, 100), 'MASTER', method(:com_diff_select)))
                .push(Button.new("Button", self, Point.new(600, 340), Point.new(500, 100), 'NIGHTMARE', method(:com_diff_select)))
                .push(Button.new("Button", self, Point.new(600, 450), Point.new(500, 100), 'OMEGA', method(:com_diff_select)))
    @c = 0x99454545
  end
  
  def draw
    @elements.each &:draw
  end

  def com_diff_select(id)
    puts id.text
  end

  def close(id)
    master.unload_top
  end
end
