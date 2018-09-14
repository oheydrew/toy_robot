RSpec.describe ToyRobot::Robot do
  let(:robot) { ToyRobot::Robot.new(x: 0, y: 0, facing: :north) }

  describe 'init' do
    it 'can instantiate an instance of Robot' do
      expect(robot).to be_an_instance_of(ToyRobot::Robot)
    end
  end
end
