class Sidebar < Chingu::GameObject
  def setup
    @image = Image["sidebar.png"]
    self.zorder= 2000
  end
end
