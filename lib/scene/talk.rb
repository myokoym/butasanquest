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
        has_next = @event.next
        unless has_next
          @game.set_scene(:battle)
        end
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

    def draw_next_sign
      window_draw(@game.width - 32, @game.height - 32, @font_triangle[3])
    end
  end
end
