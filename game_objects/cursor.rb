class Cursor < Chingu::GameObject
  traits :timer,:collision_detection, :bounding_box
  def setup
    @image = Image["cursor.png"]
    self.width = 32
    self.height = 32
    self.zorder = 2005
    cache_bounding_box
  end
end
