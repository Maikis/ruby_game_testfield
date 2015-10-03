require 'gosu'

class Sprite
  def initialize window
    @window = window
    @width = 32
    @height = 48
    @right_image = Gosu::Image.load_tiles @window, "right.png", @width, @height, true
    @up_image = Gosu::Image.load_tiles @window, "top.png", @width, @height, true
    @down_image = Gosu::Image.load_tiles @window, "bottom.png", @width, @height, true
    @x = @window.width/2 - @width/2
    @y = @window.height/2 - @width/2
    @direction = :right
    @frame = 0
    @rate = 0
    @moving = false
  end

  def update
    @rate += 1
    @moving = false
    if @rate % 10 == 0
      @frame += 1
    end

    if @window.button_down? Gosu::KbLeft
      @x += -3
      @moving = true
      @direction = :left
    end
    if @window.button_down? Gosu::KbRight
      @x += 3
      @moving = true
      @direction = :right
    end
    if @window.button_down? Gosu::KbUp
      @y -= 3
      @moving = true
      @direction = :top
    end
    if @window.button_down? Gosu::KbDown
      @y += 3
      @moving = true
      @direction = :down
    end
  end

  def draw
    f = @frame % @right_image.size
    if @direction == :left || @direction == :right
      img = @moving ? @right_image[f] : @down_image[0]
    elsif @direction == :top
      img = @moving ? @up_image[f] : @down_image[0]
    elsif @direction == :down
      img = @moving ? @down_image[f] : @down_image[0]
    end

    if  @direction == :left
      img.draw @x + img.width, @y, 1, -1
    else
      img.draw @x, @y, 1
    end
  end
end

class SpriteGame < Gosu::Window
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Sprite Demo"
    @sprite = Sprite.new(self)
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    @sprite.update
  end

  def draw
    @sprite.draw
  end
end

SpriteGame.new.show