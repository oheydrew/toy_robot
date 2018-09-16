RSpec.describe ToyRobot::Parser do
  describe 'init' do
    it 'can call static methods directly on Parser' do
      expect(ToyRobot::Parser.parse('MOVE'))
        .to eq(command: :move, args: nil)
    end
  end

  describe 'parse (string input)' do
    it 'can parse a MOVE command' do
      expect(ToyRobot::Parser.parse('MOVE'))
        .to eq(command: :move, args: nil)
    end

    it 'can parse a PLACE command' do
      expect(ToyRobot::Parser.parse('PLACE 2,2,NORTH'))
        .to eq(
          command: :place,
          args: {
            x: 2,
            y: 2,
            facing: :north
          }
        )
    end

    it 'can parse a LEFT command' do
      expect(ToyRobot::Parser.parse('LEFT'))
        .to eq(
          command: :turn,
          args: :left
        )
    end

    it 'can parse a RIGHT command' do
      expect(ToyRobot::Parser.parse('RIGHT'))
        .to eq(
          command: :turn,
          args: :right
        )
    end

    it 'can parse a REPORT command' do
      expect(ToyRobot::Parser.parse('REPORT'))
        .to eq(command: :report, args: nil)
    end
  end

  describe 'parse error generation' do
    it 'returns an error msg if PLACE has no args' do
      output = ToyRobot::Parser.parse('PLACE')
      expect(output.key?(:error)).to be(true)
    end

    it 'returns an error msg if PLACE has invalid direction' do
      output = ToyRobot::Parser.parse('PLACE 2,2,FRED')
      expect(output.key?(:error)).to be(true)
    end

    it 'returns an error msg if PLACE has too few args' do
      output = ToyRobot::Parser.parse('PLACE 2,2')
      expect(output.key?(:error)).to be(true)
    end

    it 'returns an error msg if PLACE has too many args' do
      output = ToyRobot::Parser.parse('PLACE OH,MY,GOLLY,GOSH')
      expect(output.key?(:error)).to be(true)
    end

    it 'returns an error msg if PLACE has non integers supplied' do
      output = ToyRobot::Parser.parse('PLACE FRANKY,SAYS,PARTY')
      expect(output.key?(:error)).to be(true)
    end

    it 'returns an error msg if PLACE has all integers supplied' do
      output = ToyRobot::Parser.parse('PLACE 2,2,5')
      expect(output.key?(:error)).to be(true)
    end

    it 'returns an error msg if PLACE has odd arguments supplied' do
      output = ToyRobot::Parser.parse('PLACE NUMBER,BEAST,6')
      expect(output.key?(:error)).to be(true)
    end
  end
end
