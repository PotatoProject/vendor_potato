ifeq ($(WITH_GMS),true)
    $(call inherit-product, vendor/google/gms/gms-vendor.mk)
    $(call inherit-product-if-exists, vendor/partner_modules/build/mainline_modules.mk)
endif
