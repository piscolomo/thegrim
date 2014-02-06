class Finalya < Chingu::GameObject
  traits :collision_detection, :bounding_box
  def setup
    @image = Image["nada.png"]
  end

  def update
    @x -= 1
  end
end
