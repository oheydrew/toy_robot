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

  describe 'next_position' do
    it 'can return it\'s next move' do
      expect(robot.next_position).to eq(x: 0, y: 1)
    end

    it 'returns it\'s next move without moving' do
      expect(robot.next_position).to eq(x: 0, y: 1)
      expect(robot.position).to eq(x: 0, y: 0)
    end
  end

  describe 'turning' do
    it 'can turn left' do
      robot.turn(:left)
      expect(robot.facing).to eq(:west)
    end

    it 'can turn right' do
      robot.turn(:right)
      expect(robot.facing).to eq(:east)
    end

    it 'can turn to the left 180 degrees' do
      robot.turn(:left)
      robot.turn(:left)
      expect(robot.facing).to eq(:south)
    end

    it 'can turn to the right a full 360 degrees' do
      robot.turn(:right)
      robot.turn(:right)
      robot.turn(:right)
      robot.turn(:right)
      expect(robot.facing).to eq(:north)
    end
  end
end
