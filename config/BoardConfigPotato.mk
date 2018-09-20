include vendor/potato/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/potato/config/BoardConfigQcom.mk
endif

include vendor/potato/config/BoardConfigSoong.mk
