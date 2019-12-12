require "dxopal"
include DXOpal

require_remote "./lib/game.rb"

Image.register(:akazukin, "images/akazukin.png")
Image.register(:butasan, "images/butasan.png")
Image.register(:font, "font/misaki_gothic_invert_x2.png")

Window.load_resources do
  Window.bgcolor = [0, 0 , 0]
  game = Game.new
  Window.loop do
    game.update
    game.draw
    game.button_down
  end
end
