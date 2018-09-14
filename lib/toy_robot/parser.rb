module ToyRobot
  class Parser
    class << self
      def parse(string)
        command, args = format_string(string)

        case command
        when 'MOVE'
          command = :move
        when 'LEFT'
          command = :turn
          args = {
            direction: :left
          }
        when 'RIGHT'
          command = :turn
          args = {
            direction: :right
          }
        when 'REPORT'
          command = :report
        when 'PLACE'
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

        [ command, args ]
      end

      def private_call_test
        true
      end
    end
  end
end
