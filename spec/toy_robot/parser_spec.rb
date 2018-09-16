RSpec.describe ToyRobot::Parser do
  describe 'init' do
    it 'can call static methods directly on Parser' do
      expect(ToyRobot::Parser.parse('MOVE'))
        .to include(command: :move, args: nil)
    end
  end

  describe 'parse (string input)' do
    it 'can parse a MOVE command' do
      expect(ToyRobot::Parser.parse('MOVE'))
        .to include(command: :move, args: nil)
    end

    it 'can parse a PLACE command' do
      expect(ToyRobot::Parser.parse('PLACE 2,2,NORTH'))
        .to include(
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
        .to include(
          command: :turn,
          args: :left
        )
    end

    it 'can parse a RIGHT command' do
      expect(ToyRobot::Parser.parse('RIGHT'))
        .to include(
          command: :turn,
          args: :right
        )
    end

    it 'can parse a REPORT command' do
      expect(ToyRobot::Parser.parse('REPORT'))
        .to include(command: :report, args: nil)
    end
  end

  describe 'parse error message passing' do
    it 'returns an error msg if PLACE has no args' do
      expect(ToyRobot::Parser.parse('PLACE'))
        .to include(:error)
    end

    it 'returns an error msg if PLACE has invalid direction' do
      expect(ToyRobot::Parser.parse('PLACE 2,2,FRED'))
        .to include(:error)
    end

    it 'returns an error msg if PLACE has too few args' do
      expect(ToyRobot::Parser.parse('PLACE 2,2'))
        .to include(:error)
    end

    it 'returns an error msg if PLACE has too many args' do
      expect(ToyRobot::Parser.parse('PLACE OH,MY,GOLLY,GOSH'))
        .to include(:error)
    end

    it 'returns an error msg if PLACE has non integers supplied' do
      expect(ToyRobot::Parser.parse('PLACE FRANKY,SAYS,PARTY'))
        .to include(:error)
    end

    it 'returns an error msg if PLACE has all integers supplied' do
      expect(ToyRobot::Parser.parse('PLACE 2,2,5'))
        .to include(:error)
    end

    it 'returns an error msg if PLACE has odd arguments supplied' do
      expect(ToyRobot::Parser.parse('PLACE NUMBER,BEAST,6'))
        .to include(:error)
    end
  end
end
