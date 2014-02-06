class Intro < Chingu::GameState
  def initialize
#   Sound["intro.wav"].play
    super
    $window.caption = "The Grim"
   @image = Image["portada.png"]
   array = []
  File.open("level-game.yml", "r") do |infile|        
   while (line = infile.gets)

array.push(line)               
	end
   end

File.open("level.yml", 'w') { |file|
   file.truncate(0)
    for line in array
	file.write(line)
    end  }

    self.input = {:escape => :exit, :space => lambda{push_game_state(Level.new)} }
    end

  def draw
    super
   @image.draw(0,0,0)
  end
end
