module Scene
  class Title < Base
    def initialize(game)
      super(game)
    end

    def draw
      draw_alphabet(Window.width / 3,
                    Window.height / 3,
                    "Butasan Quest")
      draw_alphabet(Window.width / 3 + CHAR_WIDTH,
                    Window.height / 3 * 2,
                    "press space")
    end

    def button_down(id)
      case id
      when :k_space
        @game.init_game
        @game.set_scene(:talk)
      end
    end
  end
end
