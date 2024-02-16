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
  * `bc` 6.1+ https://www.gnu.org/software/bc/
  
## Quick start usage

Install `git` and then clone the repo, later echoes the required minimal example:

``` bash
mkdir ~/Devel && cd ~/Devel

git clone https://github.com/BashGui/easybashgui ~/Devel/easybashgui

ln -s lib/easybashlib easybashlib && ln -s lib/easybashgui.lib easybashgui.lib

echo -e "source src/easybashgui\nmessage hola" > ~/Devel/easybashgui/newprogram

bash ~/Devel/easybashgui/newprogram
```

For more examples please read the full documentation [README.md](README.md)

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

Just after install read full documentation [README.md](README.md), this is a 
brief starting point to check if EBG its property installed:

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

Later just lauch it! Just remember that this example assumes you have 
installed system-wide the EBG programs.

And... enjoy !! :-)

## Packaging

For distro mantainers EBG are a simple and easy to mantain project, 
but due it relies on backend and coreutils programs there are some 
directions:

* **Minimalist people should depends on coreutils!** we used some command 
like `wc`, `type`, `cut` and `bash` and we relies on their important features 
that `busybox` neither `dash`/`sh` can provide it!
* **backends (frontends) are not dependencies, but (c)dialog it is!**, we are 
aware that we need a backend, but "dialog" is the backend that must be placed as 
a dependency, but since not only does "whiptail" depend on a library separate 
from its own but it has fewer functionalities in itself, "dialog" is by far 
compatible with everything created since the beginning of times.
* **don't recommend any backend (frontend), it's not necessary!**, not so much 
package managers have the suggestion part like Debian, but please don't recommend 
any backend, the EBG must use the already provided one and present in your env ! 
your project that will inplement EBG will manage those depends and recommends!
* **follows installation paths** the EBG does not put any file outside of the 
right place, so please dont change anything!
* **none of the requirements are build requirements!** yeah, EBG it's fully 
runtime script!

