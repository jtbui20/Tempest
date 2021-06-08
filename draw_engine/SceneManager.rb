# * SceneManager controls the operation of scenes and feeds input data from Gosu::Window to Scene.
# * An alternative to an entirely new class is to have Gosu::Window act as a SceneManger.
# * However, some elements access the SceneManager such as collision handling. This means that the
# * entire class is passed in as a parameter or is manipulated.
# * The use of OOP Structure was employed to achieve this functionality.

# ! Ported from ev3sim
# ? https://github.com/MelbourneHighSchoolRobotics/ev3sim/blob/main/ev3sim/visual/manager.py by Jackson Goerner & James Bui

class SceneManager
  attr_reader :scenes, :width, :height

  def initialize(width, height)
    @scenes = {}
    @scenes_stack = []
    @width = width
    @height = height
  end

  def add_scene(scene)
    @scenes[scene.name] = scene if @scenes[scene.name].nil?()
    # Returns self to allow chaining of functions
    return self
  end

  def load(scene_name)
    @scenes_stack.push(@scenes[scene_name])
  end

  def unload_top()
    @scenes_stack.pop()
  end

  def current_scene()
    return @scenes_stack[-1]
  end

  def draw()
    @scenes_stack.each(&:draw)
  end

  def update(mouse_x, mouse_y)
    current_scene.set_mouse(mouse_x, mouse_y)
    current_scene.set_frame_time(Gosu.fps)
    current_scene.update()
  end

  def button_down(id, x, y)
    current_scene.set_mouse(x,y)
    current_scene.button_down(id)
  end

  def need_cursor?()
    returncurrent_scene.is_clickable()
  end
end
