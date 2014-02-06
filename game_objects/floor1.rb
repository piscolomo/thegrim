class Floor1 < Floor
  def setup
    super
    @image = Image["suelo1.png"]
    self.width = 300
    self.height = 50
    self.zorder = 1500
 end
end
