class Militar < Chingu::GameObject
  traits :velocity
  def setup
    @animations = Chingu::Animation.new(:file => "militar.png")
    @image = @animations.next
  end
  def update
     @image = @animations.next
  end
end
