class Box < Chingu::GameObject
  traits :velocity, :collision_detection, :bounding_box, :timer
  attr_accessor :holdedbox
  def setup
    @image = Image["llanta.png"]
    self.width = 80
    self.height = 40
    self.zorder = 1600
  end

  def update
    @x -= 1
    @y += 4 unless @y>480
  end
end
