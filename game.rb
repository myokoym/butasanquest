require "./player"
require "./boss"

module ZOrder
  BACKGROUND, FRAME, PLAYER, UI = *0..3
end

class Game < Gosu::Window
  KANA_CODEPOINT_BASE = "ぁ".ord
  IMAGES = {
    akazukin: Gosu::Image.new("images/akazukin.png"),
    font: Gosu::Image.load_tiles("font/misaki_gothic_invert_x2.png", 16, 16),
  }
  CHAR_WIDTH = 16
  TALK_WINDOW_Y = 480 - CHAR_WIDTH * 9

  def initialize
    super(640, 480)
    self.caption = "Butasan Quest"
    @player = Player.new("ぶたさん", 20)
    @boss = Boss.new("あかずきん", 10, IMAGES[:akazukin])
    font = IMAGES[:font]
    @font_num = font.slice(94 * 2 + 15, 10)
    @font_kana = font.slice(94 * 3, 94)
    @font_frame = font.slice(94 * 7, 33)
    @font_triangle = font.slice(94 * 1 + 3, 4)

    @current_event = [
      [@boss, ["こんにちは　わたし　あかずきん", "", ""]],
      [@boss, ["こんやの　おかずは　あなたよ", "", ""]],
    ]
    @current_event_index = 0
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
      @current_event_index += 1
    end
  end

  def draw_event
    window_draw(self.width / 2 - @boss.image.width / 2,
                self.height / 2 - @boss.image.height / 2,
                @boss.image)
    @current_event[@current_event_index][1].each_with_index do |comment, i|
    draw_kana(CHAR_WIDTH * 2,
              TALK_WINDOW_Y + CHAR_WIDTH * 2 * (i + 1),
              comment)
    end
  end

  def draw_num(x, y, num, digit=0)
    text = num.to_s
    padding_size = 0
    if text.size < digit
      padding_size = digit - text.size
      padding_size.times do |i|
        window_draw(x + i * 8 * 2, y, @font_kana[-1])
      end
    end
    text.each_char.with_index do |char, i|
      window_draw(x + (i + padding_size) * 8 * 2,
                  y,
                  @font_num[char.to_i])
    end
  end

  def draw_kana(x, y, text)
    text.each_char.with_index do |char, i|
      if /[ 　]/ =~ char
        index = -1
      else
        index = char.ord - KANA_CODEPOINT_BASE
      end
      window_draw(x + i * CHAR_WIDTH, y, @font_kana[index])
    end
  end

  def draw_talk_window_frame
    draw_window_frame(x: 0,
                      y: self.height - (16 * 9),
                      inner_width: self.width / 16 - 2,
                      inner_height: 7)
  end

  def draw_next_sign
    window_draw(self.width - 32, self.height - 32, @font_triangle[3])
  end

  def draw_status_window_frame
    draw_window_frame(x: 0,
                      y: 0,
                      inner_width: 7,
                      inner_height: 5)

    draw_kana(40, 0, @player.name)
    draw_kana(16, 32, "つよさ")
    draw_num(16 * 5, 32, @player.lv, 3)
    draw_kana(16, 64, "げんき")
    draw_num(16 * 5, 64, @player.hp, 3)
  end

  private

  def draw_window_frame(x:, y:, inner_width:, inner_height:)
    window_draw(x, y, @font_frame[2])
    draw_horizontal_line(x + CHAR_WIDTH,
                         y,
                         inner_width,
                         @font_frame[0])
    window_draw(x + CHAR_WIDTH * (inner_width + 1),
                y,
                @font_frame[3])

    inner_height.times do |y_index|
      window_draw(x,
                  y + CHAR_WIDTH * (y_index + 1),
                  @font_frame[1])
      draw_horizontal_line(x + CHAR_WIDTH,
                           y + CHAR_WIDTH * (y_index + 1),
                           inner_width,
                           @font_frame[-1])
      window_draw(x + CHAR_WIDTH * (inner_width + 1),
                  y + CHAR_WIDTH * (y_index + 1),
                  @font_frame[1])
    end

    window_draw(x,
                y + CHAR_WIDTH * (inner_height + 1),
                @font_frame[5])
    draw_horizontal_line(x + CHAR_WIDTH,
                         y + CHAR_WIDTH * (inner_height + 1),
                         inner_width,
                         @font_frame[0])
    window_draw(x + CHAR_WIDTH * (inner_width + 1),
                y + CHAR_WIDTH * (inner_height + 1),
                @font_frame[4])
  end

  def draw_horizontal_line(x, y, size, char)
    size.times do |i|
      window_draw(x + CHAR_WIDTH * i,
                  y,
                  char)
    end
  end

  def draw_vartical_line(x, y, size, char)
    size.times do |i|
      window_draw(x,
                  y + CHAR_WIDTH * i,
                  char)
    end
  end

  def input_key?(key)
    case key
    when KB_SPACE
      if Gosu.button_down? Gosu::KB_SPACE
        true
      end
    end
  end

  def window_draw(x, y, image)
    image.draw(x, y, ZOrder::UI)
  end
end
