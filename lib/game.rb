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
    @current_scene.button_down
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

    @current_scene = @scenes[:title]
  end
end
