RSpec.describe ToyRobot::Main do
  let(:game) { ToyRobot::Game.new }

  describe 'main running game loop' do

    before(:each) do
      game.create_table
      game.create_robot(x: 2, y: 2, facing: :north)
    end

    it 'is a test' do
      # here we go
    end
  end
end
