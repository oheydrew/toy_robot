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
end
