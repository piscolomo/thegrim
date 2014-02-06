class DarkBall < Chingu::GameObject
  traits :collision_detection, :velocity, :bounding_circle
  def setup
    @image = Image["fire_bullet.png"]
    self.zorder = 1600
  end

  def update
    @x += 7
  end
end
