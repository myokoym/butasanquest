class Game
  def initialize
    font = Image[:font].slice_tiles(94, 8)
    @font_num = font.slice(94 * 2 + 15, 10)
    @font_kana = font.slice(94 * 3, 94)
    @font_frame = font.slice(94 * 7, 33)
    @font_triangle = font.slice(94 * 1 + 3, 4)
  end

  def draw_num(x, y, num, digit=nil)
    text = num.to_s
    padding_size = 0
    if text.size < digit
      padding_size = digit - text.size
      padding_size.times do |i|
        Window.draw(x + i * 8 * 2, y, @font_kana[-1])
      end
    end
    text.each_char.with_index do |char, i|
      Window.draw(x + (i + padding_size) * 8 * 2, y, @font_num[char.to_i])
    end
  end

  def draw_kana(x, y, text)
    text.each_char.with_index do |char, i|
      if char == " "
        index = -1
      else
        index = char.ord - KANA_CODEPOINT_BASE
      end
      Window.draw(x + i * 8 * 2, y, @font_kana[index])
    end
  end

  def draw_talk_window_frame
    x = 0
    y = Window.height - (16 * 9)

    Window.draw(x, y, @font_frame[2])
    x += 16
    (Window.width / 16 - 2).times do
      Window.draw(x, y, @font_frame[0])
      x += 16
    end
    Window.draw(x, y, @font_frame[3])

    7.times do
      x = 0
      y += 16
      Window.draw(x, y, @font_frame[1])
      x += 16
      (Window.width / 16 - 2).times do
        Window.draw(x, y, @font_frame[-1])
        x += 16
      end
      Window.draw(x, y, @font_frame[1])
    end

    x = 0
    y += 16
    Window.draw(x, y, @font_frame[5])
    x += 16
    (Window.width / 16 - 2).times do
      Window.draw(x, y, @font_frame[0])
      x += 16
    end
    Window.draw(x, y, @font_frame[4])
  end

  def draw_next_sign
    Window.draw(Window.width - 32, Window.height - 32, @font_triangle[3])
  end

  def draw_status_window_frame
    x = 0
    y = 0

    Window.draw(x, y, @font_frame[2])
    x += 16
    (Window.width / 16 / 6).times do
      Window.draw(x, y, @font_frame[0])
      x += 16
    end
    Window.draw(x, y, @font_frame[3])

    5.times do
      x = 0
      y += 16
      Window.draw(x, y, @font_frame[1])
      x += 16
      (Window.width / 16 / 6).times do
        Window.draw(x, y, @font_frame[-1])
        x += 16
      end
      Window.draw(x, y, @font_frame[1])
    end

    x = 0
    y += 16
    Window.draw(x, y, @font_frame[5])
    x += 16
    (Window.width / 16 / 6).times do
      Window.draw(x, y, @font_frame[0])
      x += 16
    end
    Window.draw(x, y, @font_frame[4])


    draw_kana(40, 0, "ぶたさん")
    draw_kana(16, 32, "つよさ")
    draw_num(16 * 5, 32, 30, 3)
    draw_kana(16, 64, "げんき")
    draw_num(16 * 5, 64, 5, 3)
  end
end
