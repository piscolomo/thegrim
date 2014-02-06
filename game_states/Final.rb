class Final < Chingu::GameState
  def setup
    @image = Image["final.png"]
    self.input = {:escape => :exit}
  end

  def draw
    @image.draw(0, 0, 0)
  end
end
