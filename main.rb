require "dxopal"
include DXOpal

GROUND_Y = 400
KANA_CODEPOINT_BASE = "ぁ".ord
Image.register(:akazukin, "images/akazukin.png")
Image.register(:font, "font/misaki_gothic_x2.png")

class Game
  def initialize
    font = Image[:font].slice_tiles(94, 5)
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

Window.load_resources do
  game = Game.new
  Window.loop do
    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    Window.draw(0, GROUND_Y - Image[:akazukin].height, Image[:akazukin])
    #Window.draw(0, 0, Image[:font])
    game.draw_kana(Image[:akazukin].width,
                   GROUND_Y - Image[:akazukin].height,
                   "こんにちは わたし あかずきん")
    game.draw_num(Image[:akazukin].width,
                  GROUND_Y - Image[:akazukin].height - 16,
                  46490,
                  9)
  end
end
