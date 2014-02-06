class Cementerio < Chingu::GameObject
  traits :collision_detection, :bounding_box 
  def setup
    super
    @image = Image["cementerio.png"]
    self.width = 450
    self.height = 50
    self.zorder = 1500
  end
  def update
    @x -= 1
  end
end
