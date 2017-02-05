module InfinumSetup
  class Base
    def initialize(options)
      @options = options
    end

    def self.install(options)
      new(options).call
    end

    def call
      programs.each do |program|
        next unless will_install?(program)
        puts
        prompt.say("#{program.name} -- #{program.pre_install_comment}", color: :cyan) if program.pre_install_comment
        next if skip_install?(program)
        program.install
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
        end.map do |name, settings|
          Program.new(name, settings, options, prompt)
        end
    end

    def will_install?(program)
      program.mandatory? ||
        (!program.mandatory? && interactive?) ||
        (!program.mandatory? && !interactive? && program.install_if_not_interactive?)
    end

    def skip_install?(program)
      !program.mandatory? &&
        interactive? &&
        !prompt.yes?("#{program.name} -- Install #{program.name}")
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
