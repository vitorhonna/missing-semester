# LECTURE 02 -  SHELL SCRIPTING

https://missing.csail.mit.edu/2020/shell-tools/

## NOTES

### Strings

In shell,  double quotes `"` will parse the string, whereas single quotes `'` makes it a string literal. For example:

``` bash
$ foo=bar

$ echo $foo
bar

$ echo "foo $foo"
foo bar

$ echo 'foo $foo'
foo $foo
```

### Functions and CL Arguments

Save the following snippet in `mcd.sh`, then run `$ source mcd.sh`. The current terminal will have the defined 'mcd' function.

``` bash
# Create a new directory and move into it
mcd () {
    mkdir -p "$1"
    cd "$1"
}
```

`$1` accesses the first argument (the first after the program name, which is always `$0`).

`$?` accesses the previous execution status / error message. 0 for ok, 1 for error.

`$_` accesses the last argument from the previously-run command. For example, to create a directory and move into it:

``` bash
$ mkdir test
$ cd $_
```

In this case, `$_` contains the string "test".

`$#` total number of arguments.

`$@` all arguments.

`!!` accesses the previously-run command.

### Logical Operators

`||` OR.

`&&` AND.

### Miscellaneous

Use `;` to concatenate commands in a single line.

Use the output of a function/program: $(<function/program>). For example, `pwd` prints the current working directory. To save it to 'foo': `foo=$(pwd)`.

Using `{}` after a name and passing a list will expand it adding each item of the list to the end of the name. For example: `touch file{1,2,3}` will be run as `touch file1 file2 file3`, creating 3 files. This can also be used for paths and multiple times, for example: `project{1,2}/test{1,2}` becomes `project1/test1 project1/test2 project2/test1 project2/test2`. It can also be used for ranges, for example: `file-{a..b}` becomes `file-a file-b file-c`.

### Useful tools

`tldr` to show a simplified version of the man page, with examples.

`find` to find files/folders.

`grep` to search within files.

`cut` to manipulate strings.

## EXERCISES

1. `ls -a -lh -t --color`

2. `marco.sh`

3. `test-script.sh`
