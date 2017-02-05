module InfinumSetup
  class Program
    VALID_KEYS = [
      :mandatory, :pre_install_comment, :post_install_comment, :type, :program, :script,
      :install_if_not_interactive, :post_install_command
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
      prompt.ok "#{name} -- Installing"
      execute_type
      prompt.say("#{name} -- #{post_install_comment}", color: :cyan) if post_install_comment
      execute(post_install_command) if post_install_command
    end

    def mandatory?
      mandatory
    end

    def install_if_not_interactive?
      install_if_not_interactive
    end

    VALID_KEYS.each do |key|
      define_method key do
        settings[key.to_s]
      end
    end

    private

    def execute_type
      case type
      when 'brew' then execute "brew install #{program}"
      when 'cask' then execute "brew cask install #{program}"
      when 'gem' then execute %(export PATH="$HOME/.rbenv/bin:$PATH";eval "$(rbenv init -)";gem install #{program} --no-document)
      when 'npm' then execute "npm -g install #{program}"
      when 'script' then execute script
      else
        raise "Unknown type #{type}"
      end
    end

    def execute(cmd)
      if options.simulate
        prompt.warn "#{name} -- #{cmd}"
      else
        prompt.warn cmd if options.verbose
        puts `#{cmd}`
      end
    end
  end
end
