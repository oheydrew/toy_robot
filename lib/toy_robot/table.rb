module ToyRobot
  class Table
    attr_reader :size

    def initialize(x: 4, y: 4)
      @size = {
        x: x,
        y: y
      }
    end
  end
end
