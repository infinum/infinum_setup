module InfinumSetup
  class Install
    def initialize(options)
      @options = options
    end

    def call
      InfinumSetup::General.install(interactive?)
      case options.platform
      when :rails then InfinumSetup::Rails.install(interactive?)
      when :android then InfinumSetup::Android.install(interactive?)
      when :ios then InfinumSetup::Ios.install(interactive?)
      when :design then InfinumSetup::Design.install(interactive?)
      when :other then InfinumSetup::Other.install(interactive?)
      end
    end

    private

    attr_reader :options

    def interactive?
      options.interactive
    end
  end
end
