# Bring in Qualcomm helper macros
include vendor/potato/build/core/qcom_utils.mk

# Platform names
KONA := kona #SM8250
LITO := lito #SM7250
BENGAL := bengal #SM6115
MSMNILE := msmnile #SM8150
MSMSTEPPE := sm6150
TRINKET := trinket #SM6125
ATOLL := atoll #SM6250
LAHAINA := lahaina #SM8350

B_FAMILY := msm8226 msm8610 msm8974
B64_FAMILY := msm8992 msm8994
BR_FAMILY := msm8909 msm8916
UM_3_18_FAMILY := msm8937 msm8953 msm8996
UM_4_4_FAMILY := msm8998 sdm660
UM_4_9_FAMILY := sdm845 sdm710
UM_4_14_FAMILY := $(MSMNILE) $(MSMSTEPPE) $(TRINKET) $(ATOLL)
UM_4_19_FAMILY := $(KONA) $(LITO) $(BENGAL)
UM_5_4_FAMILY := $(LAHAINA)
UM_PLATFORMS := $(UM_3_18_FAMILY) $(UM_4_4_FAMILY) $(UM_4_9_FAMILY) $(UM_4_14_FAMILY) $(UM_4_19_FAMILY) $(UM_5_4_FAMILY)
QSSI_SUPPORTED_PLATFORMS := $(UM_4_9_FAMILY) $(UM_4_14_FAMILY) $(UM_4_19_FAMILY) $(UM_5_4_FAMILY)

BOARD_USES_ADRENO := true

# Add qtidisplay to soong config namespaces
SOONG_CONFIG_NAMESPACES += qtidisplay

# Add supported variables to qtidisplay config
SOONG_CONFIG_qtidisplay += \
    drmpp \
    headless \
    llvmsa \
    gralloc4 \
    default

# Set default values for qtidisplay config
SOONG_CONFIG_qtidisplay_drmpp ?= false
SOONG_CONFIG_qtidisplay_headless ?= false
SOONG_CONFIG_qtidisplay_llvmsa ?= false
SOONG_CONFIG_qtidisplay_gralloc4 ?= false
SOONG_CONFIG_qtidisplay_default ?= true

# UM platforms no longer need this set on O+
ifneq ($(call is-board-platform-in-list, $(UM_PLATFORMS)),true)
TARGET_USES_QCOM_BSP := true
endif

# Tell HALs that we're compiling an AOSP build with an in-line kernel
TARGET_COMPILE_WITH_MSM_KERNEL := true

ifneq ($(filter msm7x27a msm7x30 msm8660 msm8960,$(PRODUCT_BOARD_PLATFORM)),)
TARGET_USES_QCOM_BSP_LEGACY := true
# Enable legacy audio functions
ifeq ($(BOARD_USES_LEGACY_ALSA_AUDIO),true)
    USE_CUSTOM_AUDIO_POLICY := 1
endif
endif

# Enable media extensions
TARGET_USES_MEDIA_EXTENSIONS := true

# Allow building audio encoders
TARGET_USES_QCOM_MM_AUDIO := true

# Enable color metadata for every UM platform
ifeq ($(call is-board-platform-in-list, $(UM_PLATFORMS)),true)
TARGET_USES_COLOR_METADATA := true
endif

# Enable DRM PP driver on UM platforms that support it
ifeq ($(call is-board-platform-in-list, $(UM_4_9_FAMILY) $(UM_4_14_FAMILY) $(UM_4_19_FAMILY) $(UM_5_4_FAMILY)),true)
TARGET_USES_DRM_PP := true
endif

# Enable Gralloc4 on UM platforms that support it
ifneq ($(call is-board-platform-in-list, $(UM_5_4_FAMILY)),true)
    SOONG_CONFIG_qtidisplay_gralloc4 := true
endif

# Mark GRALLOC_USAGE_HW_2D, GRALLOC_USAGE_EXTERNAL_DISP and GRALLOC_USAGE_PRIVATE_WFD as valid gralloc bits
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 10)
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 13)
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 21)

# Mark GRALLOC_USAGE_PRIVATE_HEIF_VIDEO as valid gralloc bits on UM platforms that support it
ifeq ($(call is-board-platform-in-list, $(UM_4_9_FAMILY) $(UM_5_4_FAMILY)),true)
    TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 27)
endif

# List of targets that use master side content protection
MASTER_SIDE_CP_TARGET_LIST := msm8996 msm8998 sdm660 sdm845 $(UM_4_14_FAMILY) $(UM_4_19_FAMILY) $(UM_5_4_FAMILY)

ALLOWED_SELINUX_VIOLATORS += \
    $(B_FAMILY) \
    $(B64_FAMILY) \
    $(BR_FAMILY) \
    $(UM_3_18_FAMILY)

ifeq ($(call is-board-platform-in-list, $(B_FAMILY)),true)
MSM_VIDC_TARGET_LIST := $(B_FAMILY)
QCOM_HARDWARE_VARIANT := msm8974
else ifeq ($(call is-board-platform-in-list, $(B64_FAMILY)),true)
MSM_VIDC_TARGET_LIST := $(B64_FAMILY)
QCOM_HARDWARE_VARIANT := msm8994
else ifeq ($(call is-board-platform-in-list, $(BR_FAMILY)),true)
MSM_VIDC_TARGET_LIST := $(BR_FAMILY)
QCOM_HARDWARE_VARIANT := msm8916
else ifeq ($(call is-board-platform-in-list, $(UM_3_18_FAMILY)),true)
MSM_VIDC_TARGET_LIST := $(UM_3_18_FAMILY)
QCOM_HARDWARE_VARIANT := msm8996
else ifeq ($(call is-board-platform-in-list, $(UM_4_4_FAMILY)),true)
MSM_VIDC_TARGET_LIST := $(UM_4_4_FAMILY)
QCOM_HARDWARE_VARIANT := msm8998
else ifeq ($(call is-board-platform-in-list, $(UM_4_9_FAMILY)),true)
MSM_VIDC_TARGET_LIST := $(UM_4_9_FAMILY)
QCOM_HARDWARE_VARIANT := sdm845
else ifeq ($(call is-board-platform-in-list, $(UM_4_14_FAMILY)),true)
MSM_VIDC_TARGET_LIST := $(UM_4_14_FAMILY)
QCOM_HARDWARE_VARIANT := sm8150
else ifeq ($(call is-board-platform-in-list, $(UM_4_19_FAMILY)),true)
MSM_VIDC_TARGET_LIST := $(UM_4_19_FAMILY)
QCOM_HARDWARE_VARIANT := sm8250
else ifeq ($(call is-board-platform-in-list, $(UM_5_4_FAMILY)),true)
MSM_VIDC_TARGET_LIST := $(UM_5_4_FAMILY)
QCOM_HARDWARE_VARIANT := sm8350
else
MSM_VIDC_TARGET_LIST := $(PRODUCT_BOARD_PLATFORM)
QCOM_HARDWARE_VARIANT := $(PRODUCT_BOARD_PLATFORM)
endif

# Allow a device to manually override which HALs it wants to use
ifneq ($(OVERRIDE_QCOM_HARDWARE_VARIANT),)
QCOM_HARDWARE_VARIANT := $(OVERRIDE_QCOM_HARDWARE_VARIANT)
endif

QCOM_SOONG_NAMESPACE ?= hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)
PRODUCT_SOONG_NAMESPACES += $(QCOM_SOONG_NAMESPACE)

# Add display-commonsys-intf to PRODUCT_SOONG_NAMESPACES for QSSI supported platforms
ifneq ($(filter $(QSSI_SUPPORTED_PLATFORMS),$(PRODUCT_BOARD_PLATFORM)),)
    PRODUCT_SOONG_NAMESPACES += vendor/qcom/opensource/commonsys-intf/display
endif

include vendor/potato/build/core/qcom_target.mk
