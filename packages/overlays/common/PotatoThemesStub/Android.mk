LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_PRODUCT_MODULE := true
LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res
LOCAL_MANIFEST_FILE := AndroidManifest.xml
LOCAL_PACKAGE_NAME := PotatoThemesStub
LOCAL_SDK_VERSION := current

include $(BUILD_PACKAGE)
