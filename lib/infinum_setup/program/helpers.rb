module InfinumSetup
  module Program
    module Helpers
      def prompt_pre_install_comment
        prompt.say("#{name} -- #{pre_install_comment}", color: :cyan) if pre_install_comment
      end

      def prompt_installing
        prompt.ok "#{name} -- Installing"
      end

      def prompt_post_install_comment
        prompt.say("#{name} -- #{post_install_comment}", color: :cyan) if post_install_comment
      end

      def will_install?
        mandatory? ||
          (!mandatory? && options.interactive) ||
          (!mandatory? && !options.interactive && install_if_not_interactive?)
      end

      def skip_install?
        !mandatory? && options.interactive && !prompt.yes?(install_question)
      end

      def install_question
        "Install #{name}"
      end

      def execute_command(cmd = command)
        options.simulate ? simulate(cmd) : execute(cmd)
      end

      def simulate(cmd)
        prompt.warn "#{name} -- #{cmd}"
      end

      def execute(cmd)
        prompt.warn cmd if options.verbose
        puts `#{cmd}`
      end
    end
  end
end
