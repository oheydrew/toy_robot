RSpec.describe ToyRobot::Parser do
  describe 'init' do
    it 'can call static methods directly on Parser' do
      expect(ToyRobot::Parser.test).to be(true)
    end
  end
end
