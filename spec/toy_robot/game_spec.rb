RSpec.describe ToyRobot::Game do
  let(:game) { ToyRobot::Game.new }

  describe 'init' do
    it 'can instantiate an instance of Game' do
      expect(game).to be_an_instance_of(ToyRobot::Game)
    end
  end

  describe 'table related' do
    it 'can create a new table with a size' do
      game.create_table(x: 2, y: 2)
      expect(game.table).to be_an_instance_of(ToyRobot::Table)
      expect(game.table.size).to eq(x: 2, y: 2)
    end

    it 'can create a new table with no size' do
      game.create_table
      expect(game.table).to be_an_instance_of(ToyRobot::Table)
      expect(game.table.size).to eq(x: 4, y: 4)
    end
  end
end
