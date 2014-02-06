class Pasto < Chingu::GameObject
  traits :collision_detection, :bounding_box 
  def setup
    super
    @image = Image["pasto.png"]
    self.width = 414
    self.height = 59
    self.zorder = 1500
  end
  def update
    @x -= 1
  end
end
