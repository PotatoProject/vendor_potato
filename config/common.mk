ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true)
include vendor/potato/config/ProductConfigQcom.mk
endif

PRODUCT_SOONG_NAMESPACES += $(PATHMAP_SOONG_NAMESPACES)

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/potato-prebuilts/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip

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
    ro.opa.eligible_device=true \
    ro.setupwizard.rotation_locked=true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# POSP Common
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/co.potatoproject.posp.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/co.potatoproject.posp.xml \

# Fries
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/permissions/privapp-permissions-fries.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-fries.xml \
    vendor/potato/prebuilt/common/etc/sysconfig/potatofries-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/potatofries-hiddenapi-package-whitelist.xml

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/potato/prebuilt/common/etc/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml

# Set custom volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/potato/config/permissions/custom-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/custom-power-whitelist.xml

# Enable one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# exFAT
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/potato/overlay/common
PRODUCT_ENFORCE_RRO_TARGETS += framework-res

# Pixel sounds
include vendor/potato/config/sounds.mk

# Packages
include vendor/potato/config/packages.mk

# Branding
include vendor/potato/config/branding.mk

# GMS
include vendor/potato/config/partner_gms.mk
