LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := FrameworkLibs
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_SUFFIX := -timestamp
framework_deps := $(call java-lib-deps,framework)
framework_libs_path := $(PRODUCT_OUT)/framework-libs

include $(BUILD_SYSTEM)/base_rules.mk

.PHONY: copy_framework_deps
copy_framework_deps: $(framework_deps)
	$(hide) mkdir -p $(framework_libs_path)
	$(hide) rm -rf $(framework_libs_path)/*.jar
	$(hide) cp $(framework_deps) $(framework_libs_path)/framework.jar

$(LOCAL_BUILT_MODULE): copy_framework_deps
	$(hide) echo "Fake: $@"
	$(hide) mkdir -p $(dir $@)
	$(hide) touch $@

include $(call all-makefiles-under,$(LOCAL_PATH))
