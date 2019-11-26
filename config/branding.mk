POTATO_VERNUM = 3.0.0-beta+3
POTATO_DISH = croquette

ifndef BUILD_TYPE
    BUILD_TYPE := COMMUNITY
endif

ifneq ($(SIGNING_KEYS),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(SIGNING_KEYS)/releasekey
endif

CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
LIST := $(shell cat vendor/potato/potato.devices)

ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
    ifeq ($(filter-out OFFICIAL MASHED, $(BUILD_TYPE)),)
        ifeq ($(BUILD_TYPE), OFFICIAL)
          BUILD_TYPE := OFFICIAL
        endif
        ifeq ($(BUILD_TYPE), MASHED)
          BUILD_TYPE := MASHED
        endif
    endif
else
    ifeq ($(filter-out OFFICIAL MASHED, $(BUILD_TYPE)),)
      $(error "Invalid BUILD_TYPE!")
    endif
endif

ifeq ($(filter-out OFFICIAL MASHED, $(BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        PotatoCenter
endif

POTATO_VERSION := $(TARGET_PRODUCT)-$(PLATFORM_VERSION)-$(shell date -u +%Y%m%d)-$(POTATO_DISH).v$(POTATO_VERNUM).$(BUILD_TYPE)

POTATO_BRANDING_VERSION := $(BUILD_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.potato.version=$(POTATO_VERSION) \
  ro.potato.buildtype=$(BUILD_TYPE) \
  ro.potato.vernum=$(POTATO_VERNUM) \
  ro.potato.dish=$(POTATO_DISH) \
  ro.potato.branding.version=$(POTATO_BRANDING_VERSION)
