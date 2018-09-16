module ToyRobot
  class Game
    attr_reader :robot, :table

    def initialize
      @table = nil
      @robot = nil
    end

    def receive_input(input)
      parsed_output = Parser.parse(input)
      command, args, err_msg = parsed_output.values_at(:command, :args, :error)

      if err_msg
        puts "Error: #{err_msg}"
        return
      end

      if !@robot && [:move, :turn, :report].include?(command)
        puts "Error: Robot not yet placed. Try PLACE X,Y,FACING"
      elsif @robot || command == :place
        send(command, args)
      end
    end

    # **args = {x: x, y: y} (optional)
    def create_table(**args)
      @table = Table.new(args)
    end

    def create_robot(x:, y:, facing:)
      @robot = Robot.new(x: x, y: y, facing: facing)
    end

    private # ----------------------------------------------- // private methods

    # **args = {x: x, y: y, facing: facing} 
    def place(**args)
      if @table.nil?
        puts 'Table has not been created. Robot cannot be placed yet.'
      elsif !@table.in_bounds?(args)
        puts 'Requested position out of bounds of Table.'
        puts "Your table size is: #{@table.size[:x]}, #{@table.size[:y]}"
      elsif @table.in_bounds?(args)
        create_robot(args)
      end
    end

    def move(*_args)
      if @table.in_bounds?(@robot.next_position)
        @robot.move
      else
        puts 'Move Not Valid'
      end
    end

    def turn(direction)
      @robot.turn(direction)
    end

    def report(*_args)
      x = @robot.position[:x]
      y = @robot.position[:y]
      facing = @robot.facing.to_s.upcase

      puts "#{x},#{y},#{facing}"
    end
  end
end
