class Player
  attr_reader :name
  attr_reader :lv
  attr_accessor :hp
  def initialize(name, lv)
    @name = name
    @lv = lv
    @hp = @lv
  end

  def lv_up
    @lv += 1
    hp_max
  end

  def hp_max
    @hp = @lv
  end
end
