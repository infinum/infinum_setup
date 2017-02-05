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

    $ infinum_setup --verbose

This will print out all the commands that are run

## Development

During setup two config files are loaded: `general.yml` and `#{team}.yml`. These files are downloaded from the master branch so I do not need to release new gem versions every time we update one of those files :)

### Content of program/#{team}.yml files

``` ruby
{program_name}:
  type: brew/cask/gem/npm/command
  mandatory: true/false
  install_if_not_interactive: true/false
  program: {program}
  pre_install_comment: A comment to print out before installing
  post_install_comment: A comment to print out after install
  post_install_command: eg. open the app
  script: a script to be run if type is `command`
```

### command type

There are (for now) 5 types of programs with which to install:

- brew => `brew install {program}`
- cask => `brew cask install {program}`
- gem  => `gem install {program}`
- npm  => `npm -g install {program}`
- command => `{script}`

### Mandatory

Set this setting to `true` if you feel like a program must be installed.
If `infinum_setup` is run in interactive mode a user will be prompted for each non mandatroy program.

### Install if not interactive

This will come into effect if a program is not mandatory and the `infinum_setup` is not run in interactive mode. With this setting set to `true` the program will be installed otherwise it will be skipped.

### Pre/post install comment

Comments to print out before/after installation.

### Post install command

Use this if you want to run a custom command after installation. Eg. `open /Applications/Alfred\ 3.app`

### Writing your own scripts

You can use `scripts` folder for writing your own scripts just as I did for ruby.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/infinum/infinum_setup. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
