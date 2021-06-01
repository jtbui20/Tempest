class SceneManager
  attr_reader :scenes, :width, :height

  def initialize(width, height)
    @scenes = {}
    @scenes_stack = []
    @width = width
    @height = height
    @previous_screen = nil
  end

  def add_scene(scene)
    @scenes[scene.name] = scene
    # Returns self to allow chaining of functions
    self
  end

  def load(scene_name)
    @scenes_stack.push(@scenes[scene_name])
  end

  def unload_top
    @scenes_stack.pop
  end

  def current_scene
    @scenes_stack[-1]
  end

  def draw
    @scenes_stack.each(&:draw)
  end

  def update(mouse_x, mouse_y)
    current_scene.set_mouse(mouse_x, mouse_y)
    current_scene.set_frame_time(Gosu.fps)
    current_scene.update
  end

  def button_down(id, x, y)
    current_scene.set_mouse(x,y)
    current_scene.button_down(id)
  end

  def need_cursor?
    current_scene.is_clickable
  end
end
