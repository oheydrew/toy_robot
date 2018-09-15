RSpec.describe ToyRobot::Parser do
  describe 'init' do
    it 'can call static methods directly on Parser' do
      expect(ToyRobot::Parser.test).to be(true)
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
            position: {
              x: 2,
              y: 2
            },
            facing: :north
          }
        )
    end

    it 'can parse a LEFT command' do
      expect(ToyRobot::Parser.parse('LEFT'))
        .to eq(
          command: :turn,
          args: {
            direction: :left
          }
        )
    end

    it 'can parse a RIGHT command' do
      expect(ToyRobot::Parser.parse('RIGHT'))
        .to eq(
          command: :turn,
          args: {
            direction: :right
          }
        )
    end

    it 'can parse a REPORT command' do
      expect(ToyRobot::Parser.parse('REPORT'))
        .to eq(command: :report, args: nil)
    end
  end

  describe 'parse error generation' do
    it 'throws an error if MOVE has arguments' do
      expect { ToyRobot::Parser.parse('MOVE LEFT') }
        .to raise_error(ArgumentError)
    end

    it 'throws an error if LEFT has arguments' do
      expect { ToyRobot::Parser.parse('LEFT 222 hello') }
        .to raise_error(ArgumentError)
    end

    it 'throws an error if RIGHT has arguments' do
      expect { ToyRobot::Parser.parse('RIGHT all your base') }
        .to raise_error(ArgumentError)
    end

    it 'throws an error if REPORT has arguments' do
      expect { ToyRobot::Parser.parse('REPORT    time') }
        .to raise_error(ArgumentError)
    end

    it 'throws an error if PLACE has no arguments' do
      expect { ToyRobot::Parser.parse('PLACE') }
        .to raise_error(ArgumentError)
    end

    it 'throws an error if PLACE has invalid direction' do
      expect { ToyRobot::Parser.parse('PLACE 2,2,FRED') }
        .to raise_error(ArgumentError)
    end

    it 'throws an error if PLACE has too few args' do
      expect { ToyRobot::Parser.parse('PLACE 2,2') }
        .to raise_error(ArgumentError)
    end

    it 'throws an error if PLACE has too many args' do
      expect { ToyRobot::Parser.parse('PLACE OH,MY,GOLLY,GOSH') }
        .to raise_error(ArgumentError)
    end

    it 'throws an error if PLACE has non integers supplied' do
      expect { ToyRobot::Parser.parse('PLACE FRANKY,SAYS,PARTY') }
        .to raise_error(ArgumentError)
    end

    it 'throws an error if PLACE has all integers supplied' do
      expect { ToyRobot::Parser.parse('PLACE 2,2,5') }
        .to raise_error(ArgumentError)
    end

    it 'throws an error if PLACE has odd arguments supplied' do
      expect { ToyRobot::Parser.parse('PLACE NUMBER,BEAST,6') }
        .to raise_error(ArgumentError)
    end
  end
end
