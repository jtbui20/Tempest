require 'gosu'

class GameObject
  attr_accessor :name, :scene, :position, :layer

  def initialize name, scene, position, layer
    @name = name
    @master = scene
    @position = position
    @layer = layer
  end

  def draw; end

  def update; end
  
  def Destroy;
    @master.elements.remove_element(self)
  end
end