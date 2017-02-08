module InfinumSetup
  class Base
    def initialize(options = {})
      @options = options
    end

    def self.install(options)
      new(options).call
    end

    def call
      return unless team_programs.is_a?(Hash)
      programs.map(&:install)
    end

    def programs
      @programs ||= team_programs.map do |name, settings|
        program_type(settings['type'], name).new(name, settings, options)
      end
    end

    def team_programs(team = 'general')
      if InfinumSetup.dev?
        YAML.load_file("programs/#{team}.yml")
      else
        YAML.load(
          open("https://raw.github.com/infinum/infinum_setup/master/programs/#{team}.yml")
        )
      end
    end

    private

    attr_reader :options

    def program_type(type, name)
      case type
      when 'brew' then Program::Brew
      when 'cask' then Program::Cask
      when 'gem' then Program::Gem
      when 'npm' then Program::Npm
      when 'script' then Program::Script
      when 'ruby_script' then Program::RubyScript
      else
        raise "#{name} -- Type #{type} not recognized"
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
