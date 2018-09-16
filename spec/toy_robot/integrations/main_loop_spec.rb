RSpec.describe ToyRobot::MainLoop do
  describe 'game setup' do
    before(:each) do
      ToyRobot::MainLoop.game = ToyRobot::Game.new
    end

    it 'sets up a Game' do
      expect(ToyRobot::MainLoop.game).to be_an_instance_of(ToyRobot::Game)
    end

    it 'creates a table without size' do
      parsed_output = ToyRobot::Parser.parse_size('')
      ToyRobot::MainLoop.table_creator(parsed_output)
      expect(ToyRobot::MainLoop.game.table.size).to eq(x: 4, y: 4)
    end

    it 'creates a table with size' do
      parsed_output = ToyRobot::Parser.parse_size('6,6')
      ToyRobot::MainLoop.table_creator(parsed_output)
      expect(ToyRobot::MainLoop.game.table.size).to eq(x: 6, y: 6)
    end

    it 'does not create a table with bad sizes' do
      parsed_output = ToyRobot::Parser.parse_size('HEY BUDDY')
      ToyRobot::MainLoop.table_creator(parsed_output)
      expect(ToyRobot::MainLoop.game.table).to be(nil)
    end

    it 'does not create a table with bad sizes' do
      parsed_output = ToyRobot::Parser.parse_size('HEY,5')
      ToyRobot::MainLoop.table_creator(parsed_output)
      expect(ToyRobot::MainLoop.game.table).to be(nil)
    end
  end
end
