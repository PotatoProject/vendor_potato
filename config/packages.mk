# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# Themes
PRODUCT_PACKAGES += \
    SystemDarkGrayOverlay \
    SystemUIDarkGrayOverlay \
    SystemStyleOverlay \
    SystemUIStyleOverlay \
    SystemNightOverlay \
    SystemUINightOverlay

# Fries
#PRODUCT_PACKAGES += \
#    PotatoFries

# ThemePicker
PRODUCT_PACKAGES += \
    ThemePicker \
    PotatoThemesStub

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Cutout control overlays
PRODUCT_PACKAGES += \
    HideCutout \
    StatusBarStock

# Navigation overlays
PRODUCT_PACKAGES += \
    NavigationBarNoHint \
    NavigationBarMode2ButtonOverlay

# QS Color Overlay
PRODUCT_PACKAGES += \
    QsColor

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

-include vendor/potato-prebuilts/packages/apps/Lawnchair/lawnchair.mk
-include packages/apps/Plugins/plugins.mk
