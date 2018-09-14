RSpec.describe ToyRobot::Robot do
  let(:table) { ToyRobot::Table.new }

  describe 'init' do
    it 'can instantiate an instance of Table' do
      expect(table).to be_an_instance_of(ToyRobot::Table)
    end

    it 'can have a default size if none supplied' do
      expect(table.size).to eq(x: 4, y: 4)
    end

    it 'can instantiate with size if supplied' do
      table = ToyRobot::Table.new(x: 15, y: 15)
      expect(table.size).to eq(x: 15, y: 15)
    end
  end

  describe '.in_bounds?' do
    it 'returns true if in-bounds values supplied' do
      expect(table.in_bounds?(x: 2, y: 2)).to be(true)
    end

    it 'returns false if out-of-bounds values supplied' do
      expect(table.in_bounds?(x: 15, y: 15)).to be(false)
    end
  end

end
