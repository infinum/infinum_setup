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

    def install_programs
      commands.each do |command_name, command_hash|
        next unless command_hash
        command_hash.each do |optionality, programs|
          next unless programs
          case programs
          when Hash
            programs.each do |program, command|
              case optionality
              when 'mandatory' then install_program(program, command)
              when 'optional' then install_if_agree(program, command)
              end
            end
          else
            programs.each do |program|
              case optionality
              when 'mandatory' then install_program(program, command_name)
              when 'optional' then install_if_agree(program, command_name)
              end
            end
          end
        end
      end
    end

    def commands(team = 'general')
      @commands ||=
        if InfinumSetup.dev?
          YAML.load_file("programs/#{team}.yml")
        else
          YAML.load(open("https://raw.github.com/infinum/infinum_setup/master/programs/#{team}.yml"))
        end
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
          choices = prompt.multi_select('Select programs to install', programs)
          choices.each { |choice| install_program(choice, command) }
        else
          install_program(programs.first, command)
        end
      end
    end

    def install_program(program, command)
      return if !simulate? && program_exist?(program, command)
      prompt.ok "Installing #{program}"
      case command
      when 'brew'
        execute "brew install #{program}"
      when 'cask'
        execute "brew cask install #{program}"
      when 'gem'
        execute "gem install #{program} --no-document"
      when 'npm'
        execute "npm -g install #{program}"
      else
        execute command
      end
    end

    def program_exist?(program, command)
      case command
      when 'cask'
        !`brew cask info #{program}`.include?('Not installed')
      when 'brew', 'gem'
        TTY::Which.exist?(program)
      else
        false
      end
    end
  end
end
