SH_HOME != printf $${HOME%/}
HOME    ?= $(SH_HOME)

USER  != printf $$USER
GROUP ?= $(USER)

LOCAL_BIN = $(HOME)/.local/bin

WFMUX_SRC := src/wfmux

WFMUX_CONF_DIR = $(HOME)/.config/wfmux
WFMUX_CONF     = docs/wfmux.conf

PLUGINS    != ls plugins/*
PLUGIN_DIR  = $(WFMUX_CONF_DIR)/plugins

WATCHERS = docs/watchers

VERSION != printf $${WFMUX_VERSION:-0.1}

install:
	install -d $(LOCAL_BIN)
	install -d $(PLUGIN_DIR)
	install -m 744 -o $(USER) -g $(GROUP) $(WFMUX_SRC)  $(LOCAL_BIN)
	install -m 644 -o $(USER) -g $(GROUP) $(WFMUX_CONF) $(WFMUX_CONF_DIR)
	install -m 644 -o $(USER) -g $(GROUP) $(WATCHERS)   $(WFMUX_CONF_DIR)
	install -m 644 -o $(USER) -g $(GROUP) -t $(PLUGIN_DIR) $(PLUGINS)

uninstall:
	rm -rf $(LOCAL_BIN)/wfmux

clean:
	rm -rf wfmux-$(VERSION).tar.gz

dist: clean
	mkdir -p wfmux-$(VERSION)
	cp -R LICENSE Makefile README.md src docs plugins wfmux-$(VERSION)
	tar -cf wfmux-$(VERSION).tar wfmux-$(VERSION)
	gzip wfmux-$(VERSION).tar
	rm -rf wfmux-$(VERSION)
