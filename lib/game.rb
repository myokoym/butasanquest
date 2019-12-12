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

    init_game
  end

  def update
    @current_scene.update
  end

  def draw
    @current_scene.draw
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close # TODO: debug
    end
    @current_scene.button_down(id)
  end

  def set_scene(new_scene)
    @current_scene = @scenes[new_scene]
  end

  def init_game
    init_status
    init_scenes
  end

  def init_status
    @player = Character.new("ぶたさん", 20, IMAGES[:butasan])
    @boss = Character.new("あかずきん", 10, IMAGES[:akazukin])
  end

  def init_scenes
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
    @scenes[:gameover] = Scene::Gameover.new(self)

    @current_scene = @scenes[:title]
  end
end
