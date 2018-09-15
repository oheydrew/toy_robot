RSpec.describe ToyRobot::MainLoop do
  describe 'game setup' do
    it 'sets up a Game with no arguments' do
      ToyRobot::MainLoop.setup
      expect(ToyRobot::MainLoop.game).to be_an_instance_of(ToyRobot::Game)
    end
  end
end
