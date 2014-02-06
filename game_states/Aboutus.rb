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

