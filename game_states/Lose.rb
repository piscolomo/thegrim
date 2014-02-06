class Lose < Chingu::GameState
  attr_accessor :frases_aleatorias
  def setup
     @frases_aleatorias = ["Control the scenario as the mask controls you","The insides of one man is the labyrinth of our faceless kind","The Grimm will always be anxious for the road to be over","The eyes will only rest when they see his last dream"]
    Chingu::Text.create(:text => @frases_aleatorias[rand(3)].to_s,:x=>200,:y=>$window.height/2,:size=>30)
    self.input = {:return => :clear}
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

 end

  def clear
    game_objects.destroy_all
#push_game_state(Intro)
    close_game
  end
end
