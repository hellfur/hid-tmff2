KERNEL_VERSION ?= $(shell uname -r)
KDIR ?= /lib/modules/$(KERNEL_VERSION)/build

all: deps/hid-tminit
	$(MAKE) -C $(KDIR) M=$(shell pwd) modules

install: deps/hid-tminit
	$(MAKE) -C $(KDIR) M=$(shell pwd) modules_install
	depmod -A $(KERNEL_VERSION)

.PHONY: udev-rules
udev-rules:
	install -m 0644 udev/99-thrustmaster.rules /etc/udev/rules.d/

clean: deps/hid-tminit
	$(MAKE) -C $(KDIR) M=$(shell pwd) clean


.PHONY: deps/hid-tminit
deps/hid-tminit:
	$(MAKE) -C deps/hid-tminit KDIR="$(KDIR)" $(MAKECMDGOALS)
