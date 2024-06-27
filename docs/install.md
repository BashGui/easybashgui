EasyBashGUI - installation
==========================

Simplified way to code bash made GUI frontend dialogs! - Installation document!

**IMPORTANT** there are packages ready to use at [![OBS bashgui build service](https://build.opensuse.org/projects/home:venenux:bashgui/packages/easybashgui/badge.svg?type=percent)](https://build.opensuse.org/package/show/home:venenux:bashgui/easybashgui) just visit and use with your Linux distribution package manager!

## Requirements

* Dialog backend that will act as frontend GUI:
  * Console:
    * `gum` 0.13.0+ https://github.com/charmbracelet/gum (selectable)
    * `cdialog` / `dialog` 1.2-20120230+ https://invisible-island.net/dialog (required)
    * `whiptail` 0.52+ https://pagure.io/newt (used as falback, not selectable!)
  * Graphical:
    * `yad` 0.20+ https://github.com/v1cont/yad (GTK2 branch available)
    * `gtkdialog` 0.8.3+ https://code.google.com/p/gtkdialog (limited support)
    * `kdialog` 1.0+ https://invent.kde.org/utilities/kdialog (was part of kdebin)
    * `zenity` 2.30+ https://wiki.gnome.org/Projects/Zenity (may work with 2.X)
    * `xdialog` 1.0+ http://xdialog.free.fr/ (new support for https://wdlkmpx.github.io/Xdialog/ comming)
* Interpreter runtime programs:
  * `coreutils` 8.0+ https://www.gnu.org/software/coreutils/
  * `bash` 3.0+ https://tiswww.case.edu/php/chet/bash/bashtop.html
  * `bc` 6.1+ https://www.gnu.org/software/bc/
  
## User module install

This way you will use it inside your new project "newprj" program, first download 
and decompress, later echoes the required minimal files and start your code:

This will download the EBG version 12.0.5 but you must check the last versions 
at the release page: https://github.com/BashGui/easybashgui/releases

``` bash
wget https://github.com/BashGui/easybashgui/archive/refs/tags/12.0.5.tar.gz

mkdir -p ~/Devel/newprj && tar -zxvf 12.0.5.tar.gz -C ~/Devel/newprj

cd ~/Devel/newprj && ln -s lib/easybashlib easybashlib && ln -s lib/easybashgui.lib easybashgui.lib

echo -e "source src/easybashgui\nmessage hola" > ~/Devel/newprj/newprogram

bash ~/Devel/newprj/newprogram
```

## System wide install

This way you will use it in any project by only sourced one standard line, 
because will be available for all the system:

1. Install the requirements (check first part of this document)
2. download EBG from https://github.com/BashGui/easybashgui/releases
3. extract all files, you will have a directory with `lib` and `src` dirs!
4. inside the new extracted dir `EasyBashGui` do `make install` as root!

But beware that if you assumed system wide install, the target system of your 
new script will already have installed the EBG package/programs, check paths
in next section.

### Install paths

| Component           | System wide path            | User mode path        |
| ------------------- | --------------------------- | --------------------- |
| `easybashgui`       | `$(DESTDIR)/usr/bin`        | `$(USERDIR)/` or `./` |
| `easybashgui-debug` | `$(DESTDIR)/usr/bin`        | `$(USERDIR)/` or `./` |
| `easybashgui.lib`   | `$(DESTDIR)/usr/lib/easybashgui` | `$(USERDIR)/lib/` or `./lib` |
| `easydialog-legacy` | `$(DESTDIR)/usr/bin`         |  `$(USERDIR)/`  or `./`  |
| `easybashlib`       | `$(DESTDIR)/usr/lib/easybashgui` | `$(USERDIR)/lib/` or `./lib` |
| `easybashgui.1.gz`  | `$(DESTDIR)/usr/share/man/man1` | Not necesary      |
| `icons/*xpm`        | `$(DESTDIR)/usr/share/easybashgui` | `$(USERDIR)/icons/`     |

### System wide usage vs module user usage

Just after install read full documentation [README.md](README.md), the only 
difference is the source endpoint line and the clean final line.

Explanation is on [README.md System wide usage vs module user usage](README.md#system-wide-usage-vs-module-user-usage) section.

In summary; you should get the endpoint like:

* If you installed system wide: `source easybashgui` and EBG will clean automatically
* If you are using from path: `source ./easybashgui` and last line must be `clean_temp`

And... enjoy !! :-)

## Packaging

Before read, there are already made package at [![build result](https://build.opensuse.org/projects/home:venenux:bashgui/packages/easybashgui/badge.svg?type=percent)](https://build.opensuse.org/package/show/home:venenux:bashgui/easybashgui)! you can visit and check it for starting point!

For distro maintainers EBG are a simple and easy to maintain project, 
but due it relies on backend and coreutils programs there are some 
directions:

* **Minimalist people should depends on coreutils!** we used some command 
like `wc`, `type`, `cut` and `bash` and we relies on their important features 
that `busybox` neither `dash`/`sh` can provide it!
* **backends (frontends) are not dependencies, but (c)dialog it is!**, we are 
aware that we need a backend, but `dialog` is the backend that must be placed as 
a dependency, but since not only, because `cdialog` its the best dependency!
from its own but it has fewer functionalities in itself, "dialog" is by far 
compatible with everything created since the beginning of times.
* **don't recommend any backend (frontend), it's not necessary!**, not so much 
package managers have the suggestion part like Debian, but please don't recommend 
any backend, the EBG must use the already provided one and present in your env ! 
your project that will implement EBG will manage those depends and recommends!
* **follows installation paths** the EBG does not put any file outside of the 
right place, so please don't change anything!
* **none of the requirements are build requirements!** yeah, EBG it's fully 
runtime script!

Projects that already uses EBG must depends on it, and must not depends on 
specific frontend GUI (by example, kdialog or zenity), unless will have a 
detection way or specific feature.
