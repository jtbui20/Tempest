# THERE IS TOO MUCH TO CONTAIN!!!!
# The custom code is spread over a large quantity of files and is manipulated through the require functionality.
# Source code can be viewed on github (upon completion of interview. The completion of the code will not be complete when this is submitted on 30th May.)
# This is submitted to allow access to its learning outcomes for 11.1T

require 'gosu'
require './draw_engine/SceneManager'

class GameWindow < Gosu::Window
  # * The entirety of this class is passed through to another object, responsible for managing the interactivity between each scene.
  # * All Window properties are sent through to the scene manager.
  def initialize()
    # * Use a config file instead of hardcoded settings.
    require 'inifile'
    config = IniFile.load('config.ini')

    super(config['Global']['width'], config['Global']['height'], false)
    self.caption = config['Global']['name']

    init_scenes()
  end

  def init_scenes()
    require './scenes/main_menu'
    @sm = SceneManager.new(width, height)
    @sm.add_scene(MAIN_MENU.new(@sm))
    @sm.load('Main Menu')
  end

  def update()
    @sm.update(mouse_x, mouse_y)
  end

  def draw()
    @sm.draw()
  end

  def button_down(id)
    @sm.button_down(id, mouse_x, mouse_y)
  end

  def needs_cursor?()
    @sm.need_cursor?()
  end
end

GameWindow.new.show() if __FILE__ == $0