class Game
  def initialize
    font = Image[:font].slice_tiles(94, 8)
    @font_num = font.slice(94 * 2 + 15, 10)
    @font_kana = font.slice(94 * 3, 94)
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
end
