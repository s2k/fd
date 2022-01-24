# fd - A simple file dumping tool

## Badges!

[![Main workflow: unit tests](https://github.com/s2k/fd/actions/workflows/main.yml/badge.svg)](https://github.com/s2k/fd/actions) <sup style="font-size:125%;">᛫</sup> [![CodeQL for 'fd'](https://github.com/s2k/fd/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/s2k/fd/actions/workflows/codeql-analysis.yml) <sup style="font-size:125%;">᛫</sup> [![Gem Version](https://badge.fury.io/rb/fd.svg)](https://badge.fury.io/rb/fd) <sup style="font-size:125%;">᛫</sup> [![Maintainability](https://api.codeclimate.com/v1/badges/a85527d101c9ed8f581b/maintainability)](https://codeclimate.com/github/s2k/fd/maintainability)

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

You can pass _file names_ on the command line:

```
fd [-w number] [file_names]
```

For example:
```bash
> echo "Bacon ipsum dolor amet short ribs flank irure filet mignon brisket buffalo est porchetta." > some_file
> fd -w 7 some_file
some_file
42 61 63 6f 6e 20 69 |    B    a    c    o    n   __    i
70 73 75 6d 20 64 6f |    p    s    u    m   __    d    o
6c 6f 72 20 61 6d 65 |    l    o    r   __    a    m    e
74 20 73 68 6f 72 74 |    t   __    s    h    o    r    t
20 72 69 62 73 20 66 |   __    r    i    b    s   __    f
6c 61 6e 6b 20 69 72 |    l    a    n    k   __    i    r
75 72 65 20 66 69 6c |    u    r    e   __    f    i    l
65 74 20 6d 69 67 6e |    e    t   __    m    i    g    n
6f 6e 20 62 72 69 73 |    o    n   __    b    r    i    s
6b 65 74 20 62 75 66 |    k    e    t   __    b    u    f
66 61 6c 6f 20 65 73 |    f    a    l    o   __    e    s
74 20 70 6f 72 63 68 |    t   __    p    o    r    c    h
   65 74 74 61 2e 0a |         e    t    t    a    .   LF
```

You can also pipe input to STDIN:

```bash
> echo "Put something into STDIN" | be bin/fd -w 5
STDIN
50 75 74 20 73 |    P    u    t   __    s
6f 6d 65 74 68 |    o    m    e    t    h
69 6e 67 20 69 |    i    n    g   __    i
6e 74 6f 20 53 |    n    t    o   __    S
54 44 49 4e 0a |    T    D    I    N   LF
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/s2k/fd>.

## License

The gem is available under the terms of the [MIT License](https://opensource.org/licenses/MIT).
