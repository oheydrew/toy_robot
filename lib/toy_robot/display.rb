module ToyRobot
  class Display
    class << self
      def output(string)
        puts "🖥  #{string}"
      end

      def robot(string)
        puts "🤖 #{string}"
      end

      def error(string)
        puts "❗ #{string}"
      end

      def prompt
        print " $ "
      end
    end
  end
end