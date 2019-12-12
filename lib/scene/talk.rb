module Scene
  class Talk < Base
    def initialize(game, event)
      super(game)
      @event = event
    end

    def update
    end

    def draw
      draw_status_window_frame
      draw_talk_window_frame
      draw_event
      draw_next_sign
    end

    def button_down(id)
      if id == Gosu::KB_SPACE
        @event.next
      end
    end

    private

    def draw_event
      window_draw(@game.width / 2 - @game.boss.image.width / 2,
                  @game.height / 2 - @game.boss.image.height / 2,
                  @game.boss.image)
      3.times do |i|
        draw_kana(CHAR_WIDTH * 2,
                  TALK_WINDOW_Y + CHAR_WIDTH * 2 * (i + 1),
                  @event.current_page.comments[i])
      end
    end

    def draw_talk_window_frame
      draw_window_frame(x: 0,
                        y: @game.height - (16 * 9),
                        inner_width: @game.width / 16 - 2,
                        inner_height: 7)
    end

    def draw_next_sign
      window_draw(@game.width - 32, @game.height - 32, @font_triangle[3])
    end

    def draw_status_window_frame
      draw_window_frame(x: 0,
                        y: 0,
                        inner_width: 7,
                        inner_height: 5)

      draw_kana(40, 0, @game.player.name)
      draw_kana(16, 32, "つよさ")
      draw_num(16 * 5, 32, @game.player.lv, 3)
      draw_kana(16, 64, "げんき")
      draw_num(16 * 5, 64, @game.player.hp, 3)
    end
  end
end
