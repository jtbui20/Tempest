require 'gosu'
require './draw_engine/Point'

class CharAnimController
  attr_reader :state, :duration, :anim, :vert_flip

  def initialize ()
    require "./draw_engine/AnimData.rb"
    @anim = WizardAnimData::ID

    @duration = 50
    @state = :RunSide
    @vert_flip = 1
    @last_angle = 0
    @idle = 0
    # Dictionary of assets
  end

  def update(movement, direction) # state
    angle = direction.angle_between_vector(Point.new(1,0))
    unless movement == 0
      if -45 < angle && angle < 45
        @state = :RunSide
        @vert_flip = 1
      elsif 45 < angle && angle < 135
        @state = :RunDown
        @vert_flip = 1
      elsif 135 < angle || angle < -135 # Left
        @state = :RunSide
        @vert_flip = -1
      elsif -135 < angle && angle < -45
        @state = :RunUp
        @vert_flip = 1
      end
    else
      case @state
      when :RunSide
        @state = :IdleSide
      when :RunDown
        @state = :IdleDown
      when :RunUp
        @state = :IdleUp
      end
    end
  end

  def getState
    @anim[@state]
  end
end