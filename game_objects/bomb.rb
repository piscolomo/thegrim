class Bomb < Chingu::GameObject
  traits :velocity, :collision_detection, :bounding_box
  attr_accessor :start_down, :particula
  def setup
    self.width = 32
    self.height = 32
    self.zorder = 1000
    @start_down = false
    @image = Image["bomb.png"]
    @animations = Chingu::Animation.new(:file => "fireball.png", :size => [32,32])
    cache_bounding_box
  end

  def update
    @y += 2 if @start_down
    @x -= 1
  end

  def explode
    @particula =  Chingu::Particle.create(:x => self.x, :y=> self.y, :animation=> @animations,:zorder =>1000, :scale_rate => +0.3,  :rotation_rate => +3, :mode => :default)
  end

  def explode_effect
    Particle.each {|particle| particle.y -=0.1; particle.x += 0.1}
  end

end
