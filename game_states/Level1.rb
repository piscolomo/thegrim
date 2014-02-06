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
    self.input = {:left_mouse_button => :click, :released_left_mouse_button => :unclick, :e => :edit, :escape => :exit}
    @parallax = Chingu::Parallax.create(:x => 0, :y=>0, :rotation_center => :top_left)
    @parallax.add_layer(:image => "background1.png")
    after(40000){ @parallax.add_layer(:image => "background2.png")    }
    load_game_objects
    @mouse_x, @mouse_y = $window.mouse_x, $window.mouse_y
    @cursor = Cursor.create(:x => @mouse_x, :y => @mouse_y)   
  end
   def edit
    push_game_state(GameStates::Edit.new(:grid => [18,18], :classes =>  [Soldier,Finalya, Barril, Bomb, Bombground, Box, Cementerio, Corp, Floor1, Lodo, Pasto, Piedra, Puas, Water1, Water2]))
  end
 
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
   #puts @death.x
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
    #puts "death.y #{death.y}  floor.bb.top  #{floor.bb.top}"

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
