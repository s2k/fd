# fd - A simple file dumping tool

## GitHub Actions

[![Main workflow: unit tests](https://github.com/s2k/fd/actions/workflows/main.yml/badge.svg)](https://github.com/s2k/fd/actions) <sup style="font-size:125%;">᛫</sup> [![CodeQL for 'fd'](https://github.com/s2k/fd/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/s2k/fd/actions/workflows/codeql-analysis.yml)

## TL;DR

`fd` reads files _as a sequence of (UTF-8) characters_ and dumps the content to _STDOUT_, thus the name `fd`. It does so in two columns, the left one will display the hex values of the bytes in the file, the right one will display the characters.

## History
 
I created this tool **back in 2004**. It was programmed in a different world: On another operating system, using another file system (which most notably didn't have the concept of case-sensitive file names). This version originally used ISO-8859-1 as the default (and only) encoding, while it now assumes UTF-8.

The early versions had it easy: Each character was assumed to use one byte in the file. This made displaying it in rows with a constant number of characters easy. Nowadays, however, a singe character may be composed of a (varying) number of bytes, making it impossible to always display the same number of characters in each row.
This is just a small aspect of how character encoding is more complicated (and more complex).


## Installation

If you're using a `Gemfile`, add this line to make the tool available in your project:

```ruby
gem 'fd'
```

Then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fd

## Usage

```
fd [-w _number_] file_name [file_name]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/s2k/fd>.

## License

The gem is available under the terms of the [MIT License](https://opensource.org/licenses/MIT).
