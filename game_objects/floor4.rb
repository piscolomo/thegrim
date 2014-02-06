class Floor4 < Floor
  def setup
    super
     @image = Image["suelo4.png"]
     self.width = 600
     self.height = 50
     self.zorder = 500
  end
end
