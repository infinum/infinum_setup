module InfinumSetup
  class Program
    VALID_KEYS = [
      :mandatory, :pre_install_comment, :post_install_comment, :type, :program, :script,
      :install_if_not_interactive
    ].freeze

    attr_reader :settings, :name, :options, :prompt

    def initialize(name, settings, options, prompt)
      @name = name
      @settings = settings
      @options = options
      @prompt = prompt
    end

    def valid?
      settings.keys.all? { |key| VALID_KEYS.include?(key.to_sym) }
    end

    def install
      prompt.say(pre_install_comment, color: :cyan)
      mandatory? ? install_program : install_if_agree
      prompt.say(post_install_comment, color: :cyan)
    end

    private

    VALID_KEYS.each do |key|
      define_method key do
        settings[key.to_s]
      end
    end

    def mandatory?
      mandatory
    end

    def install_if_not_interactive?
      install_if_not_interactive
    end

    def install_if_agree
      return if !interactive? && !install_if_not_interactive?
      return if interactive? && !prompt.yes?("Install #{name}")
      install_program
    end

    def install_program
      prompt.ok "Installing #{name}"
      case type
      when 'brew' then execute "brew install #{program}"
      when 'cask' then execute "brew cask install #{program}"
      when 'gem' then execute "gem install #{program} --no-document"
      when 'npm' then execute "npm -g install #{program}"
      when 'script' then execute script
      else
        raise "Unknown type #{type}"
      end
    end

    def execute(cmd)
      if simulate?
        prompt.warn cmd
      else
        `#{cmd}`
      end
    end

    def interactive?
      options.interactive
    end

    def simulate?
      options.simulate
    end
  end
end
