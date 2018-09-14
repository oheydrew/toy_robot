module ToyRobot
  class Game
    attr_reader :robot, :table

    def initialize
      @robot = nil
      @table = nil
    end

    def create_table(**args)
      @table = Table.new(args)
    end
  end
end
