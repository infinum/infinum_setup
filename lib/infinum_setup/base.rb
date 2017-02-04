module InfinumSetup
  class Base
    def initialize(options)
      @options = options
    end

    def self.install(options)
      new(options).call
    end

    def call
      programs.each(&:install)
    end

    private

    attr_reader :options

    def programs(team = 'general')
      @programs ||=
        if InfinumSetup.dev?
          YAML.load_file("programs/#{team}.yml")
        else
          YAML.load(open("https://raw.github.com/infinum/infinum_setup/master/programs/#{team}.yml"))
        end.map do |name, settings|
          Program.new(name, settings, options, prompt)
        end
    end

    def prompt
      @prompt ||= TTY::Prompt.new
    end
  end
end
