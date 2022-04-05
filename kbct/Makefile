.PHONY: install uninstall
DESTDIR=
PREFIX=/usr

install:
	@if [ -e $(DESTDIR)$(PREFIX)/lib/systemd/ ]; then \
		install -Dm644 kbct.service $(DESTDIR)$(PREFIX)/lib/systemd/system/kbct.service; \
	else \
		echo "NOTE: systemd not found, you will need to manually add kbct to your system's init process."; \
	fi

	wget https://github.com/samvel1024/kbct/releases/latest/download/kbct-x86_64.AppImage -O /tmp/kbct
	chmod +x /tmp/kbct

	mkdir -p $(DESTDIR)$(PREFIX)/bin/

	-groupadd kbct
	install -m755 /tmp/kbct $(DESTDIR)$(PREFIX)/bin/
	install -m755 kbct.yaml /etc/

	systemctl enable kbct
	systemctl start kbct

uninstall:
	systemctl stop kbct || echo NOTE: ignoring systemctl error
	systemctl disable kbct || echo NOTE: ignoring systemctl error
	rm -rf \
		$(DESTDIR)$(PREFIX)/lib/systemd/system/kbct.service \
		$(DESTDIR)$(PREFIX)/bin/kbct \
		/etc/kbct.yaml
	groupdel kbct || echo NOTE: ignoring group removal error
