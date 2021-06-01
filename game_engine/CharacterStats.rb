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

    @class_type = ClassType::key(class_type)
    puts @class_type
  end

  def get_current_buff; return @p_buff; end

  def trigger_buff(buff)
    if buff.align == 0
      unless @n_buff.nil?
        remove_buff(@n_buff)
      end
      @n_buff = buff
      @n_buff.on(@gmods)
    elsif buff.align == 1
      unless @p_buff.nil?
        remove_buff(@p_buff)
      end
      @p_buff = buff
      @p_buff.on(@gmods)
    end
  end

  def remove_buff(buff)
    if @n_buff == buff
      @n_buff.off
      @n_buff = nil
    elsif @p_buff == buff
      @p_buff.off
      @p_buff = nil
    end
  end

  # Fix
  def remove_all_buffs
    unless @n_buff.nil?
      @n_buff.off
      @n_buff = nil
    end
    unless @p_buff.nil?
      @p_buff.off
      @p_buff = nil
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