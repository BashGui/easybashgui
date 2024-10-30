#EBGlib=$(wildcard easybashgui_[0-9].[0-9].[0-9])
VERSION=14.0.0

#cartelle di destinazione
DESTDIR ?= ""
BINDIR = $(DESTDIR)/usr/bin
SHAREDIR = $(DESTDIR)/usr/share/easybashgui
LIBDIR = $(DESTDIR)/usr/lib/easybashgui
MANDIR = $(DESTDIR)/usr/share/man/man1
DOCDIR = $(DESTDIR)/usr/share/doc/easybashgui

#file nella build directory
BINARI = src/easybashgui src/easybashgui-debug src/easydialog-legacy
ICONE = icons/Ok.xpm icons/Attenzione.xpm
LIBRERIE = lib/easybashgui.lib lib/easybashlib
MANUALE = docs/easybashgui.1.gz
DOCUMENTAZIONE = LICENSE README.md

build:
	#we don't need to build, because all the excutable files are scripts.
	#By the way, dh_auto_build calls `make build`, so I added the "build" target

install:
	@echo Installing easybashgui v.${VERSION} ...
	@echo
	
	@echo Copying easybashgui ...
	
	#of course we don't need to create /usr/bin directory, but it is useful to prevent errors while packaging
	mkdir -p $(BINDIR)
	
	cp $(BINARI) $(BINDIR)
	chmod 755 $(BINDIR)/easybashgui $(BINDIR)/easydialog-legacy
	@echo

	@echo Creating /usr/share/easybashgui directory...
	mkdir -p $(SHAREDIR)
	@echo Copying icons ...
	cp $(ICONE) $(SHAREDIR)
	@echo

	@echo Creating /usr/lib/easybashgui directory...
	mkdir -p $(LIBDIR)
	@echo Copying easybashgui.lib and easybashlib ...
	cp $(LIBRERIE) $(LIBDIR)
	@echo

	@echo Copying easybashgui man page ...
	
	#see above for /usr/share/man/man1 directory
	mkdir -p $(MANDIR)
	
	cp $(MANUALE) $(MANDIR)
	@echo
	
	@echo Copying easybashgui documentation ...
	mkdir -p $(DOCDIR)
	cp $(DOCUMENTAZIONE) $(DOCDIR)
	@echo
	
	@echo "=> easybashgui v.${VERSION} installed."

uninstall:
	@echo Uninstalling easybashgui ...
	@echo
	
	@echo Removing easybashgui ...
	-rm $(BINDIR)/easybashgui $(BINDIR)/easybashgui-debug $(BINDIR)/easydialog-legacy
	@echo

	@echo Removing /usr/share/easybashgui directory...
	-rm -r $(SHAREDIR)
	@echo

	@echo Removing /usr/libexec/easybashgui directory...
	-rm -r /usr/libexec/easybashgui
	@echo Removing /usr/lib/easybashgui directory...
	-rm -r $(LIBDIR)
	@echo

	@echo Removing easybashgui man page ...
	-rm $(MANDIR)/easybashgui.1.gz
	@echo
	
	@echo Removing /usr/share/doc/easybashgui directory...
	-rm -r $(DOCDIR)
	@echo
	
	@echo "=> easybashgui uninstalled."
