V=20241017

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 devkitpro.gpg devkitpro-trusted devkitpro-revoked $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/devkitpro{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=devkitpro-keyring-$(V)/ $(V) | gzip -9 > devkitpro-keyring-$(V).tar.gz
	gpg --detach-sign --use-agent devkitro-keyring-$(V).tar.gz

upload:
	# scp devkitpro-keyring-$(V).tar.gz devkitpro-keyring-$(V).tar.gz.sig nymeria.archlinux.org:/srv/ftp/other/archlinux-keyring/

.PHONY: install uninstall dist upload
