module Scene
  class Gameover < Base
    def initialize(game)
      super(game)
    end

    def draw
      draw_alphabet(@game.width / 3 + CHAR_WIDTH * 2,
                    @game.height / 2 - CHAR_WIDTH,
                    "game over")
    end

    def button_down(id)
      if id == Gosu::KB_SPACE
        @game.set_scene(:title)
      end
    end
  end
end
