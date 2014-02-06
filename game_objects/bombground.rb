class Bombground < Chingu::GameObject
  traits :collision_detection, :bounding_box
  def setup
   @animations = Chingu::Animation.new(:file => "bombground.png", :size => [46,15])
   @image = @animations.next
   self.width = 46
   self.height = 15
   self.zorder= 1700
  #Pablo, Designer of Levels suggets that bombground is not spicified here...
  #but JUlio Fucking Boss, put it :D
  end

  def update
    @image = @animations.next
    @x -= 1
  end
end
