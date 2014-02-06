require 'gosu'
require 'chingu'
include Gosu
include Chingu

class Barril < Chingu::GameObject
  traits :collision_detection, :bounding_box
  attr_accessor :move
  def setup
    @image = Image["barril.png"]
    @move = true
    self.width = 80
    self.height = 72
    self.zorder = 600
  end

  def update
    @x -= 1 if @move
  end
end

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

class Bombground < Chingu::GameObject
  traits :collision_detection, :bounding_box
  def setup
   @animations = Chingu::Animation.new(:file => "bombground.png", :size => [46,15])
   @image = @animations.next
   self.width = 46
   self.height = 15
   self.zorder= 1700
  #Pablo, Designer of Levels suggets that bombground is not spicified here...
  #but JUlio Fucking Boss, put it :D
  end

  def update
    @image = @animations.next
    @x -= 1
  end
end

class Box < Chingu::GameObject
  traits :velocity, :collision_detection, :bounding_box, :timer
  attr_accessor :holdedbox
  def setup
    @image = Image["llanta.png"]
    self.width = 80
    self.height = 40
    self.zorder = 1600
  end

  def update
    @x -= 1
    @y += 4 unless @y>480
  end
end

class Cementerio < Chingu::GameObject
  traits :collision_detection, :bounding_box 
  def setup
    super
    @image = Image["cementerio.png"]
    self.width = 450
    self.height = 50
    self.zorder = 1500
  end
  def update
    @x -= 1
  end
end

class Corp < Chingu::GameObject
  traits :collision_detection, :bounding_box, :timer
  def setup
    @animations = Chingu::Animation.new(:file => "corp.png", :size=>[94, 46])
    @image = @animations.next
    self.zorder = 600
    self.width = 94
    self.height = 46
  end

  def update
    @image = @animations.next
    @x -= 1
  end
  
  def up
    during(500) { @y -= 2}
  end
end

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

class DarkBall < Chingu::GameObject
  traits :collision_detection, :velocity, :bounding_circle
  def setup
    @image = Image["fire_bullet.png"]
    self.zorder = 1600
  end

  def update
    @x += 7
  end
end

class Finalya < Chingu::GameObject
  traits :collision_detection, :bounding_box
  def setup
    @image = Image["nada.png"]
  end

  def update
    @x -= 1
  end
end

class Floor < Chingu::GameObject
  traits :collision_detection, :bounding_box
  def setup
    
  end

  def update
    @x -= 1
  end
end

class Floor1 < Floor
  def setup
    super
    @image = Image["suelo1.png"]
    self.width = 300
    self.height = 50
    self.zorder = 1500
 end
end

class Floor2 < Floor
  def setup
    super
    @image = Image["suelo2.png"]
    self.width = 400  
    self.height = 50
    self.zorder = 500
  end
end

class Floor3 < Floor
  def setup
    @image = Image["suelo3.png"]
    self.width = 500
    self.height = 50
    self.zorder = 500
  end
end

class Floor4 < Floor
  def setup
    super
     @image = Image["suelo4.png"]
     self.width = 600
     self.height = 50
     self.zorder = 500
  end
end

class Lodo < Chingu::GameObject
  def setup
    @animations = Chingu::Animation.new(:file => "lodo.png", :size => [621,98])
    @image = @animations.next
    self.zorder = 500
  end

  def update
    @image = @animations.next
    @x -= 1
  end
end

class Militar < Chingu::GameObject
  traits :velocity
  def setup
    @animations = Chingu::Animation.new(:file => "militar.png")
    @image = @animations.next
  end
  def update
     @image = @animations.next
  end
end

class Pasto < Chingu::GameObject
  traits :collision_detection, :bounding_box 
  def setup
    super
    @image = Image["pasto.png"]
    self.width = 414
    self.height = 59
    self.zorder = 1500
  end
  def update
    @x -= 1
  end
end

class Piedra < Chingu::GameObject
  def setup
    @image = Image["piedras.png"]
  end

  def update
    @x -= 1
  end
end

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

class Puas < Chingu::GameObject
  traits :collision_detection, :bounding_box
  def setup
    @image = Image["puas.png"]
    self.width = 100
    self.height = 60   
    self.zorder = 1600
  end

  def update
    @x -= 1
  end
end

class Sidebar < Chingu::GameObject
  def setup
    @image = Image["sidebar.png"]
    self.zorder= 2000
  end
end

class Sidebar1 < Chingu::GameObject
  def setup
    @image = Image["sidebar1.png"]
    self.zorder = 2000
  end
end

class Sidebar2 < Chingu::GameObject
  def setup
    @image = Image["sidebar2.png"]
    self.zorder = 2000
  end
end

class Sidebar3 < Chingu::GameObject
  def setup
    @image = Image["sidebar3.png"]
    self.zorder = 2000
  end
end

class Soldier < Chingu::GameObject
  traits :collision_detection, :bounding_box, :timer
  attr_accessor :died
  def setup
    @animations = Chingu::Animation.new(:file => "soldier.png", :size => [508,391])
    @image = @animations.first
    self.scale = 0.4
    self.zorder = 1700
    @died = false
  end
  def update
    @image = @animations.next if @died
    @x -= 1
  end
end

class Water1 < Chingu::GameObject 
  def setup
    super
    @animations = Chingu::Animation.new(:file => "agua1.png", :size=>[877, 242])
    @image = @animations.next
    self.zorder = 500
    self.height = 85
  end
  def update
    @image = @animations.next
    @x -= 1
  end
end

class Water2 < Chingu::GameObject 
  def setup
    super
    @animations = Chingu::Animation.new(:file => "agua2.png", :size=>[877, 242])
    @image = @animations.next
    self.zorder = 800
    self.height = 85
  end
  def update
    @image = @animations.next
    @x -= 1
  end
end



class Aboutus < Chingu::GameState
  def setup
    Chingu::Text.create(:text => "Julio Lopez - Big Boss Developer - @TheBlasfem",:x => 120, :y => 200, :size=>30)
    Chingu::Text.create(:text => "Mateo - Amo y Senior del Arte",:x => 120, :y => 250, :size=>30)
  Chingu::Text.create(:text => "Pablo - Game Design",:x => 120, :y => 300, :size=>30)
   Chingu::Text.create(:text => "Rafael - Level Design, Design y Music",:x => 120, :y => 350, :size=>30)
    Chingu::Text.create(:text => "Renato - Aprendiz del Amo y Senior del Arte",:x => 120, :y => 400, :size=>30)
     Chingu::Text.create(:text => "Salvador Coronel - Master Code - @salvadeveloper",:x => 120, :y => 450, :size=>30)
      Chingu::Text.create(:text => "Vania - Reina Hogwarts",:x => 120, :y => 500, :size=>30)
       @militar = Militar.create(:x => 100, :y => 130)
 
   @renato = Image["lobo.png"]
   @rafael = Image["joker.png"]
   @vania = Image["foca.png"]
   @mateo = Image["mateo.png"]
   @julio = Image["destino.png"]
   @pablo = Image["delfin.png"]
   @salvador = Image["ojo.png"]

   self.input = {:escape => :exit, :return => Intro}
  end

  def draw
    super
    @renato.draw(65,390,0)
    @rafael.draw(65,340,0)
    @vania.draw(65,490,0)
    @mateo.draw(65,240,0)
    @julio.draw(65,190,0)
    @pablo.draw(65,290,0)
    @salvador.draw(65,440,0)
  end
end

class Final < Chingu::GameState
  def setup
    @image = Image["final.png"]
    self.input = {:escape => :exit}
  end

  def draw
    @image.draw(0, 0, 0)
  end
end

class Level < Chingu::GameState
  traits :timer, :viewport
  attr_accessor :mouse_x, :mouse_y
  def initialize
    super
    self.viewport.game_area = [0,0,10000,768]
    game_objects.destroy_all
    @death = Player.create(:x => 85, :y =>150)
    @sidebar = Sidebar.create(:x=>500, :y=>620)
    after(20000){@sidebar1 = Sidebar1.create(:x => 175, :y => 620)} 
    after(40000){@sidebar2 = Sidebar2.create(:x => 510, :y => 620)}
    after(53000){@sidebar3 = Sidebar3.create(:x => 832, :y => 620)}
    @moving = false
    self.input = {:left_mouse_button => :click, :released_left_mouse_button => :unclick,  :escape => :exit}
    @parallax = Chingu::Parallax.create(:x => 0, :y=>0, :rotation_center => :top_left)
    @parallax.add_layer(:image => "background1.png")
    after(40000){ @parallax.add_layer(:image => "background2.png")    }
    load_game_objects
    @mouse_x, @mouse_y = $window.mouse_x, $window.mouse_y
    @cursor = Cursor.create(:x => @mouse_x, :y => @mouse_y)   
  end
  # def edit
    #push_game_state(GameStates::Edit.new(:grid => [18,18], :classes =>  [Soldier,Finalya, Barril, Bomb, Bombground, Box, Cementerio, Corp, Floor1, Lodo, Pasto, Piedra, Puas, Water1, Water2]))
  #end
 
  def click
    @cursor.each_collision(Box) {|cursor,box|
       every(0, options = {:name => :holdedbox, :during => 1}){ box.x, box.y = cursor.x, cursor.y}
     }

     @cursor.each_collision(Barril) {|cursor,barril|
       every(0, options = {:name => :holdedbarril, :during => 1}){ barril.x, barril.y = cursor.x, cursor.y}
     }
 
    
    @cursor.each_collision(Bomb) {|cursor, bomb|
      bomb.explode
      during(500){bomb.explode_effect}.then{
        bomb.destroy
        bomb.particula.destroy}
    }
    
    @cursor.each_collision(Corp) { |cursor, corp| corp.up }
  end

  def unclick
    stop_timer(:holdedbox)  if timer_exists?(:holdedbox)    
    stop_timer(:holdedbarril)  if timer_exists?(:holdedbarril)    
  end
  
  def update
   super
    @parallax.camera_x += 1
    self.viewport.center_around(@death)
    self.viewport.x -= 1
    @cursor.x, @cursor.y = $window.mouse_x, $window.mouse_y
    
    DarkBall.each_collision(Soldier){ |darkball, soldier|
      soldier.died = true
            darkball.destroy
      after(2050){ soldier.destroy }
    }

    @death.each_collision(Finalya){ |death,finalya|
      game_objects.destroy_all
      push_game_state(Final)
    }

#  @death.each_collision(Soldier){|death, soldier| soldier.destroy; death.destroy; push_game_state(Lose)}

    @death.each_collision(Floor1, Floor2, Floor3, Floor4){|death,floor|

     if floor.bb.top.to_i - death.y.to_i < 80
   death.velocity_y = +1
        elsif death.y.to_i <= floor.bb.top.to_i 
    death.acceleration_y = 0
    death.y = death.previous_y
    death.jumping = false
     end
    }
   
    @death.each_collision(Pasto){|death,pasto|
     if death.x.to_i >= pasto.bb.left.to_i - 10 && death.y.to_i >= pasto.bb.top.to_i - 10
  death.velocity_y = +10
     end
 
     if pasto.bb.top.to_i - death.y.to_i < 80
   death.velocity_y = +1
        elsif death.y.to_i <= pasto.bb.top.to_i 
    death.acceleration_y = 0
    death.y = death.previous_y
    death.jumping = false
  else death.velocity_y = +1
     end

    }

    @death.each_collision(Cementerio){|death,cementerio|
     if death.x.to_i >= cementerio.bb.left.to_i - 10 && death.y.to_i >= cementerio.bb.top.to_i - 10
  death.velocity_y = +10
     end
  
     if cementerio.bb.top.to_i - death.y.to_i < 80
   death.velocity_y = +1
        elsif death.y.to_i <= cementerio.bb.top.to_i 
    death.acceleration_y = 0
    death.y = death.previous_y
    death.jumping = false
  else death.velocity_y = +1
     end
   }

    @death.each_collision(Barril){ |death, barril|
      barril.move = death.jumping ? true : false 
       if death.x.to_i >= barril.bb.left.to_i - 10 && death.y.to_i >= barril.bb.top.to_i - 10
  death_velocity_y = +10
     end
     
     if death.y.to_i <= barril.bb.top.to_i + 10
  death.acceleration_y = 0
        death.y = death.previous_y
  death.jumping = false
     elsif death.y.to_i >= barril.bb.bottom.to_i - 10
        death.velocity_y = +10
     end

    }

    if @death.jumping 
      Floor1.each{ |floor| floor.x -= 6; }
      Floor2.each{ |floor| floor.x -= 6; }
      Floor3.each{ |floor| floor.x -= 6; }
      Floor4.each{ |floor| floor.x -= 6; }
      Box.each{ |floor| floor.x -= 6; }
      Bombground.each{ |floor| floor.x -= 6; }
      Corp.each{ |floor| floor.x -= 6; }
      Piedra.each{ |floor| floor.x -= 6; }
      Lodo.each{ |floor| floor.x -= 6; }
      Barril.each{ |floor| floor.x -= 6; }
      Bomb.each{ |floor| floor.x -= 6; }
      Puas.each{ |floor| floor.x -= 6}
      Water1.each{ |floor| floor.x -= 6}
      Water2.each{ |floor| floor.x -= 6}
      Pasto.each{ |floor| floor.x -= 6}
      Cementerio.each{ |floor| floor.x -= 6}
      Soldier.each{ |floor| floor.x -= 6}
      Finalya.each{ |floor| floor.x -= 6}
    end
    
    @death.each_collision(Bombground){ |death,bombground|  bombground.destroy; death.destroy; push_game_state(Lose) }
    @death.each_collision(Puas){ |death,puas|  puas.destroy; death.destroy; push_game_state(Lose) }

    @death.each_collision(Box){|death,box|        
    
     if death.x.to_i >= box.x.to_i - 10
  death.velocity_y = +10 
     end
     if box.bb.top.to_i - death.y.to_i < 80
   death.velocity_y = +1
        elsif death.y.to_i <= box.bb.top.to_i 
    death.acceleration_y = 0
    death.y = death.previous_y
    death.jumping = false
  else death.velocity_y = +1
     end
    }

  

  @death.each_collision(Corp){|death,corp|
     if death.x.to_i >= corp.bb.left.to_i - 10 && death.y.to_i >= corp.bb.top.to_i - 10
  death_velocity_y = +10
     end
     
     if death.y.to_i <= corp.bb.top.to_i + 10
  death.acceleration_y = 0
        death.y = death.previous_y
  death.jumping = false
     elsif death.y.to_i >= corp.bb.bottom.to_i - 10
        death.velocity_y = +10
     end
 }
      
  
   Bomb.each{ |bomb|
     if bomb.x - 150 < @death.x
       bomb.start_down = true
     end
   }

   @death.each_collision(Bomb) {|death, bomb| 
     if bomb.bb.bottom.to_i > death.bb.top.to_i + 15
       bomb.explode
       during(500){ bomb.explode_effect }.then{
       bomb.destroy
       bomb.particula.destroy
       death.destroy
       push_game_state(Lose)}
     end
   }

   if self.viewport.outside_game_area?(@death)
      @death.destroy
      push_game_state(Lose)
    end
  end

end

class Lose < Chingu::GameState
  attr_accessor :frases_aleatorias
  def setup
     @frases_aleatorias = ["Control the scenario as the mask controls you","The insides of one man is the labyrinth of our faceless kind","The Grimm will always be anxious for the road to be over","The eyes will only rest when they see his last dream"]
    Chingu::Text.create(:text => @frases_aleatorias[rand(3)].to_s,:x=>200,:y=>$window.height/2,:size=>30)
    self.input = {:return => :clear}
    array = []
  #File.open("level-game.yml", "r") do |infile|        
   #while (line = infile.gets)
  #array.push(line)               
  #end
 #  end

#File.open("level.yml", 'w') { |file|
 #  file.truncate(0)
  #  for line in array
# file.write(line)
  #  end  }

 end

  def clear
    game_objects.destroy_all
#push_game_state(Intro)
    close_game
  end
end

class Intro < Chingu::GameState
  def initialize
#   Sound["intro.wav"].play
    super
    $window.caption = "The Grim"
   @image = Image["portada.png"]
   array = []
 # File.open("level-game.yml", "r") do |infile|        
 #  while (line = infile.gets)

#array.push(line)               
# end
 #  end

#File.open("level.yml", 'w') { |file|
 #  file.truncate(0)
  #  for line in array
  #file.write(line)
  #  end  }

    self.input = {:escape => :exit, :space => lambda{push_game_state(Level.new)} }
    end

  def draw
    super
   @image.draw(0,0,0)
  end
end


class Game < Chingu::Window
  def initialize
    super(1000,768, false)
    push_game_state(Aboutus)
  end
end


Game.new.show