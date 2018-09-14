RSpec.describe ToyRobot::Robot do
  let(:robot) { ToyRobot::Robot.new(x: 0, y: 0, facing: :north) }

  describe 'init' do
    it 'can instantiate an instance of Robot' do
      expect(robot).to be_an_instance_of(ToyRobot::Robot)
    end
  end

  describe 'position / move' do
    it 'can return it\'s position' do
      expect(robot.position).to eq(x: 0, y: 0)
    end

    it 'can move forward' do
      robot.move
      expect(robot.position).to eq(x: 0, y: 1)
      expect(robot.facing).to eq(:north)
    end
  end

  describe 'turning' do
    it 'can turn left' do
      robot.turn(:left)
      expect(robot.facing).to eq(:east)
    end

    it 'can turn right' do
      robot.turn(:right)
      expect(robot.facing).to eq(:west)
    end
  end

end
