module InfinumSetup
  class Base
    def initialize(options)
      @options = options
    end

    def self.install(options)
      new(options).call
    end

    private

    def call
      raise NotImplemented
    end

    def interactive?
      @options.interactive
    end

    def simulate?
      @options.simulate
    end

    def prompt
      @prompt ||= TTY::Prompt.new
    end

    def execute(cmd)
      if simulate?
        prompt.warn cmd
      else
        `#{cmd}`
      end
    end

    def programs(team = 'general')
      @programs ||= YAML.load_file("programs/#{team}.yml")
    end

    def install_if_agree(programs, command)
      case programs
      when String
        return if interactive? && !prompt.yes?("Install #{programs}")
        install_program(programs, command)
      when Hash
        return if interactive? && !prompt.yes?("Install #{programs.keys.first}")
        install_program(programs.keys.first, programs.values.first)
      when Array
        if interactive?
          choices = prompt.multi_select('Select programs to install') do |menu|
            menu.default 1
            programs.each do |program|
              menu.choice program
            end
          end
          choices.each { |choice| install_program(choice, command) }
        else
          install_program(programs.first, command)
        end
      end
    end

    def install_program(program, command)
      return if !simulate? && TTY::Which.exist?(program)
      prompt.ok "Installing #{program}"
      case command
      when 'brew'
        execute "brew install #{program}"
      when 'cask'
        execute "brew cask install #{program}"
      when 'gem'
        execute "gem install #{program} --no-document"
      else
        execute command
      end
    end
  end
end
