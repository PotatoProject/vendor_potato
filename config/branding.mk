# PotatoCenter
ifeq ($(filter-out OFFICIAL WEEKLY MASHED, $(BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        PotatoCenter
endif

ifneq ($(SIGNING_KEYS),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(SIGNING_KEYS)/releasekey
endif

ifndef BUILD_TYPE
    BUILD_TYPE := COMMUNITY
endif

ifndef BUILD_STATE
    BUILD_STATE := UNKNOWN
endif

POTATO_DISH := croquette
POTATO_VERNUM := 3.0.0-beta+3
ifeq ($(USE_TIME_IN_NAME), true)
    ifeq ($(BUILD_TYPE), COMMUNITY)
       POTATO_VERSION := $(TARGET_PRODUCT)-$(PLATFORM_VERSION)-$(shell date -u +%Y%m%d_%H%M)
    endif
endif

ifndef POTATO_VERSION
    POTATO_VERSION := $(TARGET_PRODUCT)-$(PLATFORM_VERSION)-$(shell date -u +%Y%m%d)
endif

CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
LIST := $(shell cat vendor/potato/potato.devices)

ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
    ifeq ($(filter-out OFFICIAL WEEKLY MASHED, $(BUILD_TYPE)),)
        POTATO_VERSION := $(POTATO_VERSION).$(POTATO_DISH)-v$(POTATO_VERNUM)
        ifeq ($(BUILD_TYPE), MASHED)
          BUILD_STATE := TEST
        endif
        ifeq ($(filter-out EXPERIMENTAL EXPERIMENTS TESTING TEST, $(BUILD_STATE)),)
            POTATO_VERSION :=$(POTATO_VERSION).MASHED
            PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.potato.type=mashed
        else
            PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.potato.type=$(POTATO_DISH)
        endif
    else
        POTATO_VERSION := $(POTATO_VERSION).CHIPS-v$(POTATO_VERNUM).$(BUILD_TYPE)
    endif
else
    ifeq ($(filter-out OFFICIAL WEEKLY, $(BUILD_TYPE)),)
      $(error "Invalid BUILD_TYPE!")
    endif
    POTATO_VERSION := $(POTATO_VERSION).CHIPS-v$(POTATO_VERNUM).$(BUILD_TYPE)
endif

export POTATO_VERNUM
export POTATO_DISH

