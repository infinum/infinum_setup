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
  end
end
