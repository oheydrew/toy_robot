RSpec.describe ToyRobot do
  let(:game) { ToyRobot::Game.new }

  describe 'integration testing: sunny default table size' do
    before(:each) do
      game.create_table
    end

    it 'sunny test #1: Correct inputs' do
      game.receive_input('PLACE 2,2,NORTH')
      expect { game.receive_input('REPORT') }
        .to output(/2,2,NORTH/).to_stdout
    end

    it 'sunny test #2: Correct inputs' do
      game.receive_input('PLACE 2,2,NORTH')
      game.receive_input('MOVE')
      game.receive_input('LEFT')
      game.receive_input('MOVE')
      expect { game.receive_input('REPORT') }
        .to output(/1,3,WEST/).to_stdout
    end

    it 'sunny test #3: Correct inputs' do
      game.receive_input('PLACE 4,4,SOUTH')
      game.receive_input('MOVE')
      game.receive_input('MOVE')
      game.receive_input('RIGHT')
      game.receive_input('MOVE')
      expect { game.receive_input('REPORT') }
        .to output(/3,2,WEST/).to_stdout
    end

    it 'sunny test #4: Correct inputs' do
      game.receive_input('PLACE 4,4,SOUTH')
      game.receive_input('LEFT')
      game.receive_input('MOVE')
      game.receive_input('MOVE')
      game.receive_input('MOVE')
      expect { game.receive_input('REPORT') }
        .to output(/4,4,EAST/).to_stdout
    end

    it 'sunny test #5: Correct inputs' do
      game.receive_input('PLACE 4,4,SOUTH')
      game.receive_input('MOVE')
      game.receive_input('MOVE')
      game.receive_input('MOVE')
      game.receive_input('PLACE 1,1,SOUTH')
      expect { game.receive_input('REPORT') }
        .to output(/1,1,SOUTH/).to_stdout
    end

    it 'sunny test #6: Correct inputs' do
      game.receive_input('PLACE 2,2,SOUTH')
      game.receive_input('RIGHT')
      game.receive_input('RIGHT')
      game.receive_input('LEFT')
      game.receive_input('RIGHT')
      game.receive_input('RIGHT')
      game.receive_input('RIGHT')
      game.receive_input('MOVE')
      expect { game.receive_input('REPORT') }
        .to output(/2,1,SOUTH/).to_stdout
    end
  end

  describe 'integration testing: stormy default table size' do
    before(:each) do
      game.create_table
    end

    it 'stormy test #1: Incorrect PLACE' do
      game.receive_input('PLACE sdgsgsdgs,sdg,222')
      expect(game.robot).to be(nil)
    end

    it 'stormy test #2: Incorrect PLACE' do
      game.receive_input('PLACE')
      expect(game.robot).to be(nil)
    end

    it 'stormy test #3: Incorrect inputs' do
      game.receive_input('PLACE 4,4,SOUTH')
      game.receive_input('Beep')
      game.receive_input('move')
      game.receive_input('BOOP')
      game.receive_input('left')
      expect { game.receive_input('REPORT') }
        .to output(/4,4,SOUTH/).to_stdout
    end

    it 'stormy test #4: Error catching' do
      expect { game.receive_input('gadvvad') }
        .not_to raise_error
    end

    it 'stormy test #5: Error catching' do
      expect { game.receive_input('PLACE 22351234edvvv.sds.vs,s,sr') }
        .not_to raise_error
    end

    it 'stormy test #6: Error catching' do
      expect { game.receive_input('MOOVE') }
        .not_to raise_error
    end
  end

  describe 'integration testing: weird table sizes' do
    describe 'a teeny tiny table' do
      before(:each) do
        game.create_table(x: 1, y: 1)
      end

      it 'Place on the tiny table' do
        game.receive_input('PLACE 1,1,NORTH')
        expect { game.receive_input('REPORT') }
          .to output(/1,1,NORTH/).to_stdout
      end

      it 'Can\'t move on the tiny table' do
        game.receive_input('PLACE 1,1,NORTH')
        game.receive_input('MOVE')
        game.receive_input('MOVE')
        game.receive_input('MOVE')
        expect { game.receive_input('REPORT') }
          .to output(/1,1,NORTH/).to_stdout
      end
    end

    describe 'a stupidly large table' do
      before(:each) do
        game.create_table(x: 9999999999, y: 999999999)
      end

      it 'Place on the huge table' do
        game.receive_input('PLACE 999999,999999,NORTH')
        expect { game.receive_input('REPORT') }
          .to output(/999999,999999,NORTH/).to_stdout
      end

      it 'Can move tons on the huge table' do
        game.receive_input('PLACE 999999,999999,NORTH')
        game.receive_input('MOVE')
        game.receive_input('MOVE')
        game.receive_input('MOVE')
        game.receive_input('MOVE')
        game.receive_input('MOVE')
        expect { game.receive_input('REPORT') }
          .to output(/999999,1000004,NORTH/).to_stdout
      end
    end
  end
end
