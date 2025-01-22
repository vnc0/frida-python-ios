.PHONY: all update_submodule setup_codesign configure build clean help

# This depends on the target device.
# Run `python -c 'import sysconfig; print(sysconfig.get_platform())'` on your target device to find the correct value.
# To see all the values accepted by the target device, run `pip debug --verbose`.
PYTHON_TARGET_PLATFORM=macosx-11.0-iPhone13,1
FRIDA_TARGET_PLATFORM=ios-arm64
FRIDA_INSTALL_PREFIX=/usr
CERTID=frida-cert
OUT_DIR=out/

all: update_submodule setup_codesign configure build

help:
	@echo "Available targets:"
	@echo "  all              - Run all steps (default)"
	@echo "  update_submodule - Update frida-python submodule"
	@echo "  setup_codesign   - Set up macOS code signing"
	@echo "  configure        - Configure the frida-python build"
	@echo "  build            - Build frida-python wheel"
	@echo "  clean            - Remove generated files and directories"

update_submodule:
	./update_submodule.sh

setup_codesign:
	./macos-setup-codesign.sh

configure:
	cd frida-python && \
	./configure --prefix=$(FRIDA_INSTALL_PREFIX) --host=$(FRIDA_TARGET_PLATFORM)

build:
	cd frida-python && \
	_PYTHON_HOST_PLATFORM=$(PYTHON_TARGET_PLATFORM) && \
	MACOS_CERTID=$(CERTID) \
	IOS_CERTID=$(CERTID) \
	WATCHOS_CERTID=$(CERTID) \
	TVOS_CERTID=$(CERTID) \
	pip wheel -v -w ../$(OUT_DIR) --no-deps .

clean:
	rm -rf $(OUT_DIR) frida-python/build
