module ToyRobot
  class Parser
    class << self
      def parse(string)
        command, args = format_string(string)

        case command
        when 'MOVE'
          validate_no_args(command, args)

          command = :move
        when 'LEFT'
          validate_no_args(command, args)

          command = :turn
          args = {
            direction: :left
          }
        when 'RIGHT'
          validate_no_args(command, args)

          command = :turn
          args = {
            direction: :right
          }
        when 'REPORT'
          validate_no_args(command, args)

          command = :report
        when 'PLACE'
          validate_place_args(args)

          direction = args[2].downcase.to_sym

          command = :place
          args = {
            position: {
              x: args[0].to_i,
              y: args[1].to_i
            },
            facing: direction
          }
        end

        { command: command, args: args }
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
          raise ArgumentError,
                'Command PLACE requires X,Y,FACING args. Try: PLACE 2,2,NORTH'
        end

        if args.length == 3
          return if place_args_types_valid?(args)
        end

        raise ArgumentError,
              'Command PLACE arguments invalid. Try: PLACE 2,2,NORTH'
      end

      def place_args_types_valid?(args)
        arg_0_number = Float(args[0]) rescue false
        arg_1_number = Float(args[1]) rescue false
        arg_2_string = ['NORTH', 'SOUTH', 'EAST', 'WEST'].include?(args[2])

        arg_0_number && arg_1_number && arg_2_string
      end

    end
  end
end
