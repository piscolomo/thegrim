class Soldier < Chingu::GameObject
  traits :collision_detection, :bounding_box, :timer
  attr_accessor :died
  def setup
    @animations = Chingu::Animation.new(:file => "soldier.png", :size => [508,391])
    @image = @animations.first
    self.scale = 0.4
    self.zorder = 1700
    @died = false
  end
  def update
    @image = @animations.next if @died
    @x -= 1
  end
end
