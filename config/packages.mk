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
PRODUCT_PACKAGES += \
    PotatoFries

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

# Navbar
PRODUCT_PACKAGES += \
    GesturalNavigationOverlayLong \
    GesturalNavigationOverlayMedium

-include packages/apps/Plugins/plugins.mk
