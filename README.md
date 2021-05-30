# fd - A simple file dumping tool

Note: It may be _too_ simple for the changed world of unicode

_fd_ prints the file content to _STDOUT_.
It does so in two columns, the left one will display the hex values
of the bytes in the file, the right one will display the characters.

## Usage

```
fd.rb [-w _number_] <em>file_name(s)</em>
```

Depending on your operating system, you may have to type a bit more...

```
ruby fd.rb [-w _number_] <em>file_name(s)</em>
```
