# POSP Common packages
PRODUCT_PACKAGES += \
    Lawnchair

# PotatoCenter
ifeq ($(filter-out OFFICIAL WEEKLY MASHED, $(BUILD_TYPE)),)
PRODUCT_PACKAGES += \
    PotatoCenter
endif

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

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
    YellowTheme \
    MintGreenTheme \
    FadedPink \
    DeepRed \
    PinkRed \
    KindaIndigo \
    ArmyGreen \
    Grey

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Cutout control overlays
PRODUCT_PACKAGES += \
    HideCutout \
    StatusBarStock

# Dark/BlackUI Packages
PRODUCT_PACKAGES += \
    GBoardDarkTheme \
    SettingsDarkTheme \
    SystemDarkTheme \
    SysuiQsDarkTheme \
    SettingsBlackTheme \
    SystemBlackTheme \
    SysuiQsBlackTheme

# Lawnchair Default Configuration
PRODUCT_PACKAGES += \
    LawnConf

# Turbo
PRODUCT_PACKAGES += \
    Turbo

# Pixel packages
PRODUCT_PACKAGES += \
    SoundPickerPrebuilt \
    SettingsIntelligenceGooglePrebuilt \
    MarkupGoogle \
    MatchmakerPrebuilt

# QS Accent Packages
PRODUCT_PACKAGES += \
    QsAccentBlack \
    QsAccentWhite

# Weather
PRODUCT_PACKAGES += \
    WeatherClient
