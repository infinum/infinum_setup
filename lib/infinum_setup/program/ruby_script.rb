module InfinumSetup
  module Program
    class RubyScript < Base
      def valid_keys
        super + [:script, :custom_install_question]
      end

      def command
        script
      end

      def execute
        eval script
      end

      def script
        if InfinumSetup.dev?
          File.read(settings['script'])
        else
          open("https://raw.github.com/infinum/infinum_setup/tree/master/#{settings['scripts']}")
        end
      end

      def custom_install_question
        settings['custom_install_question']
      end

      def install_question
        [name, custom_install_question ? custom_install_question : "Install #{name}"].join(' -- ')
      end

      def prompt_installing
        prompt.ok "#{name} -- #{custom_install_question ? 'Running' : 'Installing'}"
      end
    end
  end
end
