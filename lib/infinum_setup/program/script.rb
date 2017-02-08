module InfinumSetup
  module Program
    class Script < Base
      def valid_keys
        super + [:script, :custom_install_question]
      end

      def command
        script
      end

      def script
        settings['script']
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
