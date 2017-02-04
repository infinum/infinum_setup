module InfinumSetup
  class Team < Base
    def programs
      super(@options.team)
    end
  end
end
