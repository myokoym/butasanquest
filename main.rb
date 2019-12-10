require "dxopal"
include DXOpal

require_remote "game.rb"

GROUND_Y = 400
KANA_CODEPOINT_BASE = "ぁ".ord
Image.register(:akazukin, "images/akazukin.png")
Image.register(:font, "font/misaki_gothic_invert_x2.png")

Window.load_resources do
  Window.bgcolor = [0, 0, 0]
  game = Game.new
  Window.loop do
    game.draw_frame
    #Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    Window.draw(Window.width / 2 - Image[:akazukin].width / 2,
                Window.height / 2 - Image[:akazukin].height / 2,
                Image[:akazukin])
    ##Window.draw(0, 0, Image[:font])
    game.draw_kana(32,
                   GROUND_Y - 32,
                   "こんにちは わたし あかずきん")
    game.draw_kana(32,
                   GROUND_Y,
                   "こんにちは わたし あかずきん")
    game.draw_kana(32,
                   GROUND_Y + 32,
                   "こんにちは わたし あかずきん")
    #game.draw_num(Image[:akazukin].width,
    #              GROUND_Y - Image[:akazukin].height - 16,
    #              46490,
    #              9)
    game.draw_next_sign
  end
end
