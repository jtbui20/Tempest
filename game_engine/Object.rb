# * GameObject defines the fundamental structure of an entity within the screen. This is supplemented through the use of Scene
# * Draws all GameObjects within the elements list. There are some objects that do not have a draw, but are required to undergo an update sequence
# * and can be added or removed from the screen. If one of the functions are not defined, the program breaks.
# * The use of OOP Principles: Encapsulation & Abstaction, serves as a remedy for the above issue.

require 'gosu'
class GameObject
  attr_accessor :name, :master, :position, :layer

  def initialize(name, scene, position, layer)
    @name = name
    @master = scene
    @position = position
    @layer = layer
  end

  def draw(); end

  def update(); end
  
  def Destroy();
    @master.elements.remove_element(self)
  end
end

# * Group defines a set of GameObjects with relevance to each other. This is employed to organise UI elements or entities within the screen.
class Group
  attr_accessor :name, :scene, :elements

  def initialize(name, scene, *elements)
    @name = name
    @master = scene
    @elements = elements
    @layer = 0
  end

  def add_elements(*args)
    @elements << args
  end

  def remove_elements(*args)
    @elements -= args
  end

  def update(); @elements.each(&:update); end
  def draw(); @elements.each(&:draw); end
end

require './game_engine/Timer'