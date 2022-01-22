# fd - A simple file dumping tool

## GitHub Actions

[![Main workflow: unit tests](https://github.com/s2k/fd/actions/workflows/main.yml/badge.svg)](https://github.com/s2k/fd/actions) <sup style="font-size:125%;">᛫</sup> [![CodeQL for 'fd'](https://github.com/s2k/fd/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/s2k/fd/actions/workflows/codeql-analysis.yml)

## TL;DR

`fd` reads the file _as a sequence of bytes_ and dumps the file content to _STDOUT_, thus the name `fd`. It does so in two columns, the left one will display the hex values of the bytes in the file, the right one will display the characters.

## Warning

This is, essentially, the same version I created **back in 2004**. It was programmed in a different world: On another operating system, using another file system (which most notably didn't have the concept of case-sensitive file names). This version originally used ISO-8859-1 as the default encoding, while it's now UTF-8. But since it reads the file byte wise, some characters will not be displayed as you would see them in a modern text editor.

In other words: It's a work in progress.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fd'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fd


## Usage

```
fd.rb [-w _number_] <em>file_name(s)</em>
```

Depending on your operating system, you may have to type a bit more...

```
ruby fd.rb [-w _number_] file_name(s)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/s2k/fd>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
