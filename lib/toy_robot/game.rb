module ToyRobot
  class Game
    attr_reader :robot, :table

    def initialize
      @table = nil
      @robot = nil
    end

    def receive_input(input)
      if Parser.parse(input).nil?
        puts 'Invalid Command'
        return
      end

      command, args = Parser.parse(input).values_at(:command, :args)
      public_send(command, args)
    end

    # **args = {x: x, y: y} (optional)
    def create_table(**args)
      @table = Table.new(args)
    end

    def create_robot(x:, y:, facing:)
      raise 'table must be created before robot' unless @table
      raise 'robot not in bounds of table' unless @table.in_bounds?(x: x, y: y)

      @robot = Robot.new(x: x, y: y, facing: facing)
    end

    def valid_move?(x:, y:)
      @table.in_bounds?(x: x, y: y)
    end

    # ------------------------------------------------------- // Command methods

    def move(*_args)
      if valid_move?(@robot.next_position)
        @robot.move
      else
        puts 'Move Not Valid'
      end
    end

    def turn(direction)
      @robot.turn(direction)
    end

  end
end
