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

### Content of program/#{team}.yml files

Example:

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/infinum/infinum_setup. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
