require 'gosu'
require './draw_engine/Point'
require './draw_engine/Interactibles'
require './draw_engine/Scene'
require './game_engine/CharacterAttributes'

class CHARA_SELECT < Scene
  def initialize master, **kwargs
    super('CHARA_SELECT', master)
    @elements.push(Button.new("Button", self, Point.new(10, 10), Point.new(500, 100), 'Augmenter', method(:show_select_attri)))
             .push(Button.new("Button", self, Point.new(10, 120), Point.new(500, 100), 'Mage', method(:show_select_attri)))
             .push(Button.new("Button", self, Point.new(10, 230), Point.new(500, 100), 'Summoner', method(:show_select_attri)))
             .push(Button.new("Button", self, Point.new(10, 340), Point.new(500, 100), 'Random', method(:show_select_attri)))
  end

  def show_select_attri(id)
    puts id.text()
  end

  def button_down(id)
    super(id)

    case(id)
    when Gosu::KB_ESCAPE
      return_to_menu()
    end
  end

  def return_to_menu()
    @master.unload_top()
    @master.load("Main Menu")
  end
end