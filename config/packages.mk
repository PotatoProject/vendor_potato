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

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

-include vendor/potato-prebuilts/packages/apps/Lawnchair/lawnchair.mk
-include packages/apps/Plugins/plugins.mk
