RSpec.describe ToyRobot::MainLoop do
  describe 'game setup' do
    before(:all) do
      ToyRobot::MainLoop.setup
    end

    it 'sets up a Game' do
      expect(ToyRobot::MainLoop.game).to be_an_instance_of(ToyRobot::Game)
    end

    it 'creates a table without size' do
      ToyRobot::MainLoop.game.create_table
      expect(ToyRobot::MainLoop.game.table.size).to eq(x: 4, y: 4)
    end

    it 'creates a table with size' do
      ToyRobot::MainLoop.game.create_table(x: 6, y: 6)
      expect(ToyRobot::MainLoop.game.table.size).to eq(x: 6, y: 6)
    end

    # TODO: More integration tests here
  end
end
