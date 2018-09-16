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
  end

  describe 'valid_move?' do
    # TODO: Make this method private? Thus, don't test it. 
    # Move these tests to :move and Table?

    it 'returns true if coordinates in range' do
      game.create_table
      expect(game.valid_move?(x: 3, y: 3)).to be(true)
    end

    it 'returns false if coordinates out of range' do
      game.create_table
      expect(game.valid_move?(x: 15, y: 15)).to be(false)
    end

    it 'returns false if x coordinate out of range' do
      game.create_table
      expect(game.valid_move?(x: 15, y: 3)).to be(false)
    end

    it 'returns false if y coordinate out of range' do
      game.create_table
      expect(game.valid_move?(x: 3, y: 15)).to be(false)
    end

    it 'can get and pass the next robot move if valid' do
      game.create_table
      game.create_robot(x: 2, y: 2, facing: :north)
      expect(game.valid_move?(game.robot.next_position)).to be(true)
    end

    # TODO: Move these tests to :move ?

    it 'returns false if north on north edge' do
      game.create_table
      game.create_robot(x: 4, y: 4, facing: :north)
      expect(game.valid_move?(game.robot.next_position)).to be(false)
    end

    it 'returns false if east on east edge' do
      game.create_table
      game.create_robot(x: 4, y: 4, facing: :east)
      expect(game.valid_move?(game.robot.next_position)).to be(false)
    end

    it 'returns false if south on south edge' do
      game.create_table
      game.create_robot(x: 0, y: 0, facing: :south)
      expect(game.valid_move?(game.robot.next_position)).to be(false)
    end

    it 'returns false if west on west edge' do
      game.create_table
      game.create_robot(x: 0, y: 0, facing: :west)
      expect(game.valid_move?(game.robot.next_position)).to be(false)
    end
  end

  describe 'receive_input' do
    it 'prints \'Invalid Command\' if command invalid' do
      expect { game.receive_input('asfafqe') }
        .to output(/Invalid Command\n/).to_stdout # TODO: This will be Output?
    end

    it 'handles errors' do
      expect { game.receive_input('blaah') }
        .not_to raise_error
    end
  end

  describe 'game main command methods' do
    before(:each) do
      game.create_table
    end

    describe ':place' do
      it 'places the robot if coordinates are in bounds' do
        game.receive_input('PLACE 2,2,NORTH')
        expect(game.robot.position).to eq(x: 2, y: 2)
        expect(game.robot.facing).to eq(:north)
      end

      it 'does not place the robot if coordinates are out of bounds' do
        game.receive_input('PLACE 15,15,NORTH')
        expect(game.robot).to eq(nil)
      end

      it 'does not create robot if no table is created' do
        game = ToyRobot::Game.new
        game.receive_input('PLACE 2,2,NORTH')
        expect(game.robot).to be(nil)
      end

      it 'notifies the user if no table is created' do
        game = ToyRobot::Game.new
        game.receive_input('PLACE 2,2,NORTH')
        expect { game.receive_input('PLACE 2,2,NORTH') }
          .to output(/Table has not been created. Robot cannot be placed yet./)
          .to_stdout
      end

      # TODO: More examples please
    end

    describe ':move' do
      it 'moves the robot if next_position is in bounds' do
        game.create_robot(x: 2, y: 2, facing: :north)
        game.receive_input('MOVE')
        expect(game.robot.position).to eq(x: 2, y: 3)
      end

      it 'does not move the robot if next_position is out of bounds' do
        game.create_robot(x: 4, y: 4, facing: :north)
        game.receive_input('MOVE')
        expect(game.robot.position).to eq(x: 4, y: 4)
      end

      # TODO: More examples please

      # TODO: Move some "check_valid?" tests here?
    end

    describe ':turn' do
      it 'turns the robot left' do
        game.create_robot(x: 2, y: 2, facing: :north)
        game.receive_input('LEFT')
        expect(game.robot.facing).to eq(:west)
      end

      it 'turns the robot right' do
        game.create_robot(x: 2, y: 2, facing: :north)
        game.receive_input('RIGHT')
        expect(game.robot.facing).to eq(:east)
      end
    end

    describe ':report' do
      it 'should report the robot\'s position and facing to stdout #1' do
        game.create_robot(x: 2, y: 2, facing: :north)
        expect { game.receive_input('REPORT') }
          .to output(/2,2,NORTH\n/).to_stdout # TODO: This will be Output?
      end

      it 'should report the robot\'s position and facing to stdout #2' do
        game.create_robot(x: 1, y: 3, facing: :south)
        expect { game.receive_input('REPORT') }
          .to output(/1,3,SOUTH\n/).to_stdout # TODO: This will be Output?
      end

      # TODO: More examples please
    end
  end
end
