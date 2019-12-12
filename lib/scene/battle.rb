module Scene
  class Battle < Base
    def initialize(game)
      super(game)
      @command_cursor = 0
    end

    def update
    end

    def draw
      draw_status_window_frame
      draw_talk_window_frame
      draw_command_window_frame
      draw_command_cursor
    end

    def button_down(id)
      case id
      when Gosu::KB_SPACE
        case @command_cursor
        when 0
          @game.boss.damage(5)
          @game.player.damage(10)
        when 1
        end
      when Gosu::KB_UP
        @command_cursor -= 1
        @command_cursor = 0 if @command_cursor < 0
      when Gosu::KB_DOWN
        @command_cursor += 1
        @command_cursor = 1 if @command_cursor > 1
      end
    end

    def draw_command_window_frame
      draw_window_frame(x: 0,
                        y: @game.height - (16 * 9),
                        inner_width: 9,
                        inner_height: 7)

      draw_kana(CHAR_WIDTH * 3,
                @game.height - (16 * 9) + CHAR_WIDTH * 2,
                "たたかう")
      draw_kana(CHAR_WIDTH * 3,
                @game.height - (16 * 9) + CHAR_WIDTH * 4,
                "よける")
    end

    def draw_command_cursor
      window_draw(CHAR_WIDTH * 2,
                  @game.height - (16 * 9) + CHAR_WIDTH * (@command_cursor + 1) * 2,
                  @font_cursor[0])
    end
  end
end
