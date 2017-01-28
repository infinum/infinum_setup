module InfinumSetup
  class General < Base
    def call
      install_xcode_select
      install_brew

      programs['brew']['mandatory'].each do |program|
        install_program(program, 'brew')
      end

      install_oh_my_zsh
      install_latest_ruby

      programs['cask']['optional'].each do |program|
        install_if_agree(program, 'cask')
      end
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

    def install_oh_my_zsh
      return if !simulate? && !prompt.yes?('Install OhMyZsh')
      prompt.ok 'Installing OhMyZsh'
      execute %(curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh)
    end

    def install_latest_ruby
      return if !simulate? && TTY::Which.exist?('rbenv')

      latest_ruby_version = `rbenv install --list | grep -v - | tail -1 | tr -d '[[:space:]]'`
      prompt.ok "Installing Ruby #{latest_ruby_version}"

      execute %(rbenv install #{latest_ruby_version})
      execute %(rbenv global #{latest_ruby_version})
      execute %(rbenv rehash)

      execute %(if ! grep -qs "rbenv init" ~/.bashrc; then
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
        echo 'eval "$(rbenv init -)"' >> ~/.bashrc
        eval "$(rbenv init -)"
      fi)

      execute %(if ! grep -qs "rbenv init" ~/.zshrc; then
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
        echo 'eval "$(rbenv init -)"' >> ~/.zshrc
        eval "$(rbenv init -)"
      fi)

      prompt.ok 'Updating gem system'
      execute %(gem update --system)
    end
  end
end
