.POSIX:

include config.mk

all:
	@echo To install, run the following:
	@echo sudo make install

clean:
	rm -f bkeep-*.tar.gz

dist:
	mkdir bkeep-$(VERSION)
	cp bkeep bkeep_curses bkeep.1 README.md LICENSE Makefile config.mk bkeep-$(VERSION)
	tar -cf bkeep-$(VERSION)
	gzip bkeep-$(VERSION).tar
	rm -rf bkeep-$(VERSION)

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f bkeep bkeep_curses $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/bkeep
	chmod 755 $(DESTDIR)$(PREFIX)/bin/bkeep_curses
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < bkeep.1 > $(DESTDIR)$(MANPREFIX)/man1/bkeep.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/bkeep.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/bkeep $(DESTDIR)$(PREFIX)/bin/bkeep_curses $(DESTDIR)$(MANPREFIX)/man1/bkeep.1

.PHONY: clean dist install uninstall
