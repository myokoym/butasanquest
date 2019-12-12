class Boss < Player
  attr_reader :image
  def initialize(name, lv, image)
    super(name, lv)
    @image = image
  end
end
