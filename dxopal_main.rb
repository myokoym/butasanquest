# frozen_string_literal: true

require 'dxopal'
include DXOpal

class GameWindow
  def self.draw(x, y, image)
    Window.draw x, y, image
  end

  def initialize
    super
  end

  def window_width
    Window.width
  end

  def window_height
    Window.height
  end
end

require_relative './lib/files'
Files::LIST.each do |path|
  require_relative "./lib/#{path}"
end

Image.register(:akazukin, 'images/akazukin.png')
Image.register(:butasan, 'images/butasan.png')
Image.register(:font, 'font/misaki_gothic_invert_x2.png')

class Game
  def window_button_down
    keys = %i(k_space k_enter k_escape k_up k_down k_left k_right).freeze
    
    keys.select do |key|
      id = key if key_push? key
    end

    if mouse_push?(:m_lbutton)
      id = case
           when mouse_y < @game.window_height / 3
             :k_up
           when mouse_y > @game.window_height / 3 * 2
             :k_down
           else
             :k_space
           end
    end
    game_button_down(id)
  end

  # TODO: not implemented yet in window_button_down()
  #def key_down?(key)
  #  Input.key_down? symbol_to_constant(key)
  #end

  def key_push?(key)
    Input.key_push? symbol_to_constant(key)
  end

  # TODO: not implemented yet in window_button_down()
  #def mouse_down?(key)
  #  Input.mouse_down? symbol_to_constant(key)
  #end

  def mouse_push?(key)
    Input.mouse_push? symbol_to_constant(key)
  end

  def symbol_to_constant(symbol)
    case symbol
    when :k_space
      K_SPACE
    when :k_escape
      K_ESCAPE
    when :k_enter
      K_ENTER
    when :k_left
      K_LEFT
    when :k_right
      K_RIGHT
    when :k_up
      K_UP
    when :k_down
      K_DOWN
    when :m_lbutton
      M_LBUTTON
    when :m_rbutton
      M_RBUTTON
    end
  end

  def mouse_x
    Input.mouse_x
  end

  def mouse_y
    Input.mouse_y
  end
end

Window.load_resources do
  Window.bgcolor = [0, 0 , 0]
  game = Game.new({
    akazukin: Image[:akazukin],
    butasan: Image[:butasan],
    font: Image[:font].slice_tiles(94, 8),
  })
  Window.loop do
    game.update
    game.draw
    game.window_button_down
  end
end
