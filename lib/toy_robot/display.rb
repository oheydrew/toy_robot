module ToyRobot
  class Display
    class << self
      def output(string)
        "🖥 : '#{string}'"
      end

      def robot(string)
        puts "🤖 : '#{string}'"
      end

      def error(string)
        puts "❗ : #{string}"
      end

      def prompt
        puts " $ "
      end
    end
  end
end