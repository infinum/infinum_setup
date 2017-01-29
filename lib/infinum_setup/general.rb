module InfinumSetup
  class General < Base
    def call
      install_xcode_select
      install_brew
      install_programs
    end

    private

    def install_xcode_select
      return if !simulate? && TTY::Which.exist?('xcode-select')
      prompt.ok 'Installing xcode-select'
      execute %(sudo xcode-select --install)
      execute %(sudo xcodebuild -license)
    end

    def install_brew
      return if !simulate? && TTY::Which.exist?('brew')
      prompt.ok 'Installing brew'
      execute %(/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)")
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
  end
end
