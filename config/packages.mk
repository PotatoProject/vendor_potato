PRODUCT_PACKAGES += \
    messaging
#    Lawnchair

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# DU Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# Accent and Base packages
PRODUCT_PACKAGES += \
    PixelTheme \
    StockTheme \
    PinkTheme \
    PixelBaseTheme \
    StockBaseTheme \
    StockFixedBaseTheme

# Dark/BlackUI Packages
PRODUCT_PACKAGES += \
    SettingsDarkThemeOverlay \
    SystemDarkThemeOverlay \
    SystemSettingsIconTintOverlay \
    SysuiQsDarkThemeOverlay \
    GBoardDarkTheme \
    SettingsBlackThemeOverlay \
    SystemBlackThemeOverlay
