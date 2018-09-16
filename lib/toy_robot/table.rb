module ToyRobot
  class Table
    attr_reader :size

    def initialize(x: 4, y: 4)
      @size = {
        x: x,
        y: y
      }
    end

    def in_bounds?(x:, y:, **args)
      x_in_bounds = x >= 0 && x <= @size[:x]
      y_in_bounds = y >= 0 && y <= @size[:x]

      x_in_bounds && y_in_bounds
    end
  end
end
