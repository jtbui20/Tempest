require 'gosu'
require './draw_engine/SceneManager'

class GameWindow < Gosu::Window
  def initialize
    require 'inifile'
    config = IniFile.load('config.ini')

    super(config['Global']['width'], config['Global']['height'], false)
    self.caption = config['Global']['name']

    init_scenes
  end

  def init_scenes
    require './scenes/main_menu'

    @sm = SceneManager.new(width, height).tap do |sm|
      sm.add_scene(MAIN_MENU.new(sm))
      sm.load('Main Menu')
    end
  end

  def update
    @sm.update(mouse_x, mouse_y)
  end

  def draw
    @sm.draw
  end

  def button_down(id)
    @sm.button_down(id, mouse_x, mouse_y)
  end

  def needs_cursor?
    @sm.need_cursor?
  end
end

GameWindow.new.show if __FILE__ == $0