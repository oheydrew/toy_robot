module ToyRobot
  class Parser
    class << self
      def parse(string)
        command_string, args_string = format_string(string)

        case command_string
        when 'MOVE'
          validate_no_args(command_string, args_string)

          command = :move
        when 'LEFT'
          validate_no_args(command_string, args_string)

          command = :turn
          args = :left
        when 'RIGHT'
          validate_no_args(command_string, args_string)

          command = :turn
          args = :right
        when 'REPORT'
          validate_no_args(command_string, args_string)

          command = :report
        when 'PLACE'
          validate_place_args(args_string)

          direction = args_string[2].downcase.to_sym

          command = :place
          args = {
            x: args_string[0].to_i,
            y: args_string[1].to_i,
            facing: direction
          }
        end

        { command: command, args: args } if command
      end

      def test
        true
      end
    end

    class << self
      private # ----------------------------------------------------- // private

      def format_string(string)
        string_ary = string.strip.split(' ')
        command = string_ary[0]
        args = string_ary[1].split(',') if string_ary[1]

        [command, args]
      end

      def validate_no_args(command, args)
        return unless args

        raise ArgumentError,
              "Command #{command} takes no arguments. Try: #{command}"
      end

      def validate_place_args(args)
        if args.nil?
          msg = 'Command PLACE requires X,Y,FACING args. Try: PLACE 2,2,NORTH'
        elsif !place_args_types_valid?(args)
          msg = 'Command PLACE requires X,Y,FACING args. Try: PLACE 2,2,NORTH'
        elsif !place_args_valid_direction?(args)
          msg = 'Command PLACE invalid direction. CASE SENSITIVE (NORTH, SOUTH, EAST, WEST)'
        elsif place_args_types_valid?(args) && place_args_valid_direction?(args)
          return
        end

        raise ArgumentError, msg
      end

      def place_args_types_valid?(args)
        arg_0_number = Float(args[0]) rescue false
        arg_1_number = Float(args[1]) rescue false
        arg_2_string = !(Float(args[2]) rescue false)

        arg_0_number && arg_1_number && arg_2_string
      end

      def place_args_valid_direction?(args)
        ['NORTH', 'SOUTH', 'EAST', 'WEST'].include?(args[2])
      end
    end
  end
end
