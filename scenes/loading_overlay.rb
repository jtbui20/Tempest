require 'gosu'
require './draw_engine/Point'
require './draw_engine/Interactibles'
require './draw_engine/Scene'
require './draw_engine/Layers'
require './game_engine/Timer'

class LOADING_OVERLAY < Scene
  def initialize master
    super('Loading Overlay', master)
    @img = Gosu::Image.load_tiles("assets/loading.png", 64, 64)
    @text = Gosu::Font.new(50)

    overlay = Button.new("BG", self, Point.new(0, 0), Point.new(1280, 720), '', method(:hello))
    overlay.color_bg = 0x99454545
    @timer = Timer.new(5000)

    self.add_element(overlay)
  end

  def update
    if @timer.complete?()
      puts ("hi")
    end
  end

  def draw
    @img[(Gosu.milliseconds / 100) % 12].draw(770, 640, Layers::UI)
    @text.draw_text("NOW LOADING", 850, 646, Layers::UI, 1, 1, 0xff_ffffff)
  end

  def hello(id); end

  def close()
    @master.unload_top()
    @master.unload_top()
  end
end