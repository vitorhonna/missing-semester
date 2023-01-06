# LECTURE 01 - THE SHELL - EXERCISES

https://missing.csail.mit.edu/2020/course-shell/

1. For this course, you need to be using a Unix shell like Bash or ZSH. If you are on Linux or macOS, you don’t have to do anything special. If you are on Windows, you need to make sure you are not running cmd.exe or PowerShell; you can use Windows Subsystem for Linux or a Linux virtual machine to use Unix-style command-line tools. To make sure you’re running an appropriate shell, you can try the command `echo $SHELL`. If it says something like `/bin/bash` or `/usr/bin/zsh`, that means you’re running the right program.

```
$ echo $SHELL
/usr/bin/bash
```

2. Create a new directory called `missing` under `/tmp`.

```
$ mkdir /tmp/missing 
```

1. Look up the `touch` program. The `man` program is your friend.

```
$ man touch

TOUCH

NAME
       touch - change file timestamps

SYNOPSIS
       touch [OPTION]... FILE...

DESCRIPTION
       Update the access and modification times of each FILE to the current time.

       A FILE argument that does not exist is created empty, unless -c or -h is supplied.

       A FILE argument string of - is handled specially and causes touch to change the times of the file associated with standard output.

(...)
```

4. Use `touch` to create a new file called `semester` in `missing`.

```
$ touch missing/semester
$ ls missing/
semester
```

5. Write the following into that file, one line at a time:

   ``` bash
   #!/bin/sh
   curl --head --silent https://missing.csail.mit.edu
   ```

   The first line might be tricky to get working. It’s helpful to know that `#` starts a comment in Bash, and `!` has a special meaning even within double-quoted (`"`) strings. Bash treats single-quoted strings (`'`) differently: they will do the trick in this case. See the Bash quoting manual page for more information.

```
$ echo '#!/bin/sh' > missing/semester

$ cat missing/semester 
#!/bin/sh

$ echo 'curl --head --silent https://missing.csail.mit.edu' >> missing/semester

$ cat missing/semester 
#!/bin/sh
curl --head --silent https://missing.csail.mit.edu
```

6. Try to execute the file, i.e. type the path to the script (`./semester`) into your shell and press enter. Understand why it doesn’t work by consulting the output of `ls` (hint: look at the permission bits of the file).

```
$ ./missing/semester 
-bash: ./semester: Permission denied

$ ll
total 12
drwxr-xr-x  2 vitorhonna vitorhonna 4096 jan  6 14:45 ./
drwxr-x--- 26 vitorhonna vitorhonna 4096 jan  6 14:45 ../
-rw-rw-r--  1 vitorhonna vitorhonna   61 jan  6 14:46 semester
```

7. Run the command by explicitly starting the `sh` interpreter, and giving it the file `semester` as the first argument, i.e. `sh semester`. Why does this work, while `./semester` didn’t?

```
$ sh missing/semester
HTTP/2 200 
server: GitHub.com
content-type: text/html; charset=utf-8
last-modified: Sat, 31 Dec 2022 15:02:05 GMT
access-control-allow-origin: *
etag: "63b04eed-1f37"
expires: Fri, 06 Jan 2023 16:41:44 GMT
cache-control: max-age=600
x-proxy-cache: MISS
x-github-request-id: 6584:130A:B9E546:F93412:63B84CF0
accept-ranges: bytes
date: Fri, 06 Jan 2023 17:47:28 GMT
via: 1.1 varnish
age: 299
x-served-by: cache-cgh11165-CGH
x-cache: HIT
x-cache-hits: 1
x-timer: S1673027248.486906,VS0,VE2
vary: Accept-Encoding
x-fastly-request-id: 7dca1a225715c5f53b4c73ef71e1a6fc237a8954
content-length: 7991

$ ll /usr/bin/sh
lrwxrwxrwx 1 root root 4 jun  8  2022 /usr/bin/sh -> dash*

CONCLUSION: It worked because I have permission to execute (x) "sh" (and therefore run it by passing command line arguments - such as 'semester'), whereas I don't have permission to execute (x) 'semester'.
```

8. Look up the `chmod` program (e.g. use `man chmod`).

```
CHMOD

NAME
       chmod - change file mode bits

SYNOPSIS
       chmod [OPTION]... MODE[,MODE]... FILE...
       chmod [OPTION]... OCTAL-MODE FILE...
       chmod [OPTION]... --reference=RFILE FILE...

DESCRIPTION
       This  manual  page documents the GNU version of chmod.  chmod changes the file mode bits of each given file according to mode, which can be either a symbolic representation of changes to make, or an octal number representing the bit pattern for the new mode bits.

       The format of a symbolic mode is [ugoa...][[-+=][perms...]...], where perms is either zero or more letters from the set rwxXst, or a single letter from the set ugo.  Multiple symbolic modes can be given, separated by commas.

       A  combination  of  the  letters  ugoa  controls which users' access to the file will be changed: the user who owns it (u), other users in the file's group (g), other users not in the file's group (o), or all users (a).  If none of these are given, the effect is as if (a) were given, but bits that are set in the umask are not affected.

       The operator + causes the selected file mode bits to be added to the existing file mode bits of each file; - causes them to be removed; and = causes them to be added and causes unmentioned bits to be removed except that a directory's unmentioned set user and group ID bits are not affected.

       The  letters  rwxXst  select file mode bits for the affected users: read (r), write (w), execute (or search for directories) (x), execute/search only if the file is a directory or al‐     
       ready has execute permission for some user (X), set user or group ID on execution (s), restricted deletion flag or sticky bit (t).  Instead of one or more of these  letters,  you  can     
       specify  exactly one of the letters ugo: the permissions granted to the user who owns the file (u), the permissions granted to other users who are members of the file's group (g), and     
       the permissions granted to users that are in neither of the two preceding categories (o).

       A numeric mode is from one to four octal digits (0-7), derived by adding up the bits with values 4, 2, and 1.  Omitted digits are assumed to be leading zeros.  The first digit selects     
       the  set  user ID (4) and set group ID (2) and restricted deletion or sticky (1) attributes.  The second digit selects permissions for the user who owns the file: read (4), write (2),     
       and execute (1); the third selects permissions for other users in the file's group, with the same values; and the fourth for other users not in the file's group, with the same values.
```

9.  Use `chmod` to make it possible to run the command `./semester` rather than having to type `sh semester`. How does your shell know that the file is supposed to be interpreted using `sh`? See [this page](https://en.wikipedia.org/wiki/Shebang_(Unix)) on the shebang line for more information.

```
$ chmod +x missing/semester 

$ ll missing/semester 
-rwxrwxr-x 1 vitorhonna vitorhonna 61 jan  6 14:46 missing/semester*

$ ./missing/semester 
HTTP/2 200 
server: GitHub.com
(...)
```

10. Use `|` and `>` to write the “last modified” date output by `semester` into a file called `last-modified.txt` in your home directory.

```
Pipe (|) the output of 'grep' to the input of 'cut', using spaces as delimiters (-d ' ') and getting all fields starting from the second (-f 2-).
```

```
$ ./missing/semester | grep last-modified | cut -d ' ' -f 2- > missing/last-modified.txt 

$ cat missing/last-modified.txt 
Sat, 31 Dec 2022 15:02:05 GMT
```

11. Write a command that reads out your laptop battery’s power level or your desktop machine’s CPU temperature from `/sys`. Note: if you’re a macOS user, your OS doesn’t have sysfs, so you can skip this exercise.
