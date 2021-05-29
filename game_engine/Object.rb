require 'gosu'

class GameObject
  attr_accessor :name, :scene

  def initialize name, scene
    @name = name
    @master = scene
  end

  def draw; end

  def update; end
  
  def Destroy;
    @master.elements.remove_element(self)
  end
end