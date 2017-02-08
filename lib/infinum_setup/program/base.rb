module InfinumSetup
  module Program
    class Base
      include InfinumSetup::Program::Helpers
      attr_reader :name, :settings, :options, :prompt

      def initialize(name, settings, options, prompt)
        @name = name
        @settings = settings
        @options = options
        @prompt = prompt
      end

      def install
        return unless will_install?
        puts
        prompt_pre_install_comment
        return if skip_install?
        prompt_installing
        execute_command
        prompt_post_install_comment
        execute_command(post_install_command) if post_install_command
      end

      def valid_keys
        [
          :mandatory, :pre_install_comment, :post_install_comment, :type,
          :install_if_not_interactive, :post_install_command
        ]
      end

      def valid?
        settings.keys.all? { |key| valid_keys.include?(key.to_sym) }
      end

      def mandatory?
        settings['mandatory']
      end

      def install_if_not_interactive?
        settings['install_if_not_interactive']
      end

      def pre_install_comment
        settings['pre_install_comment']
      end

      def post_install_comment
        settings['post_install_comment']
      end

      def post_install_command
        settings['post_install_command']
      end

      private

      def command
        raise NotImplementedError
      end
    end
  end
end
