require_relative "./z_order"
require_relative "./character/character"
require_relative "./scene/scene"
require_relative "./event/event"

class Game < Gosu::Window
  IMAGES = {
    font: Gosu::Image.load_tiles("font/misaki_gothic_invert_x2.png", 16, 16),
    butasan: Gosu::Image.new("images/butasan.png"),
    akazukin: Gosu::Image.new("images/akazukin.png"),
  }

  attr_reader :player, :boss
  def initialize
    super(640, 480)
    self.caption = "Butasan Quest"
    @player = Character.new("ぶたさん", 20, IMAGES[:butasan])
    @boss = Character.new("あかずきん", 10, IMAGES[:akazukin])

    @scenes = {}
    @scenes[:title] = Scene::Title.new(self)

    event_pages = [
      EventPage.new(@boss, ["こんにちは　わたし　あかずきん", "", ""]),
      EventPage.new(@boss, ["こんやの　おかずは　あなたよ", "", ""]),
      EventPage.new(@boss, ["#{@boss.name} があらわれた", "", ""]),
    ]
    @current_event = Event.new(event_pages)
    @scenes[:talk] = Scene::Talk.new(self, @current_event)

    @scenes[:battle] = Scene::Battle.new(self)

    @current_scene = @scenes[:title]
  end

  def update
    @current_scene.update
  end

  def draw
    @current_scene.draw
  end

  def button_down(id)
    @current_scene.button_down(id)
  end

  def set_scene(new_scene)
    @current_scene = @scenes[new_scene]
  end
end
