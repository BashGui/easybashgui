EasyBashGUI - documentation
===========================

Simplified way to code bash made GUI frontend dialogs! - Documentation

## Modes of use

You can use as system-wide module lib or as built-in quick start module embedded!

## Installation

Please check [install.md](install.md) document file for any way of installation,
or just check next section for a more easy and modular way of usage:

## Quick start usage

Let's assume you have the EBG installed on system-wide, then there 
are only few steps :

```bash
mkdir ~/Devel/newprj && cd ~/Devel/newprj

echo -e "source easybashgui\nmessage hola" > ~/Devel/easybashgui/newprogram

bash ~/Devel/easybashgui/newprogram
```

That's it !!!!! Easyle! But what if you wants all build-in!? Without install?, 
of course you can! Check next section:

## Quick developer usage

But what if we want everything to be within our project, as developers or 
embedding the EBG?, to make our program independent of the installation:

```bash
mkdir ~/Devel && cd ~/Devel && git clone https://github.com/BashGui/easybashgui

cd ~/Devel/easybashgui

ln -s lib/easybashlib easybashlib && ln -s lib/easybashgui.lib easybashgui.lib

echo -e "source src/easybashgui\nmessage hola" > ~/Devel/easybashgui/newprogram

bash ~/Devel/easybashgui/newprogram
```

That's it !!!!! You develop your first GUI script!

## The EBG script

The script that will implement the EBG is always structured in three main parts:

1. The optional `supermode` varialbe and the mandatory sourced endpoint
2. The source code made by yourselft that must be `bash` language
3. The optional `clean_temp` sentence for user mode only

```bash
#!/bin/bash
# part 1 environment variables and endpoint
export supermode="zenity"
source /path/easybashgui
# part 2 .. code here
message "hola"
# part 3 the finally sentences or output manipulation
echo $?
clean_temp
```

The most simple example of a EBG script is:

```bash
source ./easybashgui

message "hola"
```

## EBG library

EBG is fully modular, you create a new script and just sourcered the endpoint:

* `easybashgui` a launcher that will be the endpoint sourcered in your scripts
* `easybashgui-debug` that toggles some debug options managed by the previus component
* `easybashgui.lib` that managed the backends, called as widget library
* `easydialog-legacy` stand-alone to create dialog boxes externally (as old nowadays)
* `easybashlib` used for for optional functions like cleaning temporally working dir

### System wide usage vs module user usage

If EBG is not installed you should have at least all the files in the same path
as your main script, if you install it on the system you don't have to worry
about this!

A program/project that implements EBG and does not use same path from main script, 
can put the EBG script and files in another path, but structure must be in the same 
[hierarchy indicated in the installation guide "Install path" section.](install.md#install-paths) 

The USER way must have full path to the endpoint or the files must be in the
same path of the script you made:

```bash
#!/bin/bash
source ./easybashgui
# .. code here
clean_temp
```

The SYSTEM way just need endpoint without path and the files must be in system
paths, the script you made should look like:

```bash
#!/bin/bash
source easybashgui
# .. code here
```

The difference in modes is just two: first you noted that source endpoint does 
not have a path (in the USER mode is "`./`") and second the SYSTEM mode does not 
need to clean temporally files (in the USER mode is `clean_temp`).

If easybashlib is present and successfully loaded, you can avoid last sentence 
of `clean_temp` to remove temporary files; otherwise DO NOT forget to
write `clean_temp` at the end of all your scripts... ;-)

#### Backend boxes priority

EBG support for backend boxed dialogs depends on the running programs:

1. If all the required backends are available or at least kdialog are.. the EBG
   will try to check if kdebin is running and only will use kdialog.
2. If only GTK based are running, the EBG will just use yad (or zenity ), even if xdialog
   is available and there is no desktop managers running (only window managers or similar.. )

![](easybasguidialogs.jpeg)

#### Box mode windows

The backend window can be forced using the `supermode` environment variable to
the program backend of choice:

```bash
export supermode="kdialog"

source easybashgui

message "hola"
```

![](easybasguidialogs.jpeg)

#### Size box windows

All windows functions support options `<-w|-width> [integer]` and `<-h|-height> [integer]` 
for custom window size with exception of `notify_message` and earlier versions 
of kdialog !

```bash
source easybashgui

message -w 800 -h 100 "Hello World!"
```

![](easybashgui-example0.jpeg)

#### Input and output

EBG always use STDIN and STDOUT in conjuction with a temporary directory/filename.

The temporary names are managed throught the variables `${dir_tmp}` and `${file_tmp}`

#### Functions list features

TODO: this section is WIP

```
question -> "[text]"                 =>       ( 1 argument, box output to exit code and STDERR ) (*)
message -> "[text]"                  =>       ( 1 argument )
alert_message -> "[text]"            =>       ( 1 argument )
ok_message -> "[text]"               =>       ( 1 argument )
notify_message -> <-i "[icon]"> "[text]" =>   ( 1 option, 1 argument )
text                                 =>       ( STDIN, NO argument, box output to "${dir_tmp}/${file_tmp}" and STDERR ) (^)
wait_seconds -> "[integer]"          =>       ( 1 argument )
wait_for -> "[text]"                 =>       ( 1 argument, PID to kill to "wait_for__PID" variable and STDERR ) (@)
terminate_wait_for                   =>       ( 1 argument only in easydialog, otherwise, NO argument ) (@)
fselect -> "<init. dir.>"            =>       ( 1 <optional> argument, box output to "${dir_tmp}/${file_tmp}" and STDERR ) (#)
dselect -> "<init. dir.>"            =>       ( 1 <optional> argument, box output to "${dir_tmp}/${file_tmp}" and STDERR ) (#)
input -> 1 "<label 1>" "[init 1]"    =>       ( 2-3 arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR )
input -> 2 "[label 1]" "[init 1]" "[label 2]" "[init 2]"                     => ( 5 arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR )
input -> 3 "[label 1]" "[init 1]" "[label 2]" "[init 2]" "[label 3]" "[init 3]" => ( 7 arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR )
menu -> "[item 1]" ... "[item n]"    =>       ( [n] arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR ) (%)
tagged_menu -> "[item 1]" "[tag 1]" ... "[item n]" "[tag n]"    =>       ( [n*2] arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR ) (%)
list -> <+|->"[item 1]" ... <+|->"[item n]"    =>       ( [n] arguments, optionally prefixed by "+"(plus) or "-"(minus), box output to "${dir_tmp}/${file_tmp}" and STDERR ) (%)
progress -> "[text]"                         =>       ( percent with or without '%' in STDIN, 1 argument )
progress -> "[text]" "[elements number]"     =>       ( "PROGRESS" string in STDIN, 2 arguments )
adjust -> "[text]" "[min]" "[init]" "[max]" => ( 4 arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR )
notify -> <-c "[click command (for mouse left button)]"> <-i "[icon_good]#[icon_bad]"> <-t "[tooltip_good]#[tooltip_bad]"> "[menu item 1]" "[menu command 1]" ... "[menu item n]" "[menu command n]"		=>       ( 3 options, [n*2] mandatory arguments )
notify_change -> <-i "[new icon]"> <-t "[new tooltip]"> "[good|bad]"		=>      ( 2 options, 1 mandatory argument )

(*) = "0" exit status is "YES", "1" exit status is "NOT", other exit codes you should make program exit : normally in a script you have just to check exit status to know user choice ;
(^) = text function write text in STDIN to file "${dir_tmp}/${file_tmp}" and (only) for kdialog, zenity, and Xdialog you can also edit text to write ;
(@) = "wait_for" function create a window with a text and returns control to main program... after a job, you can close the window throught function "terminate_wait_for" ( needs no argument ) ;
(#) = take care that if you are in "console mode" or without X, throught cdialog, selection is done by SPACE key, and NOT by enter key : remember it ;
(%) = "menu" and "list" functions differ about choices: menu allows single choice, list allows multiple choice ; since 7.1.0 version you can use tagged_menu(): it outputs tags (e.g.: "tagged_menu 1 A 2 B" -> if user selects tag "A" then function outputs item "1" );
```

## Examples

You must made the scripts in `bash` language, EBG is coded in `bash`, in this document 
we will use bash to ilustrate example usages:

1. install EBG or source the minimum 3 files
2. crate your new program script 
3. source the main endpoint of EBG (check following examples)
4. saves and launch the new script program

#### questions

This piece of code will lauch 3 dialogs, the first is the main question with a 
default "ok" button for positive answer, in limited backend boxes wil only show 
a unique "ok" button and for cancel you just press "ESC" key..

```bash
question "Do you like Contry music ?"
answer="${?}"
if [ ${answer} -eq 0 ]
then
ok_message "You do like it :)"
elif [ ${answer} -eq 1 ]
then
alert_message "You don't like it :("
else
ok_message "See you"
exit 0
fi
```

#### Simple text box from standar input

This piece of code will lauch a text box inside a window but using pipes 
to parsed to stdin and the `text` function:

```bash
echo -e "What's your name?\n\nMy name's:\nVittorio" | text
```

![](easybashgui-example1.jpeg)

#### waiting for response

This piece of code will lauch 2 dialogs, the first is text box with a 
default "ok" button for positive answer, in limited backend boxes wil only show 
a unique "ok" button and for cancel you just press "ESC" key..

Second box is a wait reponse with default progress bar, after 4 seconds will quit

```bash
wait_for "I'm sleeping 4 seconds... good night..."
sleep 4
terminate_wait_for
```

#### input examples and directory selection

This piece of code will lauch 4 dialogs, the first one will let user to choose 
a full path file with directory choose dialog.

The seconds ones are double check of same question, with default "ok" button 
for positive answer, in limited backend boxes wil only show a unique "ok" button 
and for cancel you just press "ESC" key.. but in any part of the execution 
the cancel will end all the program.

Last box is the extra second input, then the script will store all the variables 
and will show in standar output!


```bash
fselect
file="$(0< "${dir_tmp}/${file_tmp}" )"

input 1 "(write here IP address)"
input 1 "Please, write IP address" "192.168.1.1"
input 3 "Username" "root" "IP address" "192.168.0.1" "Destination directory" "/tmp"
IFS=$'\n' ; choices=( $(0< "${dir_tmp}/${file_tmp}" ) ) ; IFS=$' \t\n'
user="${choices[0]}"
ip="${choices[1]}"
dir="${choices[2]}"
```

[![](https://img.youtube.com/vi/FEn4doXmiX0/0.jpg)](https://www.youtube.com/watch?v=FEn4doXmiX0)

#### progress bar (by percent)

```bash
for i in 10 20 30 40 50 60 70 80 90 100
do
echo "${i}"
sleep 2
done | progress "This is a test progress..."
```

#### level meter

```bash
adjust "Please, set Volume level" 15 40 75
```

#### choose items (only one)

```bash
menu "Red" "Yellow" "Green"
choice="$(0< "${dir_tmp}/${file_tmp}" )"
```

#### choose items (one or more)

```bash
list "+Red" "-Yellow" "+Green"
choice_list="$(0< "${dir_tmp}/${file_tmp}" )"
IFS=$'\n' ; choice_array=( $(0< "${dir_tmp}/${file_tmp}" ) ) ; IFS=$' \t\n'
```


#### progress bar (by elements)

```bash
women=( Angela Carla Michelle Noemi Urma Marisa Karina Anita Josephine Rachel )
for (( index=0 ; index < ${#women[@]} ; index++ })) 
do
today_prefered_woman="${women[${index}]}"
kiss "${today_prefered_woman}"
sleep 1
#
# Job done !!
# then...
echo "PROGRESS"
#
done | progress "This is a _LOVE_ progress..." "${#women[@]}"

# if you use "PROGRESS" string in STDIN do not forget *second* argument ( "[elements number]" )
```

#### notify example with yad as backend

```bash
notify -t "Good tooltip:OK#Bad tooltip:BAD" -i "/usr/local/share/pixmaps/nm-signal-100.png#gtk-fullscreen" "Xclock" "xclock" "Xcalc" "xcalc"
#
while :
do
menu GOOD BAD
answer=$(0< "${dir_tmp}/${file_tmp}" )
#
if [ "${answer}" = "GOOD" ]
then
notify_message "Changed in \"good\" ..."
notify_change "good"
elif [ "${answer}" = "BAD" ]
then
notify_message "Changed in \"bad\" ..."
notify_change -i "gtk-help" -t "This tooltip is bad" "bad"
else
exit
fi
#
done
```

( For the old "easydialog-legacy" examples, you would launch it simply with "-h" option )

Note on console mode.

EasyBashGUI doesn't work with original "dialog" ( old one ) that is very limited; if you have first version "dialog" in your box, install "cdialog" and alias or link "dialog" to cdialog. No problem in case you have at least "whiptail" installed: since version 4.0.0, EasyBashGUI is able to use it instead of (c)dialog.
Since 5.0.0 version you can use EasyBashGUI even if NO WIDGET is installed (that is: no gtkdialog, no kdialog, no zenity, no Xdialog, no (c)dialog, no whiptail... doh!!!!! ). To use "super bare" EBG, simply remove the ".lib" library from your path, or set "supermode" var to "none" before easybashgui sourcing (e.g.: >export supermode="none" && source easybashgui && message "Hello world..." )

Note on gtkdialog mode.

EasyBashGUI sets gtkdialog output statements as variables through "eval". This way, in theory, could be possibly dangerous; nevertheless, so far, I don't know about any alternative way...

Note on Git.
Since 8.0.0 version, project is housed at github ( https://github.com/BashGui ). Thanks, Github people! :)

