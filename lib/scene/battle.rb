module Scene
  class Battle < Base
    def initialize(game)
      super(game)
      @comments = []
      @command_cursor = 0
      @gameover = false
    end

    def update
    end

    def draw
      draw_status_window_frame
      draw_boss
      draw_talk_window_frame
      if @comments.empty?
        draw_command_window_frame
        draw_command_cursor
      else
        draw_comment
      end
    end

    def button_down(id)
      case id
      when Gosu::KB_SPACE
        if @gameover
          @game.set_scene(:gameover)
        end
        if @comments.empty?
          case @command_cursor
          when 0
            damage = 5
            @game.boss.damage(damage)
            @comments << [
              "#{@game.player.name} のこうげき",
              "#{@game.boss.name} にあたった",
              "",
            ]
            @comments << [
              "#{@game.boss.name} のはんげき",
              "#{@game.player.name} にあたった",
              "",
              0,
              10,
            ]
          when 1
          end
        else
          @comments.shift
          if @comments[0]
            @game.boss.damage(@comments[0][3]) if @comments[0][3]
            @game.player.damage(@comments[0][4]) if @comments[0][4]
          end
        end
        check_gameover
      when Gosu::KB_UP
        @command_cursor -= 1
        @command_cursor = 0 if @command_cursor < 0
      when Gosu::KB_DOWN
        @command_cursor += 1
        @command_cursor = 1 if @command_cursor > 1
      end
    end

    def check_gameover
      if @game.player.hp == 0
        @comments << [
          "#{@game.player.name} はまけてしまった",
          "",
          "",
        ]
        @gameover = true
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

    def draw_comment
      3.times do |i|
        draw_kana(CHAR_WIDTH * 2,
                  TALK_WINDOW_Y + CHAR_WIDTH * 2 * (i + 1),
                  @comments[0][i])
      end
    end
  end
end
