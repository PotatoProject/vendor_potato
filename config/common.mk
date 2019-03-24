include vendor/potato/config/ProductConfigQcom.mk

PRODUCT_SOONG_NAMESPACES += $(PATHMAP_SOONG_NAMESPACES)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.build.selinux=1 \
    ro.boot.vendor.overlay.theme=com.potato.overlay.accent.purple;com.potato.overlay.base.stockfixed;com.potato.overlay.lawnconf;com.potato.overlay.shape.circle \
    ro.opa.eligible_device=true \
    ro.setupwizard.rotation_locked=true

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/potato/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/potato/prebuilt/common/bin/50-base.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-base.sh \

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/potato/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/potato/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/media/bootanimation.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip \

# Common overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/potato/overlay/common

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# exFAT
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Fries
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/sysconfig/potatofries-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/potatofries-hiddenapi-package-whitelist.xml

# Lawnchair
ifeq ($(LAWNCHAIR_OPTOUT),)
PRODUCT_PACKAGE_OVERLAYS += vendor/potato/overlay/lawnchair
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-lawnchair.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-lawnchair.xml \
    vendor/potato/prebuilt/common/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml
endif

# POSP Common
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-potato.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-potato.xml \
    vendor/potato/prebuilt/common/etc/permissions/co.potatoproject.posp.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/co.potatoproject.posp.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/potato/config/permissions/custom-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/custom-power-whitelist.xml

# Set custom volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
    SELINUX_IGNORE_NEVERALLOWS := true
endif

# Branding
include vendor/potato/config/branding.mk

# GSans font
include vendor/potato/config/fonts.mk

# Packages
include vendor/potato/config/packages.mk
