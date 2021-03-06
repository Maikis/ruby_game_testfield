require 'gosu'

class Hello < Gosu::Window
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = 'Hello rbmales'
    @image = Gosu::Image.from_text self, "Hello rubyales", Gosu.default_font_name, 100
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    @x = self.width/2 - @image.width / 2 + Math.sin(Time.now.to_f) * 100
    @y = self.height/2 - @image.height / 2 + Math.cos(Time.now.to_f) * 200
  end

  def draw
    @image.draw @x, @y, 0
  end
end

Hello.new.show