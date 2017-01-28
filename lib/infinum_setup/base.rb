module InfinumSetup
  class Base
    def initialize(interactive)
      @interactive = interactive
    end

    def self.install(interactive)
      new(interactive).call
    end

    private

    def call
      raise NotImplemented
    end

    def interactive?
      @interactive
    end

    def prompt
      @prompt ||= TTY::Prompt.new
    end
  end
end
