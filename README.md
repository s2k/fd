# fd - A simple file dumping tool

Note: It may be _too_ simple for the changed world of unicode

_fd_ reads the file _as a sequence of bytes_ and prints the file content to _STDOUT_. It does so in two columns, the left one will display the hex values of the bytes in the file, the right one will display the characters.

This means, that – in the current version – it cannot and will not cope well with multibyte unicode characters.

## Warning

This is, except for some updates to fix typos, change the license, and update the coding style the version as I created it back in 2004. It was programmed in a different world: On another operating system, using another file system (which most notably didn't have the concept of case-sensitive file names). This version originally used ISO-8859-1 as the default encoding, while it's now UTF-8. But since it reads the file byte wise, some characters will not be displayed as you would see them in a modern text editor.

## Usage

```
fd.rb [-w _number_] <em>file_name(s)</em>
```

Depending on your operating system, you may have to type a bit more...

```
ruby fd.rb [-w _number_] <em>file_name(s)</em>
```
