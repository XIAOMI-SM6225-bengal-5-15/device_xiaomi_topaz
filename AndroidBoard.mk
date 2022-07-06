LOCAL_PATH := $(call my-dir)

#----------------------------------------------------------------------
# Host compiler configs
#----------------------------------------------------------------------
SOURCE_ROOT := $(shell pwd)
TARGET_HOST_COMPILER_PREFIX_OVERRIDE := prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.17-4.8/bin/x86_64-linux-
TARGET_HOST_CC_OVERRIDE := $(TARGET_HOST_COMPILER_PREFIX_OVERRIDE)gcc
TARGET_HOST_CXX_OVERRIDE := $(TARGET_HOST_COMPILER_PREFIX_OVERRIDE)g++
TARGET_HOST_AR_OVERRIDE := $(TARGET_HOST_COMPILER_PREFIX_OVERRIDE)ar
TARGET_HOST_LD_OVERRIDE := $(TARGET_HOST_COMPILER_PREFIX_OVERRIDE)ld

#----------------------------------------------------------------------
# Compile (L)ittle (K)ernel bootloader and the nandwrite utility
#----------------------------------------------------------------------
ifneq ($(strip $(TARGET_NO_BOOTLOADER)),true)
ifneq ($(strip $(TARGET_SIGNONLY_BOOTLOADER)),true)

# Compile
include bootable/bootloader/edk2/AndroidBoot.mk

$(INSTALLED_BOOTLOADER_MODULE): $(TARGET_EMMC_BOOTLOADER) | $(ACP)
else
TARGET_EMMC_BOOTLOADER := $(TARGET_BOARD_UNSIGNED_ABL_DIR)/unsigned_abl.elf
SIGN_ABL := $(PRODUCT_OUT)/abl.elf

SECIMAGE_BASE := vendor/qcom/proprietary/sectools
SECTOOLS_SECURITY_PROFILE := $(SECIMAGE_BASE)/config/integration/secimagev3.xml
SIGN_ID := abl
INSTALL_FILE_NAME := abl.elf

define sec-image-generate
        echo "Generating signed appsbl using secimage v1 tool"
        rm -rf $(PRODUCT_OUT)/signed
        rm -rf $(PRODUCT_OUT)/signed_ecc
        SECIMAGE_LOCAL_DIR=$(SECIMAGE_BASE) USES_SEC_POLICY_MULTIPLE_DEFAULT_SIGN=$(USES_SEC_POLICY_MULTIPLE_DEFAULT_SIGN) \
        USES_SEC_POLICY_DEFAULT_SUBFOLDER_SIGN=$(USES_SEC_POLICY_DEFAULT_SUBFOLDER_SIGN) \
        USES_SEC_POLICY_INTEGRITY_CHECK=$(USES_SEC_POLICY_INTEGRITY_CHECK) python $(SECIMAGE_BASE)/sectools_builder.py \
                -i $(TARGET_EMMC_BOOTLOADER) \
                -t $(PRODUCT_OUT)/signed \
                -g $(SIGN_ID) \
                --config=$(SECTOOLS_SECURITY_PROFILE) \
                --install_file_name=$(INSTALL_FILE_NAME) \
                --install_base_dir=$(PRODUCT_OUT) \
                > $(PRODUCT_OUT)/secimage.log 2>&1
        echo "Completed secimage v1 signed appsbl (ABL) (logs in $(PRODUCT_OUT)/secimage.log)"
endef

$(SIGN_ABL): $(TARGET_EMMC_BOOTLOADER)
	$(call sec-image-generate)
$(INSTALLED_BOOTLOADER_MODULE): $(SIGN_ABL) | $(ACP)
endif

#   $(transform-prebuilt-to-target)
$(BUILT_TARGET_FILES_PACKAGE): $(INSTALLED_BOOTLOADER_MODULE)

droidcore: $(INSTALLED_BOOTLOADER_MODULE)
droidcore-unbundled: $(INSTALLED_BOOTLOADER_MODULE)
endif

#----------------------------------------------------------------------
# Copy additional target-specific files
#----------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE       := init.target.rc
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)/init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qti.early_init.sh
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_EXECUTABLES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qti.dcvs.sh
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_EXECUTABLES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := gpio-keys.kl
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_KEYLAYOUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := fstab.default
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
ifeq ($(ENABLE_AB), true)
LOCAL_SRC_FILES    := default/fstab_AB_dynamic_partition.qti
else
LOCAL_SRC_FILES    := default/fstab_non_AB_dynamic_partition.qti
endif
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)
include $(BUILD_PREBUILT)


include $(CLEAR_VARS)
LOCAL_MODULE       := fstab.emmc
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
ifeq ($(ENABLE_AB), true)
LOCAL_SRC_FILES    := emmc/fstab_AB_dynamic_partition.qti
else
LOCAL_SRC_FILES    := emmc/fstab_non_AB_dynamic_partition.qti
endif
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)
include $(BUILD_PREBUILT)

include device/qcom/vendor-common/MergeConfig.mk

#----------------------------------------------------------------------
# Radio image
#----------------------------------------------------------------------
ifeq ($(ADD_RADIO_FILES), true)
radio_dir := $(LOCAL_PATH)/radio
RADIO_FILES := $(shell cd $(radio_dir) ; ls)
$(foreach f, $(RADIO_FILES), \
	$(call add-radio-file,radio/$(f)))
endif

#----------------------------------------------------------------------
# wlan specific
#----------------------------------------------------------------------
ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)
include device/qcom/wlan/bengal/AndroidBoardWlan.mk
endif

#----------------------------------------------------------------------
# Configs common to AndroidBoard.mk for all targets
#----------------------------------------------------------------------
include vendor/qcom/opensource/core-utils/build/AndroidBoardCommon.mk
