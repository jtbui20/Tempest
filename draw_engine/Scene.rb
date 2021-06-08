# * Scene manages all elements and events on the screen. Majority of the functions are indirectly inherited through SceneManager
# * due to the nature of encapsulation. 
# * Furthermore, issues regarding passing ByVal still remain. This has posed a large issue regarding memory management & manipulation.
# * The use of OOP Structure was employed to attempt to remedy this problem
# * The use of OOP Structure was employed for the same reasons as SceneManager.rb

# * Derived from Unity
# ? https://docs.unity3d.com/Manual/ExecutionOrder.html 

require './draw_engine/Layers'
require './game_engine/Object'
class Scene
  attr_reader :name, :draw_func, :elements, :master, :is_clickable, :mouse_pos

  def initialize(name, master)
    @name = name
    @draw_func = method(:draw)
    @master = master
    @elements = []
    @mouse_pos = nil

    @is_clickable = true
    @full_init = false
  end

  def set_mouse(x,y)
    @mouse_pos = Point.new(x,y)
  end

  def set_frame_time(fps)
    @delta_time = (fps == 0) ? 0 : 1.0 / fps
  end

  def draw()
    self.get_elements.each &:draw
  end

  def update()
    collidables = @elements.filter{ |c| defined?(c.collider)}
    collidables.each { |i| i.collider.collider_update(collidables - [i])}
    handle_mouse_UI(:hover)
    @elements.each &:update
  end

  def handle_mouse_UI(action)
    self.get_elements.filter { |i| i.layer == Layers::UI}.reverse.each do |element|
      if element.hover
        if element.position <= @mouse_pos && @mouse_pos <= (element.position + element.dimensions)
          if action == :click
            element.click.call(element)
          elsif action == :hover
            element.on_hover_enter
          end
        else
          element.on_hover_exit if action == :hover
        end
      end
    end
  end

  def button_down(id) 
    if id == Gosu::MS_LEFT
      handle_mouse_UI(:click)
    end
  end

  def add_element(*arg)
    @elements += arg
    return self
  end

  def remove_element(*arg)
    @elements -= arg
    return self
  end

  def get_elements()
    out = []
    @elements.each do |element|
      if element.is_a?(Group)
        out += element.elements
      else
        out << element
      end
    end
    return out
  end

  def find_in_scene(name)
    return @elements.filter {|item| item.name == name}
  end
end
