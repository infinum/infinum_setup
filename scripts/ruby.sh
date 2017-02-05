#!/usr/bin/env bash

if ! grep -qs "rbenv init" ~/.bash_profile; then
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
fi

if ! grep -qs "rbenv init" ~/.zshrc; then
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(rbenv init -)"' >> ~/.zshrc
fi

LATEST_RUBY_VERSION=`rbenv install --list | grep -v - | tail -1 | tr -d '[[:space:]]'`
echo "Installing Ruby $LATEST_RUBY_VERSION"

rbenv install $LATEST_RUBY_VERSION

echo "Setting $LATEST_RUBY_VERSION to global"
rbenv global $LATEST_RUBY_VERSION
rbenv rehash
