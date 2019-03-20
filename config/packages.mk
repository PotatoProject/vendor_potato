# Lawnchair
ifeq ($(LAWNCHAIR_OPTOUT),)
PRODUCT_PACKAGES += \
    Lawnchair
endif

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

# Oreo Settings Tiles Required Packages
PRODUCT_PACKAGES += \
    SettingsOreoTiles \
    GMSOreoTiles \
    WellbeingOreoTiles

# Settings Icon Tint
PRODUCT_PACKAGES += \
    SettingsIconTint

# Oreo QS Panel Required Packages
PRODUCT_PACKAGES += \
	OreoQSAndroidOverlay \
	OreoQSSystemUIOverlay

# Lawnchair Default Configuration
ifeq ($(LAWNCHAIR_OPTOUT),)
PRODUCT_PACKAGES += \
    LawnConf
endif

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
