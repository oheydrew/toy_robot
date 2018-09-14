module ToyRobot
  class Game
    attr_reader :robot, :table

    def initialize
      @robot = nil
      @table = nil
    end

    # **args = {x: x, y: y} (optional)
    def create_table(**args)
      @table = Table.new(args)
    end

    def create_robot(x:, y:, facing:)
      unless @table
        raise RuntimeError, 'table must be created before robot'
      end

      unless @table.in_bounds?(x: x, y: y)
        raise RuntimeError, 'robot not in bounds of table'
      end

      @robot = Robot.new(x: x, y: y, facing: facing)
    end
  end
end
