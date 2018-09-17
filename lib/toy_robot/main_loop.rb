module ToyRobot
  class MainLoop
    class << self
      attr_accessor :game

      def setup
        @game = Game.new

        Display.output 'Hello! Welcome.'
        table_setup
      end

      def table_setup
        while @game.table.nil?
          Display.output 'Please enter a table size, or press enter for default (4x4)'
          Display.prompt
          size_input = gets.strip
          parsed_output = Parser.parse_size(size_input)

          table_creator(parsed_output)
        end
        Display.output 'Please PLACE your robot: (PLACE X,Y,FACING)'
      end

      def run
        while @game
          Display.prompt
          input = gets.strip
          game.receive_input(input)
        end
      end

      def table_creator(parsed_output)
        if parsed_output.nil?
          @game.create_table
          Display.output 'Default table (4x4) created'
        elsif parsed_output[:x] > 0 && parsed_output[:y] > 0
          @game.create_table(parsed_output)
          Display.output "#{@game.table.size[:x]}, #{@game.table.size[:y]} table created."
        else
          Display.error "Table size invalid. Try: 4,4"
        end
      end

      def exit
        abort("🤖 'I\'LL BE BACK.'")
      end
    end
  end
end


# Output: Welcome
# Output: What is your name?
# Input: Name
# Output: Hello, #name, enter a table size, or press enter for default (5x5)
# Input: Size -> Parser.parse_size
# game.create_table(parsed_size)
# Output: Table created with dimensions X by Y
#
# loop do ->
# Output: What would you like to do? (PLACE X,Y,FACING / MOVE / LEFT / RIGHT / REPORT)
# Input: input
# game.receive_input(input)
# <-



# Create a mainloop instance, maybe?
# Main loop does a call to "Parser.parse_size" to get the correct size
# Returns nil if none passed?
# gets.strip passed to Parser.parse_size
# test Setup with various inputs that way
