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

  describe 'robot creation and naming' do
    it 'can create a new robot at position with default name' do
      game.create_table
      game.create_robot(x: 2, y: 2, facing: :north)
      expect(game.robot).to be_an_instance_of(ToyRobot::Robot)
      expect(game.robot.position).to eq(x: 2, y: 2)
      expect(game.robot.facing).to eq(:north)
    end

    it 'can create a new robot at position with given name' do
      game.create_table
      game.create_robot(x: 2, y: 2, facing: :north)
      expect(game.robot).to be_an_instance_of(ToyRobot::Robot)
      expect(game.robot.position).to eq(x: 2, y: 2)
      expect(game.robot.facing).to eq(:north)
    end

    it 'raises an error if no table is created' do
      expect { game.create_robot(x: 2, y: 2, facing: :north) }
        .to raise_error(RuntimeError)
    end

    it 'raises an error if placed out of bounds' do
      game.create_table
      expect { game.create_robot(x: 15, y: 15, facing: :north) }
        .to raise_error(RuntimeError)
    end
  end

  describe 'valid_move?' do
    it 'returns true if coordinates in range' do
      game.create_table
      expect(game.valid_move?(x: 3, y: 3)).to be(true)
    end

    it 'returns false if coordinates out of range' do
      game.create_table
      expect(game.valid_move?(x: 15, y: 15)).to be(false)
    end
  end
end
