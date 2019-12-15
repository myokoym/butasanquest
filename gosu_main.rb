#!/usr/bin/env ruby

require "gosu"

class GameWindow < Gosu::Window
  class << self
    def draw(x, y, image)
      image.draw(x, y, ZOrder::UI)
    end
  end

  def initialize(images)
    super(640, 480)
    self.caption = "Butasan Quest"
  end

  def button_down(id)
    game_button_down(gosu_id_to_symbol(id))
  end

  def gosu_id_to_symbol(id)
    case id
    when Gosu::KB_SPACE
      :k_space
    when Gosu::KB_ESCAPE
      :k_escape
    when Gosu::KB_ENTER
      :k_enter
    when Gosu::KB_LEFT
      :k_left
    when Gosu::KB_RIGHT
      :k_right
    when Gosu::KB_UP
      :k_up
    when Gosu::KB_DOWN
      :k_down
    when Gosu::MS_LEFT
      :m_lbutton
    when Gosu::MS_RIGHT
      :m_rbutton
    end
  end

  def window_width
    self.width
  end

  def window_height
    self.height
  end

  def mouse_x
    self.mouse_x
  end

  def mouse_y
    self.mouse_y
  end
end

require "./lib/files"
Files::LIST.each do |path|
  require "./lib/#{path}"
end

Game.new({
  font: Gosu::Image.load_tiles("font/misaki_gothic_invert_x2.png", 16, 16),
  butasan: Gosu::Image.new("images/butasan.png"),
  akazukin: Gosu::Image.new("images/akazukin.png"),
}).show
