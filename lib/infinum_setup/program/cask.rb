module InfinumSetup
  module Program
    class Cask < Base
      def valid_keys
        super + [:program]
      end

      def command
        "brew install #{program}"
      end

      def program
        settings['program']
      end
    end
  end
end
