module InfinumSetup
  module Program
    class Gem < Base
      def valid_keys
        super + [:program]
      end

      def command
        %(export PATH="$HOME/.rbenv/bin:$PATH";eval "$(rbenv init -)";gem install #{program} --no-document)
      end

      def program
        settings['program']
      end
    end
  end
end
