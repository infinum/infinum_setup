#!/usr/bin/env bash

LATEST_RUBY_VERSION=`rbenv install --list | grep -v - | tail -1 | tr -d '[[:space:]]'`
echo "Installing Ruby $LATEST_RUBY_VERSION"

rbenv install $LATEST_RUBY_VERSION

echo "Setting $LATEST_RUBY_VERSION to global"
rbenv global $LATEST_RUBY_VERSION
rbenv rehash

if ! grep -qs "rbenv init" ~/.bashrc; then
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  eval "$(rbenv init -)"
fi

if ! grep -qs "rbenv init" ~/.zshrc; then
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(rbenv init -)"' >> ~/.zshrc
  eval "$(rbenv init -)"
fi
