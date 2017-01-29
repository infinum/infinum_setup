# InfinumSetup

This script will help you bootstrap your shiny new laptop. If you need help please direct your questions to @stef.

If you feel there are programs missing please make a PR and I will be happy to merge it!

## Installation

Run the following script

    $ sudo gem install infinum_setup

## Usage

    $ infinum_setup

For a more advanced usage you can use:

    $ infinum_setup --interactive

This is an interactive mode where you will be asked if you want to install optional programs/packages

## Development

During setup two config files are loaded: `general.yml` and `#{team}.yml`. These files are downloaded from the master branch so I do not need to release new gem versions every time we update one of those files :)

### Content of program/#{team}.yml files

``` ruby
brew:
  mandatory:
    - imagemagick
    - node
    - mysql
    - postgresql
  optional:
cask:
  mandatory:
  optional:
    - sequel-pro
    - - flycut
      - jumpcut
    - postico
gem:
  mandatory:
  optional:
    - bundler
    - rails
command:
  mandatory:
  optional:
    pow: curl get.pow.cx | sh
```

### Top level commands

There are (for now) 5 top level commands you can use:

- brew
- cask
- gem
- npm
- command

### Optionality

Next level is the optionality of the programs. If you feel like a program must be installed put it under `mandatory` key.
If you feel like a program is a nice to have but not mandatory put it under `optional` key. If `infinum_setup` is run in interactive mode a user will be prompted for each optional program.

### Programs

For each of the top level commands except `command`, the script requires an array of programs.

``` ruby
cask:
  optional:
    - skype
    - vcl
```

You can also write an array of programs where in interactive mode the user will be prompted with a multiple select choice, and in non interactive mode the first program will be installed.

``` ruby
cask:
  optional:
    - - google-chrome
      - firefox
    - slack
```

```
Select programs to install (Use arrow keys, press Space to select and Enter to finish)
‣ ⬡ google-chrome
  ⬡ firefox
```

The `commands` programs expect a hash instead of an array. These commands will be run directly as they are written

``` ruby
command:
  mandatory:
    ruby: curl -L https://raw.github.com/infinum/infinum_setup/master/scripts/ruby.sh | sh
  optional:
    OhMyZsh: curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```

```
Installing ruby
curl -L https://raw.github.com/infinum/infinum_setup/master/scripts/ruby.sh | sh
Install OhMyZsh Yes
Installing OhMyZsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```

### Writing your own scripts

You can use `scripts` folder for writing your own scripts just as I did for ruby.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/infinum/infinum_setup. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
