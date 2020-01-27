GET_VERSION := vendor/potato/build/tools/getversion.py
POTATO_VERNUM := $(shell $(GET_VERSION) vernum)
POTATO_DISH := $(shell $(GET_VERSION) dish)
BUILD_TYPE := $(shell $(GET_VERSION) buildtype)
POTATO_BRANDING_VERSION := $(BUILD_TYPE)
POTATO_VERSION := $(shell $(GET_VERSION) version)
ifeq ($(filter-out Official Mashed, $(BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        PotatoCenter
endif

ifneq ($(SIGNING_KEYS),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(SIGNING_KEYS)/releasekey
endif
