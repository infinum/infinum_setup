module InfinumSetup
  class Team < Base
    def team_programs
      super(@options.team)
    end
  end
end
