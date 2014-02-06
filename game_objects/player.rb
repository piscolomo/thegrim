class Player < Chingu::GameObject
  traits :velocity, :collision_detection, :timer, :bounding_box
  attr_accessor :jumping
  def initialize(options)
    super
    @jumping = false
  end
  def setup
    @animationrun = Chingu::Animation.new(:file => "deathrun.png", :size => [192, 420])
    @animationjump = Chingu::Animation.new(:file => "deathjump.png", :size=>[185,410])
    self.input = {:space => :jump, :z => :fire}
    self.zorder = 1000
    self.height = 80
    self.acceleration_y = 1
    self.scale = 0.5
    @jumping = false
    @image = @animationrun.next
  end

  def update 
    @jumping ? @image = @animationjump.next : @image = @animationrun.next
  end

  def fire
    DarkBall.create(:x => self.x + 35, :y => self.y - 5)
  end

  def jump
   return if @jumping
    @jumping =true
    self.velocity_y = -10
    self.acceleration_y = 0.5
  end

end
