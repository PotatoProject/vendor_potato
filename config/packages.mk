# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

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

# ThemesStub
PRODUCT_PACKAGES += \
    PotatoThemesStub

# Navigation overlays
PRODUCT_PACKAGES += \
    NavigationBarNoHint \
    NavigationBarMode2ButtonOverlay

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

-include vendor/potato-prebuilts/packages/apps/Lawnchair/lawnchair.mk
-include packages/apps/Plugins/plugins.mk
