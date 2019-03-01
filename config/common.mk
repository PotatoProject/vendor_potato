PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/potato/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/potato/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip \

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1 \
    ro.boot.vendor.overlay.theme=com.potato.overlay.accent.purple;com.potato.overlay.base.stockfixed;com.potato.overlay.lawnconf \
    ro.opa.eligible_device=true

ifndef BUILD_TYPE
    BUILD_TYPE := COMMUNITY
endif

ifndef BUILD_STATE
    BUILD_STATE := UNKNOWN
endif

POTATO_DISH := Baked
POTATO_VERNUM := 2.1
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
    ifeq ($(filter-out OFFICIAL WEEKLY, $(BUILD_TYPE)),)
        POTATO_VERSION := $(POTATO_VERSION).$(POTATO_DISH)-v$(POTATO_VERNUM)
        ifeq ($(filter-out EXPERIMENTAL EXPERIMENTS TESTING TEST, $(BUILD_STATE)),)
            POTATO_VERSION :=$(POTATO_VERSION).MASHED
        else
            ifeq ($(BUILD_TYPE), WEEKLY)
              POTATO_VERSION :=$(POTATO_VERSION).WEEKLY
              PRODUCT_PROPERTY_OVERRIDES += ro.potato.type=weekly
            endif
        endif
    else
        POTATO_VERSION := $(POTATO_VERSION).CHIPS-v$(POTATO_VERNUM).$(BUILD_TYPE)
    endif
else
    POTATO_VERSION := $(POTATO_VERSION).CHIPS-v$(POTATO_VERNUM).$(BUILD_TYPE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.potato.dish=$(POTATO_DISH) \
    ro.potato.version=$(POTATO_VERNUM)

# LatinIME gesture typing
ifneq ($(filter tenderloin,$(TARGET_PRODUCT)),)
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/potato/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/potato/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
endif
endif

# Lawnchair
PRODUCT_PACKAGES += Lawnchair
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-lawnchair.xml:system/etc/permissions/privapp-permissions-lawnchair.xml \
    vendor/potato/prebuilt/common/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml:system/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Clean up packages cache to avoid wrong strings and resources
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/potato/overlay/common

# Weather client
PRODUCT_COPY_FILES += \
    vendor/potato/etc/permissions/org.pixelexperience.weather.client.xml:system/etc/permissions/org.pixelexperience.weather.client.xml \
    vendor/potato/etc/default-permissions/org.pixelexperience.weather.client.xml:system/etc/default-permissions/org.pixelexperience.weather.client.xml

# Packages
include vendor/potato/config/packages.mk

# Set custom volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Disable Rescue Party
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Few Packages from Pixel
PRODUCT_PACKAGES += \
    SoundPickerPrebuilt \
    SettingsIntelligenceGooglePrebuilt \
    MarkupGoogle \
    MatchmakerPrebuilt

# Markup libs
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/lib/libsketchology_native.so:system/lib/libsketchology_native.so \
    vendor/potato/prebuilt/common/lib64/libsketchology_native.so:system/lib64/libsketchology_native.so

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
    SELINUX_IGNORE_NEVERALLOWS := true
endif
