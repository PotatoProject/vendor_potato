ifneq ($(TARGET_NO_KERNEL),true)
ifeq ($(strip $(BOARD_KERNEL_SEPARATED_DTBO)),true)

MKDTIMG := $(HOST_OUT_EXECUTABLES)/mkdtimg$(HOST_EXECUTABLE_SUFFIX)

# Most specific paths must come first in possible_dtbo_dirs
possible_dtbo_dirs = $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/dts $(KERNEL_OUT)/arch/arm/boot/dts

define build-dtboimage-target
    $(call pretty,"Target dtbo image: $(BOARD_PREBUILT_DTBOIMAGE)")
    $(hide) for dir in $(possible_dtbo_dirs); do \
                if [ -d "$$dir" ]; then \
                    dtbo_dir="$$dir"; \
                    break; \
                fi; \
            done; \
            $(MKDTIMG) create $@ --page_size=$(BOARD_KERNEL_PAGESIZE) $$(find "$$dtbo_dir" -name '*.dtbo')
    $(hide) chmod a+r $@
endef

define build-dtboimage-target-from-cfg
    $(call pretty,"Target dtbo image from cfg: $(BOARD_PREBUILT_DTBOIMAGE)")
    $(hide) $(MKDTIMG) cfg_create $@ $(KERNEL_OUT)/$(BOARD_KERNEL_DTBO_CFG)
    $(hide) chmod a+r $@
endef

$(BOARD_PREBUILT_DTBOIMAGE): $(MKDTIMG) $(INSTALLED_KERNEL_TARGET)
	$(if $(BOARD_KERNEL_DTBO_CFG), $(build-dtboimage-target-from-cfg), $(build-dtboimage-target))

endif # BOARD_KERNEL_SEPARATED_DTBO
endif # TARGET_NO_KERNEL
