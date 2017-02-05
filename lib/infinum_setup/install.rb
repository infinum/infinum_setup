module InfinumSetup
  class Install
    def initialize(options)
      @options = options
    end

    def call
      # InfinumSetup::General.install(options)
      InfinumSetup::Team.install(options)
    end

    def self.select_team
      TTY::Prompt.new.select('Select your team', %w{rails javascript android ios design pm other})
    end

    private

    attr_reader :options
  end
end
