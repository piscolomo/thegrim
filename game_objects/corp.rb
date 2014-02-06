class Corp < Chingu::GameObject
  traits :collision_detection, :bounding_box, :timer
  def setup
    @animations = Chingu::Animation.new(:file => "corp.png", :size=>[94, 46])
    @image = @animations.next
    self.zorder = 600
    self.width = 94
    self.height = 46
  end

  def update
    @image = @animations.next
    @x -= 1
  end
  
  def up
    during(500) { @y -= 2}
  end
end
