_contents := $(_contents)    "Potato":{$(newline)

# See build/core/soong_config.mk for the add_json_* functions you can use here.
$(call add_json_bool, Needs_text_relocations,                $(filter true,$(TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS)))
$(call add_json_str,  Specific_camera_parameter_library,     $(TARGET_SPECIFIC_CAMERA_PARAMETER_LIBRARY))
$(call add_json_str_omitempty, Target_process_sdk_version_override, $(TARGET_PROCESS_SDK_VERSION_OVERRIDE))
$(call add_json_str,  Target_shim_libs,                      $(TARGET_LD_SHIM_LIBS))
$(call add_json_bool, Uses_generic_camera_parameter_library, $(if $(TARGET_SPECIFIC_CAMERA_PARAMETER_LIBRARY),false,true))
$(call add_json_bool, Uses_qcom_bsp_legacy,                  $(filter true,$(TARGET_USES_QCOM_BSP_LEGACY)))

# This causes the build system to strip out the last comma in our nested struct, to keep the JSON valid.
_contents := $(_contents)__SV_END

_contents := $(_contents)    },$(newline)
