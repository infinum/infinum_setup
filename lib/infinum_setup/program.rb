module InfinumSetup
  class Program
    VALID_KEYS = [
      :mandatory, :pre_install_comment, :post_install_comment, :type, :program, :script,
      :install_if_not_interactive
    ].freeze

    attr_reader :settings, :name, :simulate, :prompt

    def initialize(name, settings, simulate, prompt)
      @name = name
      @settings = settings
      @simulate = simulate
      @prompt = prompt
    end

    def valid?
      settings.keys.all? { |key| VALID_KEYS.include?(key.to_sym) }
    end

    def install
      prompt.ok "#{name} -- Installing"
      execute_type
      prompt.say("#{name} -- #{post_install_comment}", color: :cyan) if post_install_comment
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

    def simulate?
      simulate
    end

    def execute_type
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
        prompt.warn "#{name} -- #{cmd}"
      else
        `#{cmd}`
      end
    end
  end
end
