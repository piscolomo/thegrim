class Piedra < Chingu::GameObject
  def setup
    @image = Image["piedras.png"]
  end

  def update
    @x -= 1
  end
end
