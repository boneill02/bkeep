.POSIX:

include config.mk

all:
	@echo To install, run the following:
	@echo sudo make install

clean:
	rm -f bkeep-*.tar.gz

dist:
	mkdir bkeep-$(VERSION)
	cp bkeep bkeep.1 bkeep_curses bkeep_curses.1 README.md LICENSE Makefile config.mk bkeep-$(VERSION)
	tar -cf bkeep-$(VERSION)
	gzip bkeep-$(VERSION).tar
	rm -rf bkeep-$(VERSION)

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f bkeep bkeep_curses $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/bkeep
	chmod 755 $(DESTDIR)$(PREFIX)/bin/bkeep_curses
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	mkdir -p $(DESTDIR)$(MANPREFIX)/man5
	sed "s/VERSION/$(VERSION)/g" < bkeep.1 > $(DESTDIR)$(MANPREFIX)/man1/bkeep.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/bkeep.1
	sed "s/VERSION/$(VERSION)/g" < bkeep_curses.1 > $(DESTDIR)$(MANPREFIX)/man1/bkeep_curses.1
	sed "s/VERSION/$(VERSION)/g" < bkeep_library.tsv.5 > $(DESTDIR)$(MANPREFIX)/man5/bkeep_library.tsv.5
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/bkeep_curses.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/bkeep $(DESTDIR)$(PREFIX)/bin/bkeep_curses $(DESTDIR)$(MANPREFIX)/man1/bkeep.1 $(DESTDIR)$(MANPREFIX)/man1/bkeep_curses.1 $(DESTDIR)$(MANPREFIX)/man5/bkeep_library.tsv.5

.PHONY: clean dist install uninstall
