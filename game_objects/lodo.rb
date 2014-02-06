class Lodo < Chingu::GameObject
  def setup
    @animations = Chingu::Animation.new(:file => "lodo.png", :size => [621,98])
    @image = @animations.next
    self.zorder = 500
  end

  def update
    @image = @animations.next
    @x -= 1
  end
end
