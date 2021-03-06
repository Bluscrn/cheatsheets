# BASH
## Introduction
This is a quick reference to getting started with Bash scripting.

- [BashGuide](http://mywiki.wooledge.org/BashGuide) _(mywiki.wooledge.org)_
- [NewBashGuide](https://guide.bash.academy/) _(guide.bash.academy)_

### hashbang
The hashbang tells the kernel what interpreter it needs to use to understand the language in a file, and where to find it.

`#! /bin/bash`

This is a typical bash hashbang in a linux system, and should be the first line in a **bash script**.
### Bash Script
What's a **bash script**? It's a file with bash code in it that can be executed by the kernel just like any other program on your computer.
```bash
#! /bin/bash
echo "Hello ${USER}, I hope you are doing well"
```
### Comments
```bash
# Single line comment
```
```bash
: '
This is a
multi line
comment
'
```
### String quotes
Single quotes `''` make __*all*__ characters literal.

Double quotes `""` make __*most*__ characters literal.  The following list explains the exceptions.

Character | Purpose
--- | ---
$ | Expansion — introduces various types of expansion: Parameter expansion: `$var or ${var}`, Command substitution: `$(command)` or Arithmetic expansion `$((expression))`.
' | Backward compatibility with other shells for Command substitution
! | Negate — used to negate or reverse a test or exit status. For example: `! grep text file; exit $?`
\ | Escape — (backslash) prevents the next character from being interpreted as a special character. This works outside of quoting, inside double quotes, and generally ignored in single quotes
`* ?` | Globs -- "wildcard" characters which match parts of filenames. For example: `ls *.txt`
@ | Glob -- When ‘@’ is used and the expansion appears within double quotes, each key expands to a separate word

Expansions should **always** be double-quoted.
```bash
NAME="John"
echo "Hi $NAME"  
    > Hi John
echo 'Hi $NAME'  
    > Hi $NAME
```
## Variables
### Pre-Defined Variables
#### Environment Variables
```bash
echo "${TERM}"
    > xterm-256color
echo "${USER}"
    > john
echo "${HOME}"
    > /home/john
echo "${PATH}"
    > /usr/local/sbin:/usr/local/bin:/usr/sbin
echo "${LANG}"
    > en_US.UTF-8
```
#### Bash Variables
```bash
echo "${BASH}"
    > /bin/bash
echo "${BASH_VERSION}"
    > 5.0.17(1)-release
echo "${BASHPID}"
    > 71399
echo "${HOSTNAME}"
    > xps15
echo "${UID}"
    > 1000
```
### Defining variables
Ensure there aren't any spaces around the `=`
```bash
NAME="John Smith" 
url="https://github.com/Bluscrn/cheatsheets/blob/main/bash.md"
echo $NAME # Not recommended
    > John Smith
echo "$NAME" # Prefered method
    > John Smith
echo "${url}"
    > https://github.com/Bluscrn/cheatsheets/blob/main/bash.md
```
## Parameter Expansion
### Adding Text
```bash
NAME="John Smith"
echo "Hey ${NAME}, I added text!"
    > Hey John Smith, I added text!
echo "Go to ${url} to see how it's done."
    > Go to https://github.com/Bluscrn/cheatsheets/blob/main/bash.md to see how it's done.
```
### Slicing
`${var%pattern}` Remove the **shortest** string that matches the pattern if it's at the **end** of the value.
```bash
echo "$NAME"
    > John Smith
echo "${NAME% *}"
    > John
echo "${url}"
    > https://github.com/Bluscrn/cheatsheets/blob/main/bash.md
echo "${url%/*}"
    > https://github.com/Bluscrn/cheatsheets/blob/main
```
`${var%%pattern}` Remove the **longest** string that matches the pattern if it's at the **end** of the value.
```bash
echo "$NAME"
    > John Smith
echo "${NAME%% *}"
    > John
echo "${url}"
    > https://github.com/Bluscrn/cheatsheets/blob/main/bash.md
echo "${url%%/*}"
    > https:
```
`${var#pattern}` Remove the **shortest** string that matches the pattern if it's at the **start** of the value.
```bash
echo "$NAME"
    > John Smith
echo "${NAME#* }"
    > Smith
echo "${url}"
    > https://github.com/Bluscrn/cheatsheets/blob/main/bash.md
echo "${url#*/}"
    > /github.com/Bluscrn/cheatsheets/blob/main/bash.md
```
`${var##pattern}` Remove the **longest** string that matches the pattern if it's at the **start** of the value.
```bash
echo "${NAME##* }"
    > Smith
echo "${url##*/}"
    > bash.md
```
`${var:start[:length]}` Expand a part of the value, starting at start, length bytes long. You can even count start from the end rather than the beginning by using a space followed by a negative value.
```bash
echo "${url:8}"
    > github.com/Bluscrn/cheatsheets/blob/main/bash.md
echo "${url:8:10}"
    > github.com
echo "${url: -7}"
    > bash.md
echo "${url: -29:11}"
    > cheatsheets
```
### Substitution
`${var/pattern/replacement}` Replace the **first** string that matches the pattern with the replacement.
```bash
echo "${PATH}"
    > /usr/local/sbin:/usr/local/bin:/usr/sbin
echo "${PATH/:/, }"
    > /usr/local/sbin, /usr/local/bin:/usr/sbin
```
`${var//pattern/replacement}` Replace **each** string that matches the pattern with the replacement.
```bash
echo "${PATH}"
    > /usr/local/sbin:/usr/local/bin:/usr/sbin
echo "${PATH//:/, }"
    > /usr/local/sbin, /usr/local/bin, /usr/sbin
```
`${var/#pattern/replacement}` Replace the string that matches the pattern at the **beginning** of the value with the replacement.
```bash
echo "${url}"
    > https://github.com/Bluscrn/cheatsheets/blob/main/bash.md
echo "${url/#*:/http:}"
    > http://github.com/Bluscrn/cheatsheets/blob/main/bash.md
```
`${var/%pattern/replacement}` Replace the string that matches the pattern at the **end** of the value with the replacement.
```bash
echo "${url}"
    > https://github.com/Bluscrn/cheatsheets/blob/main/bash.md
echo "${url/%.md/.lol}"
    > https://github.com/Bluscrn/cheatsheets/blob/main/bash.lol
```
`${#var}` Expand the length of the value (in bytes).
```bash
echo "${#url}"
    > 56
```
`${var[^|^^|,|,,][pattern]}` Expand the transformed value, either upper-casing or lower-casing the first or all characters that match the pattern. You can omit the pattern to match any character.
```bash
echo "${url^}"
    > Https://github.com/Bluscrn/cheatsheets/blob/main/bash.md
echo "${url^^}"
    > HTTPS://GITHUB.COM/BLUSCRN/CHEATSHEETS/BLOB/MAIN/BASH.MD
echo "${url,}"
    > https://github.com/Bluscrn/cheatsheets/blob/main/bash.md
echo "${url,,}"
    > https://github.com/bluscrn/cheatsheets/blob/main/bash.md
```
## Command substitution

```bash
pwd
    > /home/john
echo "I'm in $(pwd)" # Preffered method
    > I'm in /home/john
echo "I'm in `pwd`" # Backward compatible with unix shells (Do Not use in bash)
    > I'm in /home/john
```
## Exit Status
Exit status is an integer between 0 and 255 (inclusive). Convention dictates that we use 0 to denote **success**, and any other number to denote failure of some sort. The specific number is entirely application-specific, and is used to hint as to what exactly went wrong. 
## Conditional execution
Bash has a few different ways of evaluating conditionals. Nearly all of them have a key commonality: they are all evaluated based on the exit code of another command.
### Control Operators
#### &&
`&&` represents a logical AND.  It tells bash to do A and then do B, **if** A succeeds.

`mkdir /home/john && cd /home/john`

If the mkdir command succeeds, we will the be put into that directory.  If the mkdir command fails, bash will skip the cd command.
#### ||
`||` is the opposite of `&&`, it represents a logical OR.  It tells bash to do A but if that fails do B instead.

`rm /home/john/made_up_filename.txt || echo "I could not remove the file."`
### The `if` compound
As soon as any branch of the if compound is executed, the remaining branches are automatically skipped.
```bash
if [[ "${USER}" = "${NAME}" ]]
then
  echo "You are ${NAME}"
  elif [[ "${USER}" = "${name}" ]]
    then echo "You are NOT ${NAME}, you are ${USER}"
else
  echo "Who are you and what do you want?"
fi
```
### [[
There are some commands designed specifically to test things and return an exit status based on what they find. The first such command is `test` AKA `[`. A more advanced version is called `[[`. `[` or test is a normal command that reads its arguments and does some checks with them. `[[` is much like `[`, but it's special (a shell keyword), and it offers far more versatility.

`[[ $filename = *.png ]] && echo "$filename looks like a PNG file"`

`[[` parses its arguments before they are expanded by Bash and does the expansion itself, taking the result as a single argument, even if that result contains whitespace. (In other words, [[ does not allow word-splitting of its arguments.) However, be aware that simple strings still have to be quoted properly. [[ treats a space outside of quotes as an argument separator, just like Bash normally would.

Also; there is a subtle difference between quoting and not quoting the right-hand side of the comparison in [[. The = operator does pattern matching by default, whenever the right-hand side is not quoted

```bash
foo=[a-z]* name=John Smith
[[ $name = $foo   ]] && echo "Name $name matches pattern $foo"
    > Name John Smith matches pattern [a-z]*
[[ $name = "$foo" ]] || echo "Name $name is not equal to the string $foo"
    > Name John Smith is not equal to the string [a-z]*
```
The first test checks whether $name matches the _pattern_ in $foo. The second test checks whether $name is equal to the _string_ in $foo. The quotes really do make that much difference -- a subtlety worth noting. 

Tests supported by `[` and `[[`:
 Test | Result
 ---|---
 -e FILE | True if file exists.
 -f FILE | True if file is a regular file.
 -d FILE | True if file is a directory.
 -h FILE | True if file is a symbolic link.
 -p PIPE | True if pipe exists.
 -r FILE | True if file is readable by you.
 -s FILE | True if file exists and is not empty.
 -t FD  | True if FD is opened on a terminal.
 -w FILE | True if the file is writable by you.
 -x FILE | True if the file is executable by you.
 -O FILE | True if the file is effectively owned by you.
 -G FILE | True if the file is effectively owned by your group.
 FILE -nt FILE | True if the first file is newer than the second.
 FILE -ot FILE | True if the first file is older than the second.
 -z STRING | True if the string is empty (it's length is zero).
 -n STRING | True if the string is not empty (it's length is not zero).

 String operators | Result
 ---|---
 STRING = STRING | True if the first string is identical to the second.
 STRING != STRING | True if the first string is not identical to the second.
 STRING < STRING | True if the first string sorts before the second.
 STRING > STRING | True if the first string sorts after the second. 
 ! EXPR | Inverts the result of the expression (logical NOT).

Numeric operators | Result
---|---
 INT -eq INT | True if both integers are identical.
 INT -ne INT | True if the integers are not identical.
 INT -lt INT | True if the first integer is less than the second.
 INT -gt INT | True if the first integer is greater than the second.
 INT -le INT | True if the first integer is less than or equal to the second.
 INT -ge INT | True if the first integer is greater than or equal to the second. 

Additional tests supported only by `[[`:
 Test | Result
 ---|---
 STRING = (or ==) PATTERN | Not string comparison like with `[`, but pattern matching is performed. True if the string matches the glob pattern.
 STRING != PATTERN | Not string comparison like with `[`, but pattern matching is performed. True if the string does not match the glob pattern.
 STRING =~ REGEX | True if the string matches the regex pattern.
 ( EXPR ) | Parentheses can be used to change the evaluation precedence.
 EXPR && EXPR | Much like the '-a' operator of test, but does not evaluate the second expression if the first already turns out to be false.
 EXPR || EXPR | Much like the '-o' operator of test, but does not evaluate the second expression if the first already turns out to be true. 

Tests exclusive to `[`:
 Test | Result
 ---|---
 EXPR -a EXPR | True if both expressions are true (logical AND).
 EXPR -o EXPR | True if either expression is true (logical OR). 

**************************************************************************
**************************************************************************
**************************************************************************
### Functions
{: id='functions-example'}

```bash
get_name() {
  echo "John"
}

echo "You are $(get_name)"
```

See: [Functions](#functions)

### Strict mode

```bash
set -euo pipefail
IFS=$'\n\t'
```

See: [Unofficial bash strict mode](http://redsymbol.net/articles/unofficial-bash-strict-mode/)

### Brace expansion

```bash
echo {A,B}.js
```

| Expression | Description         |
| ---------- | ------------------- |
| `{A,B}`    | Same as `A B`       |
| `{A,B}.js` | Same as `A.js B.js` |
| `{1..5}`   | Same as `1 2 3 4 5` |

See: [Brace expansion](http://wiki.bash-hackers.org/syntax/expansion/brace)


### Default values

| Expression        | Description                                              |
| ----------------- | -------------------------------------------------------- |
| `${FOO:-val}`     | `$FOO`, or `val` if unset (or null)                      |
| `${FOO:=val}`     | Set `$FOO` to `val` if unset (or null)                   |
| `${FOO:+val}`     | `val` if `$FOO` is set (and not null)                    |
| `${FOO:?message}` | Show error message and exit if `$FOO` is unset (or null) |

Omitting the `:` removes the (non)nullity checks, e.g. `${FOO-val}` expands to `val` if unset otherwise `$FOO`.

Loops
-----
{: .-three-column}

### Basic for loop

```bash
for i in /etc/rc.*; do
  echo $i
done
```

### C-like for loop

```bash
for ((i = 0 ; i < 100 ; i++)); do
  echo $i
done
```

### Ranges

```bash
for i in {1..5}; do
    echo "Welcome $i"
done
```

#### With step size

```bash
for i in {5..50..5}; do
    echo "Welcome $i"
done
```

### Reading lines

```bash
cat file.txt | while read line; do
  echo $line
done
```

### Forever

```bash
while true; do
  ···
done
```

Functions
---------
{: .-three-column}

### Defining functions

```bash
myfunc() {
    echo "hello $1"
}
```

```bash
# Same as above (alternate syntax)
function myfunc() {
    echo "hello $1"
}
```

```bash
myfunc "John"
```

### Returning values

```bash
myfunc() {
    local myresult='some value'
    echo $myresult
}
```

```bash
result="$(myfunc)"
```

### Raising errors

```bash
myfunc() {
  return 1
}
```

```bash
if myfunc; then
  echo "success"
else
  echo "failure"
fi
```

### Arguments

| Expression | Description                            |
| ---        | ---                                    |
| `$#`       | Number of arguments                    |
| `$*`       | All arguments                          |
| `$@`       | All arguments, starting from first     |
| `$1`       | First argument                         |
| `$_`       | Last argument of the previous command  |

See [Special parameters](http://wiki.bash-hackers.org/syntax/shellvars#special_parameters_and_shell_variables).

Conditionals
------------
{: .-three-column}

### Conditions

Note that `[[` is actually a command/program that returns either `0` (true) or `1` (false). Any program that obeys the same logic (like all base utils, such as `grep(1)` or `ping(1)`) can be used as condition, see examples.

| Condition                | Description           |
| ---                      | ---                   |
| `[[ -z STRING ]]`        | Empty string          |
| `[[ -n STRING ]]`        | Not empty string      |
| `[[ STRING == STRING ]]` | Equal                 |
| `[[ STRING != STRING ]]` | Not Equal             |
| ---                      | ---                   |
| `[[ NUM -eq NUM ]]`      | Equal                 |
| `[[ NUM -ne NUM ]]`      | Not equal             |
| `[[ NUM -lt NUM ]]`      | Less than             |
| `[[ NUM -le NUM ]]`      | Less than or equal    |
| `[[ NUM -gt NUM ]]`      | Greater than          |
| `[[ NUM -ge NUM ]]`      | Greater than or equal |
| ---                      | ---                   |
| `[[ STRING =~ STRING ]]` | Regexp                |
| ---                      | ---                   |
| `(( NUM < NUM ))`        | Numeric conditions    |

#### More conditions

| Condition            | Description              |
| -------------------- | ------------------------ |
| `[[ -o noclobber ]]` | If OPTIONNAME is enabled |
| ---                  | ---                      |
| `[[ ! EXPR ]]`       | Not                      |
| `[[ X && Y ]]`       | And                      |
| `[[ X || Y ]]`       | Or                       |

### File conditions

| Condition               | Description             |
| ---                     | ---                     |
| `[[ -e FILE ]]`         | Exists                  |
| `[[ -r FILE ]]`         | Readable                |
| `[[ -h FILE ]]`         | Symlink                 |
| `[[ -d FILE ]]`         | Directory               |
| `[[ -w FILE ]]`         | Writable                |
| `[[ -s FILE ]]`         | Size is > 0 bytes       |
| `[[ -f FILE ]]`         | File                    |
| `[[ -x FILE ]]`         | Executable              |
| ---                     | ---                     |
| `[[ FILE1 -nt FILE2 ]]` | 1 is more recent than 2 |
| `[[ FILE1 -ot FILE2 ]]` | 2 is more recent than 1 |
| `[[ FILE1 -ef FILE2 ]]` | Same files              |

### Example

```bash
# String
if [[ -z "$string" ]]; then
  echo "String is empty"
elif [[ -n "$string" ]]; then
  echo "String is not empty"
else
  echo "This never happens"
fi
```

```bash
# Combinations
if [[ X && Y ]]; then
  ...
fi
```

```bash
# Equal
if [[ "$A" == "$B" ]]
```

```bash
# Regex
if [[ "A" =~ . ]]
```

```bash
if (( $a < $b )); then
   echo "$a is smaller than $b"
fi
```

```bash
if [[ -e "file.txt" ]]; then
  echo "file exists"
fi
```

Arrays
------

### Defining arrays

```bash
Fruits=('Apple' 'Banana' 'Orange')
```

```bash
Fruits[0]="Apple"
Fruits[1]="Banana"
Fruits[2]="Orange"
```

### Working with arrays

```bash
echo ${Fruits[0]}           # Element #0
echo ${Fruits[-1]}          # Last element
echo ${Fruits[@]}           # All elements, space-separated
echo ${#Fruits[@]}          # Number of elements
echo ${#Fruits}             # String length of the 1st element
echo ${#Fruits[3]}          # String length of the Nth element
echo ${Fruits[@]:3:2}       # Range (from position 3, length 2)
echo ${!Fruits[@]}          # Keys of all elements, space-separated
```

### Operations

```bash
Fruits=("${Fruits[@]}" "Watermelon")    # Push
Fruits+=('Watermelon')                  # Also Push
Fruits=( ${Fruits[@]/Ap*/} )            # Remove by regex match
unset Fruits[2]                         # Remove one item
Fruits=("${Fruits[@]}")                 # Duplicate
Fruits=("${Fruits[@]}" "${Veggies[@]}") # Concatenate
lines=(`cat "logfile"`)                 # Read from file
```

### Iteration

```bash
for i in "${arrayName[@]}"; do
  echo $i
done
```

Dictionaries
------------
{: .-three-column}

### Defining

```bash
declare -A sounds
```

```bash
sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"
```

Declares `sound` as a Dictionary object (aka associative array).

### Working with dictionaries

```bash
echo ${sounds[dog]} # Dog's sound
echo ${sounds[@]}   # All values
echo ${!sounds[@]}  # All keys
echo ${#sounds[@]}  # Number of elements
unset sounds[dog]   # Delete dog
```

### Iteration

#### Iterate over values

```bash
for val in "${sounds[@]}"; do
  echo $val
done
```

#### Iterate over keys

```bash
for key in "${!sounds[@]}"; do
  echo $key
done
```

Options
-------

### Options

```bash
set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables
```

### Glob options

```bash
shopt -s nullglob    # Non-matching globs are removed  ('*.foo' => '')
shopt -s failglob    # Non-matching globs throw errors
shopt -s nocaseglob  # Case insensitive globs
shopt -s dotglob     # Wildcards match dotfiles ("*.sh" => ".foo.sh")
shopt -s globstar    # Allow ** for recursive matches ('lib/**/*.rb' => 'lib/a/b/c.rb')
```

Set `GLOBIGNORE` as a colon-separated list of patterns to be removed from glob
matches.

History
-------

### Commands

| Command               | Description                               |
| --------------------- | ----------------------------------------- |
| `history`             | Show history                              |
| `shopt -s histverify` | Don't execute expanded result immediately |

### Expansions

| Expression   | Description                                          |
| ------------ | ---------------------------------------------------- |
| `!$`         | Expand last parameter of most recent command         |
| `!*`         | Expand all parameters of most recent command         |
| `!-n`        | Expand `n`th most recent command                     |
| `!n`         | Expand `n`th command in history                      |
| `!<command>` | Expand most recent invocation of command `<command>` |

### Operations

| Code                 | Description                                                           |
| -------------------- | --------------------------------------------------------------------- |
| `!!`                 | Execute last command again                                            |
| `!!:s/<FROM>/<TO>/`  | Replace first occurrence of `<FROM>` to `<TO>` in most recent command |
| `!!:gs/<FROM>/<TO>/` | Replace all occurrences of `<FROM>` to `<TO>` in most recent command  |
| `!$:t`               | Expand only basename from last parameter of most recent command       |
| `!$:h`               | Expand only directory from last parameter of most recent command      |

`!!` and `!$` can be replaced with any valid expansion.

### Slices

| Code     | Description                                                                              |
| -------- | ---------------------------------------------------------------------------------------- |
| `!!:n`   | Expand only `n`th token from most recent command (command is `0`; first argument is `1`) |
| `!^`     | Expand first argument from most recent command                                           |
| `!$`     | Expand last token from most recent command                                               |
| `!!:n-m` | Expand range of tokens from most recent command                                          |
| `!!:n-$` | Expand `n`th token to last from most recent command                                      |

`!!` can be replaced with any valid expansion i.e. `!cat`, `!-2`, `!42`, etc.


Miscellaneous
-------------

### Numeric calculations

```bash
$((a + 200))      # Add 200 to $a
```

```bash
$(($RANDOM%200))  # Random number 0..199
```

### Subshells

```bash
(cd somedir; echo "I'm now in $PWD")
pwd # still in first directory
```

### Redirection

```bash
python hello.py > output.txt   # stdout to (file)
python hello.py >> output.txt  # stdout to (file), append
python hello.py 2> error.log   # stderr to (file)
python hello.py 2>&1           # stderr to stdout
python hello.py 2>/dev/null    # stderr to (null)
python hello.py &>/dev/null    # stdout and stderr to (null)
```

```bash
python hello.py < foo.txt      # feed foo.txt to stdin for python
```

### Inspecting commands

```bash
command -V cd

    > "cd is a function/alias/whatever"
```

### Trap errors

```bash
trap 'echo Error at about $LINENO' ERR
```

or

```bash
traperr() {
  echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR
```

### Case/switch

```bash
case "$1" in
  start | up)
    vagrant up
    ;;

  *)
    echo "Usage: $0 {start|stop|ssh}"
    ;;
esac
```

### Source relative

```bash
source "${0%/*}/../share/foo.sh"
```

### printf

```bash
printf "Hello %s, I'm %s" Sven Olga

    > "Hello Sven, I'm Olga

printf "1 + 1 = %d" 2

    > "1 + 1 = 2"

printf "This is how you print a float: %f" 2

    > "This is how you print a float: 2.000000"
```

### Directory of script

```bash
DIR="${0%/*}"
```

### Getting options

```bash
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -V | --version )
    echo $version
    exit
    ;;
  -s | --string )
    shift; string=$1
    ;;
  -f | --flag )
    flag=1
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi
```

### Heredoc

```sh
cat <<END
hello world
END
```

### Reading input

```bash
echo -n "Proceed? [y/n]: "
read ans
echo $ans
```

```bash
read -n 1 ans    # Just one character
```

### Special variables

| Expression | Description                  |
| ---------- | ---------------------------- |
| `$?`       | Exit status of last task     |
| `$!`       | PID of last background task  |
| `$$`       | PID of shell                 |
| `$0`       | Filename of the shell script |

See [Special parameters](http://wiki.bash-hackers.org/syntax/shellvars#special_parameters_and_shell_variables).

### Go to previous directory

```bash
pwd # /home/user/foo
cd bar/
pwd # /home/user/foo/bar
cd -
pwd # /home/user/foo
```

### Check for command's result

```bash
if ping -c 1 google.com; then
  echo "It appears you have a working internet connection"
fi
```

### Grep check

```bash
if grep -q 'foo' ~/.bash_history; then
  echo "You appear to have typed 'foo' in the past"
fi
```

## Also see
{: .-one-column}

* [Bash-hackers wiki](http://wiki.bash-hackers.org/) _(bash-hackers.org)_
* [Shell vars](http://wiki.bash-hackers.org/syntax/shellvars) _(bash-hackers.org)_
* [Learn bash in y minutes](https://learnxinyminutes.com/docs/bash/) _(learnxinyminutes.com)_
* [Bash Guide](http://mywiki.wooledge.org/BashGuide) _(mywiki.wooledge.org)_
* [ShellCheck](https://www.shellcheck.net/) _(shellcheck.net)_
