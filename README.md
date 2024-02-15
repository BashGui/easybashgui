EasyBashGUI
===========

Simplified way to code bash made GUI frontend dialogs!

[![](https://img.youtube.com/vi/FEn4doXmiX0/0.jpg)](https://www.youtube.com/watch?v=FEn4doXmiX0)

## Introduction to EBG

.. there is [bashlib](https://github.com/cyberark/bash-lib) that is for the code 
itselft, well so then for the GUIs there are **EasyBashGUI** then!

**E**asy **B**ash **G**ui shortened as EBG, is a Posix compliant Bash functions 
library that aims to give unified GUI functions using frontends for dialogs boxeds 
(to the user side are frontends but from the EGB side are backends)

#### Backends environments GUI

EBG implements differents dialogs boxeds that for the user side are frontends 
but from the EGB side are backends!

You don't have to worry about what environment you are running the script in, 
as **EasyBashGUI** will handle this transparently, based on the availability of 
the backends.

* Console mode:
  * dialog
  * whiptail
* Graphical mode:
  * yad
  * gtkdialog
  * kdialog
  * zenity
  * xdialog

![](docs/easybasguidialogs.jpeg)

#### Compatibilty and runtime

EBG is coded in `bash`, and uses most of `coreutils` commands, but it may work in
any other env, `bash` is just used internally. But `coreutils` is mandatory, users
from alpine linux will be forced to install `coreutils` cos `busybox` or sucktools
does not have the required funtionality to work!

#### Backend boxes priority

EBG suppport for backend dialog boxeds depends on the runing programs, this
will be improved in future releases:

1. If all the required backends are available or at least kdialog are.. the EBG
   will try to check if kdebin is running and only will use kdialog.
2. If only GTK based are running, the EBG will just use zenity, event if xdialog
   is available and there is no desktop runing (window managers or similar.. )

## Components

EBG is fully modular:

* `easybashgui` a launcher that will be the endpoint sourcered in your scripts
* `easybashgui-debug` that toggles some debug options managed by the previus component
* `easybashgui.lib` that managed the backends, called as widget library
* `easydialog-legacy` stand-alone to create dialog boxes externally (as old nowadays)
* `easybashlib` used for for optional functions like cleaning temporally working dir

## Quick start

You can try the "use in place" method at the [docs/install.md](docs/install.md#quick-start-usage)
file.

### INSTALLATION

Please check [docs/install.md](docs/install.md) document file!

### Documentation

Please check [docs/README.md](docs/README.md) document file!

## Credits.

Thanks to Bash, Yad, Gtkdialog, Xdialog, Kdialog, Zenity, Cdialog, and Whiptail authors, this library was nothing without their work. Many thanks.
Thanks to Frank Dietermann for suggestion though to make EBG "posix compliant" (since vers. 11.X.X )
Thanks to Jose Joao Dias de Almeida for the makefile tip.
Thanks to Chris "cgat" for his many ideas and suggestions that lead to version's "5.X.X" EasyBashGUI "revolution".
Thanks to Davide Depau for his tests and support, and his effort to make EasyBashGUI Debian policy compliant, and finally for his man page.
Thanks to Christian Prause for his patience and Git support.
Thanks to Lucio Messina for "Debian policy" tips and support.
Thanks to zen0bit for first try and README impulse revival.

Please, let me know if my work has been useful for you.
Vittorio Cagnetta
vaisarger@gmail.com
https://github.com/BashGui/easybashgui

## LICENSE

GPLv3+