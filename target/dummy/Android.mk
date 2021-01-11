LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),dummy)

include $(call all-subdir-makefiles,$(LOCAL_PATH))

endif
