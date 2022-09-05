# Don't dexpreopt prebuilts. (For GMS).
DONT_DEXPREOPT_PREBUILTS := true

# Include GMS, Modules, and Pixel features.
$(call inherit-product, vendor/google/gms/config.mk)
$(call inherit-product, vendor/google/pixel/config.mk)

ifneq ($(TARGET_FLATTEN_APEX), true)
$(call inherit-product-if-exists, vendor/google/modules/build/mainline_modules_t.mk)
else
$(call inherit-product-if-exists, vendor/google/modules/build/mainline_modules_t_flatten_apex.mk)
endif
