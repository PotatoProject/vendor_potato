ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true)
include vendor/potato/config/ProductConfigQcom.mk
endif

PRODUCT_SOONG_NAMESPACES += $(PATHMAP_SOONG_NAMESPACES)

# Required for QTI BT Stack
ifeq ($(TARGET_USE_QTI_BT_STACK),true)
PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/commonsys/packages/apps/Bluetooth \
    vendor/qcom/opensource/commonsys/system/bt/conf
else
PRODUCT_SOONG_NAMESPACES += packages/apps/Bluetooth
endif

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

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/potato/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/potato/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Bootanimation
ifeq ($(TARGET_BOOTANIM_LOW_RES), true)
PRODUCT_COPY_FILES += \
    vendor/potato-prebuilts/bootanimation/bootanimation-half.zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/potato-prebuilts/bootanimation/bootanimation.zip:system/media/bootanimation.zip
endif

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
    persist.sys.disable_rescue=true \
    ro.opa.eligible_device=true \
    ro.setupwizard.rotation_locked=true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# POSP Common
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-potato.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-potato.xml \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-potato-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-potato-product.xml \
    vendor/potato/prebuilt/common/etc/permissions/co.potatoproject.posp.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/co.potatoproject.posp.xml \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-elgoog.xml

# Center
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-center.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-center.xml

# Fries
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-fries.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-fries.xml \
    vendor/potato/prebuilt/common/etc/sysconfig/potatofries-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/potatofries-hiddenapi-package-whitelist.xml

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml

# Set custom volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Turbo
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-turbo.xml:system/etc/permissions/privapp-permissions-turbo.xml \
    vendor/potato/prebuilt/common/etc/sysconfig/turbo.xml:system/etc/sysconfig/turbo.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/potato/config/permissions/custom-power-whitelist.xml:system/etc/sysconfig/custom-power-whitelist.xml

# Clang
ifeq ($(TARGET_USE_LATEST_CLANG),true)
    TARGET_KERNEL_CLANG_VERSION := $(shell grep -v based prebuilts/clang/host/$(HOST_OS)-x86/*/AndroidVersion.txt | sort | tail -n 1 | cut -d : -f 2)
endif

# Disable Rescue Party
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true

# exFAT
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Markup libs
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/lib/libsketchology_native.so:system/lib/libsketchology_native.so \
    vendor/potato/prebuilt/common/lib64/libsketchology_native.so:system/lib64/libsketchology_native.so

# Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/potato/overlay/common
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/potato/overlay/common

# Pixel sounds
include vendor/potato/config/sounds.mk

# Packages
include vendor/potato/config/packages.mk

# Branding
include vendor/potato/config/branding.mk
