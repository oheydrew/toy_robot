RSpec.describe ToyRobot::Robot do
  let(:table) { ToyRobot::Table.new }

  describe 'init' do
    it 'can instantiate an instance of Table' do
      expect(table).to be_an_instance_of(ToyRubot::Table)
    end
  end
end
