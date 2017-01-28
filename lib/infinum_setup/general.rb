module InfinumSetup
  class General < Base
    def call
      prompt.ok 'Installing xcode-select'
      # `sudo xcode-select --install`
      # `sudo xcodebuild -license`

      prompt.ok 'Installing brew'
      # `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

      say_and_install('git')
      say_and_install('ack')
      say_and_install('rbenv')
      say_and_install('ruby-build')

      install_if_agree('alfred')
      install_if_agree('dropbox')
      install_if_agree('google-drive')
      install_if_agree(['flycut', 'jumpcut'])
      install_if_agree('spectacle')
      install_if_agree('slack')
      install_if_agree(['google-chrome', 'firefox'])
      install_if_agree('skype')
      install_if_agree(['atom', 'sublime-text'])
      install_if_agree('vlc')
      install_if_agree('the-unarchiver')
    end

    private

    def install_if_agree(programs)
      case programs
      when String
        return if interactive? && !prompt.yes?("Install #{programs}")
        say_and_install(programs)
      when Array
        if interactive?
          choices = prompt.multi_select 'Select programs to install', programs
          choices.each { |choice| say_and_install(choice) }
        else
          say_and_install(programs.first)
        end
      end
    end

    def say_and_install(program)
      prompt.ok "Installing #{program}"
      # `brew cask install #{program}`
    end
  end
end
