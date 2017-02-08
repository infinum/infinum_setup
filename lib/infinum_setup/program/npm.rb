module InfinumSetup
  module Program
    class Npm < Base
      def valid_keys
        super + [:program]
      end

      def command
        "npm -g install #{program}"
      end

      def program
        settings['program']
      end
    end
  end
end
