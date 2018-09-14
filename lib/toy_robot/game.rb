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

    
  end
end
