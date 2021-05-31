require './game_engine/Buffs'

class CharacterStats
  # Inputs
  # Boon / Bane stats - [key, value]
  # Boon / Bane elements
  # Class
  attr_reader :gmods
  def initialize (class_type, mod_stat, mod_element)
    default_stats()
    default_element()

    @gmods = ModifierDict.new()
    @gbuffs = []

    @class_type = ClassType::key(class_type)
    puts @class_type
  end

  def get_current_buff; return @buff; end

  def trigger_buff(buff)
    unless @gbuff.include?(buff); @gbuff << buff
    @buff.on(@gmods)
  end

  # Fix
  def remove_all_buffs
    unless @buff.nil?
      @buff.off
      @buff = nil
    end
  end

  attr_accessor :hp, :hp_min, :hp_max, :mp, :mp_min, :mp_max

  def default_stats
    # Move to config files
    @hp = 1000
    @hp_min = 0
    @hp_max = 1000
    @mp = 200
    @mp_min = 0
    @mp_max = 100
    @atk = 100
    @def = 1
    @haste = 1
    @agi = 1
  end

  def default_element
    @ELE_ATK_FLAME = 1
    @ELE_ATK_WATER = 1
    @ELE_ATK_WIND = 1
    @ELE_ATK_EARTH = 1
    @ELE_ATK_LIGHT = 1
    @ELE_ATK_SHADOW = 1

    @ELE_RES_FLAME = 1
    @ELE_RES_WATER = 1
    @ELE_RES_WIND = 1
    @ELE_RES_EARTH = 1
    @ELE_RES_LIGHT = 1
    @ELE_RES_SHADOW = 1
  end

  # Observer Access
  def get_hp; return -> { @hp }; end
  def get_hp_min; return -> { @hp_min }; end
  def get_hp_max; return -> { @hp_max }; end
  def get_mp; return -> { @mp }; end
  def get_mp_min; return -> { @mp_min }; end
  def get_mp_max; return -> { @mp_max }; end
  
  def get_atk; return -> { @atk }; end
  def get_def; return -> { @def }; end
  def get_haste; return -> { @haste }; end
  def get_agi; return -> { @agi }; end

end