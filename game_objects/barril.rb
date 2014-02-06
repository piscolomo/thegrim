class Barril < Chingu::GameObject
  traits :collision_detection, :bounding_box
  attr_accessor :move
  def setup
    @image = Image["barril.png"]
    @move = true
    self.width = 80
    self.height = 72
    self.zorder = 600
  end

  def update
    @x -= 1 if @move
  end
end
