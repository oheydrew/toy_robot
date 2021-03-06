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

  describe 'receive_input' do
    it 'handles errors' do
      expect { game.receive_input('blaahblah') }
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
    end

    describe ':move' do
      it 'moves the robot if next_position is in bounds' do
        game.create_robot(x: 2, y: 2, facing: :north)
        game.receive_input('MOVE')
        expect(game.robot.position).to eq(x: 2, y: 3)
      end

      it 'does not move the robot if north on north edge' do
        game.create_robot(x: 4, y: 4, facing: :north)
        game.receive_input('MOVE')
        expect(game.robot.position).to eq(x: 4, y: 4)
      end

      it 'does not move the robot if east on east edge' do
        game.create_robot(x: 4, y: 4, facing: :east)
        game.receive_input('MOVE')
        expect(game.robot.position).to eq(x: 4, y: 4)
      end

      it 'does not move the robot if south on south edge' do
        game.create_robot(x: 0, y: 0, facing: :south)
        game.receive_input('MOVE')
        expect(game.robot.position).to eq(x: 0, y: 0)
      end

      it 'does not move the robot if west on west edge' do
        game.create_robot(x: 0, y: 0, facing: :west)
        game.receive_input('MOVE')
        expect(game.robot.position).to eq(x: 0, y: 0)
      end
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
          .to output("🤖 *beep* 'REPORTING. 2,2,NORTH.' *beep*\n").to_stdout
      end

      it 'should report the robot\'s position and facing to stdout #2' do
        game.create_robot(x: 1, y: 3, facing: :south)
        expect { game.receive_input('REPORT') }
          .to output("🤖 *beep* 'REPORTING. 1,3,SOUTH.' *beep*\n").to_stdout
      end
    end
  end
end
