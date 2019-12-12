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

    event_pages = [
      EventPage.new(@boss, ["こんにちは　わたし　あかずきん", "", ""]),
      EventPage.new(@boss, ["こんやの　おかずは　あなたよ", "", ""]),
    ]
    @current_event = Event.new(event_pages)
    @scene_talk = Scene::Talk.new(self, @current_event)
  end

  def update
  end

  def draw
    @scene_talk.draw
  end

  def button_down(id)
    if id == Gosu::KB_SPACE
      @current_event.next
    end
  end

  private

  def input_key?(key)
    case key
    when KB_SPACE
      if Gosu.button_down? Gosu::KB_SPACE
        true
      end
    end
  end
end
