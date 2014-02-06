class Puas < Chingu::GameObject
  traits :collision_detection, :bounding_box
  def setup
    @image = Image["puas.png"]
    self.width = 100
    self.height = 60   
    self.zorder = 1600
  end

  def update
    @x -= 1
  end
end
