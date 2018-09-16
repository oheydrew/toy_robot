module ToyRobot
  class Parser
    class << self
      def parse(string)
        command_string, args_string = format_string(string)
        err_msg = 'Invalid command. Try: PLACE X,Y,FACING / MOVE / LEFT / RIGHT / REPORT'

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
            command = :place
            args = {
              x: args_string[0].to_i,
              y: args_string[1].to_i,
              facing: args_string[2].downcase.to_sym
            }
          end
        when 'OPEN' # THE POD BAY DOORS
          err_msg = 'I can\'t do that, Fred.'
        end

        err_msg = nil if command
        { command: command, args: args, error: err_msg }
      end

      def parse_size(string)
        return nil if string == ''
        string_ary = string.split(',')
        x, y = string_ary

        { x: x.to_i, y: y.to_i }
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
          err_msg = 'Command PLACE requires X,Y,FACING args. Try: PLACE 2,2,NORTH'
        elsif !place_args_valid_types?(args)
          err_msg = 'Command PLACE requires X,Y,FACING args. Try: PLACE 2,2,NORTH'
        elsif !place_args_valid_direction?(args)
          err_msg = 'Command PLACE invalid direction. CASE SENSITIVE (NORTH, SOUTH, EAST, WEST)'
        elsif place_args_valid_types?(args) && place_args_valid_direction?(args)
          return false
        end

        err_msg
      end

      def place_args_valid_types?(args)
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
