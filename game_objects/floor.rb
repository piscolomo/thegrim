class Floor < Chingu::GameObject
  traits :collision_detection, :bounding_box
  def setup
    
  end

  def update
    @x -= 1
  end
end
