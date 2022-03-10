class Character
  attr_reader :name, :image, :lv, :hp
  
  def initialize(name, lv, image)
    @name = name
    @image = image
    @hp = @lv = lv
  end

  def lv_up
    @lv += 1
    hp_max
  end

  def hp_max
    @hp = @lv
  end

  def damage(pow)
    @hp -= pow
    @hp = 0 if @hp.negative?
  end
end
