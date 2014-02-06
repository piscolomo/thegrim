class Water1 < Chingu::GameObject 
  def setup
    super
    @animations = Chingu::Animation.new(:file => "agua1.png", :size=>[877, 242])
    @image = @animations.next
    self.zorder = 500
    self.height = 85
  end
  def update
    @image = @animations.next
    @x -= 1
  end
end
