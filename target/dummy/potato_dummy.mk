#
# Copyright (C) 2021 Potato Open Sauce Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Release name
PRODUCT_RELEASE_NAME := dummy

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Inherit from dummy product
$(call inherit-product, vendor/potato/target/dummy/product.mk)

# Include GMS
$(call inherit-product-if-exists, vendor/google/gms/config.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/potato/config/common_full_phone.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := dummy
PRODUCT_NAME := potato_dummy
PRODUCT_BRAND := PotatoProject
PRODUCT_MODEL := Dummy ARM64
PRODUCT_MANUFACTURER := PotatoProject
