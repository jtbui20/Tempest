require 'gosu'
require './draw_engine/Point'

class CharAnimController
  attr_reader :state, :duration, :anim, :vert_flip

  def initialize()
    require "./draw_engine/CharAnimData.rb"
    @anim = WizardAnimData::ID

    @duration = 50
    @state = :RunSide
    @vert_flip = 1
    @last_angle = 0
    @idle = 0
    # Dictionary of assets
    @observers = {}
  end

  def set_observer(key, value)
    @observers[key] = value
    self
  end

  def update() # state
    if @observers[:speed].call() == 0
      case @state
      when :RunSide
        @state = :IdleSide
      when :RunDown
        @state = :IdleDown
      when :RunUp
        @state = :IdleUp
      end
    else
      angle = @observers[:angle].call()
      if @observers[:speed].call() <= 5
        if -45 < angle && angle < 45
          @state = :RunSide
          @vert_flip = 1
        elsif 45 <= angle && angle <= 135
          @state = :RunDown
          @vert_flip = 1
        elsif 135 < angle || angle < -135 # Left
          @state = :RunSide
          @vert_flip = -1
        elsif -135 <= angle && angle <= -45
          @state = :RunUp
          @vert_flip = 1
        end
      else
        if -45 < angle && angle < 45
          @state = :DashSide
          @vert_flip = 1
        elsif 45 <= angle && angle <= 135
          @state = :SwingDown
          @vert_flip = 1
        elsif 135 < angle || angle < -135 # Left
          @state = :DashSide
          @vert_flip = -1
        elsif -135 <= angle && angle <= -45
          @state = :SwingUp
          @vert_flip = 1
        end
      end
    end
  end

  def getState()
    @anim[@state]
  end
end