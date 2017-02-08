module InfinumSetup
  class Base
    def initialize(options)
      @options = options
    end

    def self.install(options)
      new(options).call
    end

    def call
      return unless programs.is_a?(Hash)
      programs.map do |name, settings|
        program_type(settings['type']).new(name, settings, options, prompt).install
      end
    end

    private

    attr_reader :options

    def programs(team = 'general')
      @programs ||=
        if InfinumSetup.dev?
          YAML.load_file("programs/#{team}.yml")
        else
          YAML.load(
            open("https://raw.github.com/infinum/infinum_setup/master/programs/#{team}.yml")
          )
        end
    end

    def program_type(type)
      case type
      when 'brew' then Program::Brew
      when 'cask' then Program::Cask
      when 'gem' then Program::Gem
      when 'npm' then Program::Npm
      when 'script' then Program::Script
      end
    end

    def prompt
      @prompt ||= TTY::Prompt.new
    end

    def interactive?
      options.interactive
    end

    def simulate?
      options.simulate
    end
  end
end
