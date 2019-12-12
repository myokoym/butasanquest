module Scene
  class Title < Base
    def initialize(game)
      super(game)
    end

    def draw
      draw_alphabet(@game.width / 3,
                    @game.height / 3,
                    "Butasan Quest")
      draw_alphabet(@game.width / 3 + CHAR_WIDTH,
                    @game.height / 3 * 2,
                    "press space")
    end

    def button_down(id)
      if id == Gosu::KB_SPACE
        @game.init_game
        @game.set_scene(:talk)
      end
    end
  end
end
