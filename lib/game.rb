require_remote "./lib/character/character.rb"
require_remote "./lib/scene/scene.rb"
require_remote "./lib/event/event.rb"

class Game
  attr_reader :player, :boss
  def initialize
    init_game
  end

  def update
    @current_scene.update
  end

  def draw
    @current_scene.draw
  end

  def button_down
    if Input.key_push?(K_SPACE) ||
       Input.key_push?(K_ENTER)
      id = :k_space
    elsif Input.key_push?(K_UP)
      id = :k_up
    elsif Input.key_push?(K_DOWN)
      id = :k_down
    end
    if Input.mouse_push?(M_LBUTTON)
      if Input.mouse_y < Window.height / 3
        id = :k_up
      elsif Input.mouse_y > Window.height / 3 * 2
        id = :k_down
      else
        id = :k_space
      end
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
    @player = Character.new("ぶたさん", 20, Image[:butasan])
    @boss = Character.new("あかずきん", 10, Image[:akazukin])
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
    @scenes[:gameclear] = Scene::Gameclear.new(self)

    @current_scene = @scenes[:title]
  end
end
