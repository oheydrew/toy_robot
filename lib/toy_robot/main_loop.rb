module ToyRobot
  class MainLoop
    class << self
      attr_accessor :game

      def setup
        @game = Game.new

        puts 'Hello! Welcome.'
        table_setup
      end

      def table_setup
        while @game.table.nil?
          puts 'Please enter a table size, or press enter for default (4x4)'
          size_input = gets.strip
          parsed_output = Parser.parse_size(size_input)

          if parsed_output.nil?
            @game.create_table
          elsif parsed_output[:x] > 0 && parsed_output[:y] > 0
            @game.create_table(parsed_output)
            puts "#{@game.table.size[:x]}, #{@game.table.size[:y]} table created."
          else
            puts "Table size invalid. Try: 4,4"
          end
        end
      end

      def run
        while @game do
          puts 'Input Command: '
          input = gets.strip
          game.receive_input(input)
        end
      end

      def exit
        @game = nil
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
