module ToyRobot
  class Parser
    class << self
      def parse(string)
        command_string, args_string = format_string(string)
        error = 'Invalid command. Try: PLACE X,Y,FACING / MOVE / LEFT / RIGHT / REPORT'

        case command_string
        when 'MOVE'
          command = :move
        when 'LEFT'
          command = :turn
          args = :left
        when 'RIGHT'
          command = :turn
          args = :right
        when 'REPORT'
          command = :report
        when 'PLACE'
          if validate_place_args(args_string)
            err_msg = validate_place_args(args_string) 
          else
            direction = args_string[2].downcase.to_sym

            command = :place
            args = {
              x: args_string[0].to_i,
              y: args_string[1].to_i,
              facing: direction
            }
          end
        end

        return { command: command, args: args } if command
        return { error: err_msg } unless command
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

      def validate_place_args(args)
        if args.nil?
          e_msg = 'Command PLACE requires X,Y,FACING args. Try: PLACE 2,2,NORTH'
        elsif !place_args_types_valid?(args)
          e_msg = 'Command PLACE requires X,Y,FACING args. Try: PLACE 2,2,NORTH'
        elsif !place_args_valid_direction?(args)
          e_msg = 'Command PLACE invalid direction. CASE SENSITIVE (NORTH, SOUTH, EAST, WEST)'
        elsif place_args_types_valid?(args) && place_args_valid_direction?(args)
          return false
        end

        e_msg
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

      # Removed reference to this method: Unnecessary error generation
      def validate_no_args(command, args)
        return unless args

        raise ArgumentError,
              "Command #{command} takes no arguments. Try: #{command}"
      end
    end
  end
end
