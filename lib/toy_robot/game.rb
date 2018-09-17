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
        Display.error(err_msg)
        return
      end

      if !@robot && [:move, :turn, :report].include?(command)
        Display.error "Robot not yet placed. Try PLACE X,Y,FACING"
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
        Display.error 'Table has not been created. Robot cannot be placed yet.'
      elsif !@table.in_bounds?(args)
        Display.error 'Requested position out of bounds of Table.'
        Display.error "Your table size is: #{@table.size[:x]}, #{@table.size[:y]}"
      elsif @table.in_bounds?(args)
        create_robot(args)
        Display.robot "*winstartupsound* 'I LIVE!'"
      end
    end

    def move(*_args)
      if @table.in_bounds?(@robot.next_position)
        @robot.move
        Display.robot "*beep* 'MOVING FORWARD.' *whirrr*"
      else
        Display.robot "*bzzt!* 'TABLE EDGE DETECTED. STOPPING. I DO NOT WISH TO FEEL PAIN.'"
      end
    end

    def turn(direction)
      @robot.turn(direction)
      Display.robot "*beep* 'TURNING #{direction.to_s.upcase}.' *clang* *clank*"
    end

    def report(*_args)
      x = @robot.position[:x]
      y = @robot.position[:y]
      facing = @robot.facing.to_s.upcase

      Display.robot "*beep* 'REPORTING. #{x},#{y},#{facing}.' *beep*"
    end
  end
end
