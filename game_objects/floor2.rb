class Floor2 < Floor
  def setup
    super
    @image = Image["suelo2.png"]
    self.width = 400  
    self.height = 50
    self.zorder = 500
  end
end
