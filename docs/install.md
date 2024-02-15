EasyBashGUI - installation
==========================

Simplified way to code bash made GUI frontend dialogs! - Installation document!

## Modes of use

You can use as system-wide module lib or as quick start module embebed!

## Requirements

* Dialog backend that will act as frontend gui:
  * Console:
    * `dialog` 1.2-20120230+ https://invisible-island.net/dialog
    * `whiptail` 0.52+ https://pagure.io/newt
  * Graphical:
    * `yad` 0.20+ https://github.com/v1cont/yad (GTK2 branch available)
    * `gtkdialog` 0.8.3+ https://code.google.com/p/gtkdialog (limited support)
    * `kdialog` 1.0+ https://invent.kde.org/utilities/kdialog (was part of kdebin)
    * `zenity` 2.30+ https://wiki.gnome.org/Projects/Zenity (may work with 2.X)
    * `xdialog` 1.0+ http://xdialog.free.fr/
* Interpreter
  * `coreutils` 8.0+ https://www.gnu.org/software/coreutils/
  * `bash` 3.0+ https://tiswww.case.edu/php/chet/bash/bashtop.html

## Quick start usage

Install `git` and then clone the repo, later echoes the required minimal example:

``` bash
mkdir ~/Devel && cd ~/Devel

git clone https://github.com/BashGui/easybashgui ~/Devel/easybashgui

ln -s lib/easybashlib easybashlib && ln -s lib/easybashgui.lib easybashgui.lib

echo -e "source src/easybashgui\nmessage hola" > ~/Devel/easybashgui/newprogram

bash ~/Devel/easybashgui/newprogram
```

![](easybasguidialogs.jpeg)


## System wide install

1. Install the requirements (check first part of this document)
2. download EBG from https://github.com/BashGui/easybashgui/releases
3. extract all files, you will have a directory with `lib` and `src` dirs!
4. inside the new extracted dir `EasyBashGui` do `make install` as root!

That's it !!!!! No matter, will install files as:

### Install paths

| Component           | Install path         |
| ------------------- | --------------------- |
| `easybashgui`       | `$(DESTDIR)/usr/bin` |
| `easybashgui-debug` | `$(DESTDIR)/usr/bin` |
| `easybashgui.lib`   | `$(DESTDIR)/usr/lib/easybashgui` |
| `easydialog-legacy` | `$(DESTDIR)/usr/bin` |
| `easybashlib`       | `$(DESTDIR)/usr/lib/easybashgui` |
| `easybashgui.1.gz`  | `$(DESTDIR)/usr/share/man/man1` |
| `icons/*xpm`        | `$(DESTDIR)/usr/share/easybashgui` |

### System wide usage

If you want use it in your scripts, simply source "easybashgui" before use...
(e.g.: "source easybashgui" ) if you installed system wide!

**IMPORTANT**: If easybashlib is present and successfully loaded, you can avoid 
to launch "clean_temp" to remove temporary files; otherwise DO NOT forget to 
write "clean_temp" at the end of all your scripts... ;-)

Firs create a file with following content:

``` bash
#!/bin/bash
source easybashgui
#
message "this"
input 1 ( "that" )
menu "this" "that"
list +"you" -"me" +"her"
clean_temp
```

Later just lauch it! Just remmembered that this example assumes you have 
installed system-wide the EBG programs.

And... enjoy !! :-)

