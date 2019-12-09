require "dxopal"
include DXOpal

GROUND_Y = 400
KANA_CODEPOINT_BASE = "ぁ".ord
Image.register(:akazukin, "images/akazukin.png")
Image.register(:font, "font/misaki_gothic_x2.png")

class Game
  def initialize(font)
    @font = font
  end

  def draw_text(x, y, text)
    text.each_char.with_index do |char, i|
      if char == " "
        index = -1
      else
        index = char.ord - KANA_CODEPOINT_BASE
      end
      Window.draw(x + i * 8 * 2, y, @font[index])
    end
  end
end

Window.load_resources do
  font = Image[:font].slice_tiles(94, 5).slice(94 * 3, 94)
  game = Game.new(font)
  Window.loop do
    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    Window.draw(0, GROUND_Y - Image[:akazukin].height, Image[:akazukin])
    #Window.draw(0, 0, Image[:font])
    game.draw_text(Image[:akazukin].width,
                   GROUND_Y - Image[:akazukin].height,
                   "こんにちは わたし あかずきん")
  end
end
