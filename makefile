#EBGlib=$(wildcard easybashgui_[0-9].[0-9].[0-9])
VERSION=7.1.0
EBGlib=easybashgui_${VERSION}
install:
	@echo Installing ${EBGlib} ...
	@echo
	
	@echo Copying easybashgui ...
	cp easybashgui easybashgui-debug easydialog.sh /usr/bin/
	chmod 755 /usr/bin/easybashgui /usr/bin/easydialog.sh
	@echo

	@echo Creating /usr/share/easybashgui directory...
	mkdir -p /usr/share/easybashgui
	@echo Copying Xdialog icons ...
	cp Ok.xpm Attenzione.xpm /usr/share/easybashgui/
	@echo

	@echo Creating /usr/libexec/easybashgui directory...
	mkdir -p /usr/libexec/easybashgui
	@echo Copying ${EBGlib}.lib ...
	cp ${EBGlib}.lib easybashlib /usr/libexec/easybashgui/
	@echo

	@echo Copying easybashgui man page ...
	cp easybashgui.1.gz /usr/share/man/man1/
	@echo
	
	@echo "=> ${EBGlib} installed."

uninstall:
	@echo Uninstalling ${EBGlib} ...
	@echo
	
	@echo Removing easybashgui ...
	rm /usr/bin/easybashgui /usr/bin/easybashgui-debug /usr/bin/easydialog.sh 
	@echo

	@echo Removing /usr/share/easybashgui directory...
	rm /usr/share/easybashgui/Ok.xpm /usr/share/easybashgui/Attenzione.xpm 
	rmdir /usr/share/easybashgui
	@echo

	@echo Removing /usr/libexec/easybashgui directory...
	rm /usr/libexec/easybashgui/*
	rmdir /usr/libexec/easybashgui
	@echo

	@echo Removing easybashgui man page ...
	rm /usr/share/man/man1/easybashgui.1.gz
	@echo
	
	@echo "=> easybashgui uninstalled."
