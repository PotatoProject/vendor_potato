#PRODUCT_PACKAGES += \
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
    AmberTheme \
    BlueTheme \
    CyanTheme \
    DeepOrangeTheme \
    DeepPurpleTheme \
    GreenTheme \
    IndigoTheme \
    LightBlueTheme \
    LightGreenTheme \
    LimeTheme \
    OrangeTheme \
    PinkTheme \
    PixelBaseTheme \
    PixelTheme \
    PurpleTheme \
    RedTheme \
    StockBaseTheme \
    StockFixedBaseTheme \
    StockTheme \
    YellowTheme

# Dark/BlackUI Packages
PRODUCT_PACKAGES += \
    SettingsDarkThemeOverlay \
    SystemDarkThemeOverlay \
    SystemSettingsIconTintOverlay \
    SysuiQsDarkThemeOverlay \
    GBoardDarkTheme \
    SettingsBlackThemeOverlay \
    SystemBlackThemeOverlay
