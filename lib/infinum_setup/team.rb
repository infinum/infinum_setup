module InfinumSetup
  class Team < Base
    def call
      programs.each do |command_name, command_values|
        next unless command_values
        command_values['mandatory'] && command_values['mandatory'].each do |program|
          install_program(program, command_name)
        end
        command_values['optional'] && command_values['optional'].each do |program|
          install_if_agree(program, command_name)
        end
      end
    end

    def programs
      super(@options.team)
    end
  end
end
