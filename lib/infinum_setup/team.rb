module InfinumSetup
  class Team < Base
    def call
      install_programs
    end

    def commands
      super(@options.team)
    end
  end
end
