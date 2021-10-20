# Copyright 2016 The Pure Nexus Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
LOCAL_PATH := vendor/potato-prebuilts/sounds
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/alarms,$(TARGET_COPY_OUT_PRODUCT)/media/audio/alarms)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/notifications,$(TARGET_COPY_OUT_PRODUCT)/media/audio/notifications)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/ringtones,$(TARGET_COPY_OUT_PRODUCT)/media/audio/ringtones)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/ui,$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui)

# Set default ringtone, notification and alarm
PRODUCT_PRODUCT_PROPERTIES += \
   ro.config.alarm_alert=Bright_morning.ogg \
   ro.config.ringtone=The_big_adventure.ogg \
   ro.config.notification_sound=Popcorn.ogg
