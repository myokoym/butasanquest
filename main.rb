require "dxopal"
include DXOpal

require_remote "game.rb"

GROUND_Y = 400
KANA_CODEPOINT_BASE = "ぁ".ord
Image.register(:akazukin, "images/akazukin.png")
Image.register(:font, "font/misaki_gothic_x2.png")

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
