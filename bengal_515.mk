TARGET_BOARD_PLATFORM := bengal
TARGET_BOARD_SUFFIX := _515

ALLOW_MISSING_DEPENDENCIES := true
RELAX_USES_LIBRARY_CHECK := true

# Enable AVB 2.0
BOARD_AVB_ENABLE := true

# Enable Virtual A/B
ENABLE_VIRTUAL_AB := true

ifeq ($(ENABLE_VIRTUAL_AB), true)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
endif

# Default A/B configuration
ENABLE_AB ?= true

SYSTEMEXT_SEPARATE_PARTITION_ENABLE = true

# Enable Dynamic partition
BOARD_DYNAMIC_PARTITION_ENABLE ?= true

SHIPPING_API_LEVEL := 30
PRODUCT_SHIPPING_API_LEVEL := $(SHIPPING_API_LEVEL)

BOARD_SHIPPING_API_LEVEL := 30
BOARD_API_LEVEL := 30

# For QSSI builds, we should skip building the system image. Instead we build the
# "non-system" images (that we support).

PRODUCT_BUILD_SYSTEM_IMAGE := false
PRODUCT_BUILD_SYSTEM_OTHER_IMAGE := false
PRODUCT_BUILD_SYSTEM_DLKM_IMAGE := true
PRODUCT_BUILD_VENDOR_IMAGE := true
PRODUCT_BUILD_VENDOR_DLKM_IMAGE := true
PRODUCT_BUILD_PRODUCT_IMAGE := false
PRODUCT_BUILD_PRODUCT_SERVICES_IMAGE := false
PRODUCT_BUILD_ODM_IMAGE := true
ifeq ($(ENABLE_AB), true)
PRODUCT_BUILD_CACHE_IMAGE := false
else
PRODUCT_BUILD_CACHE_IMAGE := true
endif
PRODUCT_BUILD_RAMDISK_IMAGE := true
PRODUCT_BUILD_RECOVERY_IMAGE := true
PRODUCT_BUILD_USERDATA_IMAGE := true

TARGET_SKIP_OTA_PACKAGE := true

#BUILD_BROKEN_PHONY_TARGETS := true
BUILD_BROKEN_DUP_RULES := true
TEMPORARY_DISABLE_PATH_RESTRICTIONS := true
#export TEMPORARY_DISABLE_PATH_RESTRICTIONS

ifneq ($(strip $(BOARD_DYNAMIC_PARTITION_ENABLE)),true)
# Enable chain partition for system, to facilitate system-only OTA in Treble.
BOARD_AVB_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_SYSTEM_ROLLBACK_INDEX := 0
BOARD_AVB_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
else
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_PACKAGES += fastbootd
# Add default implementation of fastboot HAL.
PRODUCT_PACKAGES += android.hardware.fastboot@1.0-impl-mock
# f2fs utilities
PRODUCT_PACKAGES += \
 sg_write_buffer \
 f2fs_io \
 check_f2fs

# Userdata checkpoint
PRODUCT_PACKAGES += \
 checkpoint_gc

ifeq ($(ENABLE_AB), true)
# Userdata checkpoint start
AB_OTA_POSTINSTALL_CONFIG += \
RUN_POSTINSTALL_vendor=true \
POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
FILESYSTEM_TYPE_vendor=ext4 \
POSTINSTALL_OPTIONAL_vendor=true
# Userdata checkpoint end
PRODUCT_COPY_FILES += $(LOCAL_PATH)/default/fstab_AB_dynamic_partition.qti:$(TARGET_COPY_OUT_RAMDISK)/fstab.default
PRODUCT_COPY_FILES += $(LOCAL_PATH)/emmc/fstab_AB_dynamic_partition.qti:$(TARGET_COPY_OUT_RAMDISK)/fstab.emmc
else
PRODUCT_COPY_FILES += $(LOCAL_PATH)/default/fstab_non_AB_dynamic_partition.qti:$(TARGET_COPY_OUT_RAMDISK)/fstab.default
PRODUCT_COPY_FILES += $(LOCAL_PATH)/emmc/fstab_non_AB_dynamic_partition.qti:$(TARGET_COPY_OUT_RAMDISK)/fstab.emmc
endif
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
endif

BOARD_HAVE_BLUETOOTH := false
BOARD_HAVE_QCOM_FM := false
TARGET_DISABLE_PERF_OPTIMIATIONS := false

TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# Enable incremental FS feature
PRODUCT_PROPERTY_OVERRIDES += ro.incremental.enable=1

PRODUCT_PACKAGES += init.qti.early_init.sh
PRODUCT_PROPERTY_OVERRIDES += \
    ro.soc.manufacturer=QTI

# privapp-permissions whitelisting (To Fix CTS :privappPermissionsMustBeEnforced)
PRODUCT_PROPERTY_OVERRIDES += ro.control_privapp_permissions=enforce

TARGET_DEFINES_DALVIK_HEAP := true

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, device/qcom/vendor-common/common64.mk)
# Temporary bring-up config <--

# Temporary bring-up config -->
PRODUCT_SUPPORTS_VERITY := false
# Temporary bring-up config <--
###########
PRODUCT_PROPERTY_OVERRIDES  += \
     dalvik.vm.heapstartsize=8m \
     dalvik.vm.heapsize=256m \
     dalvik.vm.heapgrowthlimit=128m \
     dalvik.vm.heaptargetutilization=0.75 \
     dalvik.vm.heapminfree=512k \
     dalvik.vm.heapmaxfree=8m
# Target naming
PRODUCT_NAME := bengal_515
PRODUCT_DEVICE := bengal_515
PRODUCT_BRAND := qti
PRODUCT_MODEL := Bengal for arm64


TARGET_USES_AOSP := false
TARGET_USES_AOSP_FOR_AUDIO := false
TARGET_USES_QCOM_BSP := false

# RRO configuration
TARGET_USES_RRO := true

TARGET_DISABLE_DISPLAY := false

NEED_AIDL_NDK_PLATFORM_BACKEND := true

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

###########
#QMAA flags starts
###########
#QMAA global flag for modular architecture
#true means QMAA is enabled for system
#false means QMAA is disabled for system

TARGET_USES_QMAA := true

#QMAA flag which is set to incorporate any generic dependencies
#required for the boot to UI flow in a QMAA enabled target.
#Set to false when all target level depenencies are met with
#actual full blown implementations.
TARGET_USES_QMAA_RECOMMENDED_BOOT_CONFIG := true

#QMAA tech team flag to override global QMAA per tech team
#true means overriding global QMAA for this tech area
#false means using global, no override
TARGET_USES_QMAA_OVERRIDE_RPMB := false
TARGET_USES_QMAA_OVERRIDE_DISPLAY := false
TARGET_USES_QMAA_OVERRIDE_AUDIO   := false
TARGET_USES_QMAA_OVERRIDE_VIDEO   := false
TARGET_USES_QMAA_OVERRIDE_CAMERA  := false
TARGET_USES_QMAA_OVERRIDE_GFX     := false
TARGET_USES_QMAA_OVERRIDE_WFD     := false
TARGET_USES_QMAA_OVERRIDE_GPS     := false
TARGET_USES_QMAA_OVERRIDE_ANDROID_RECOVERY := true
TARGET_USES_QMAA_OVERRIDE_ANDROID_CORE := true
TARGET_USES_QMAA_OVERRIDE_WLAN    := false
TARGET_USES_QMAA_OVERRIDE_DPM  := false
TARGET_USES_QMAA_OVERRIDE_BLUETOOTH   := false
TARGET_USES_QMAA_OVERRIDE_FM  := false
TARGET_USES_QMAA_OVERRIDE_CVP  := false
TARGET_USES_QMAA_OVERRIDE_FASTCV  := true
TARGET_USES_QMAA_OVERRIDE_SCVE  := true
TARGET_USES_QMAA_OVERRIDE_OPENVX  := true
TARGET_USES_QMAA_OVERRIDE_DIAG := false
TARGET_USES_QMAA_OVERRIDE_FTM := false
TARGET_USES_QMAA_OVERRIDE_DATA := false
TARGET_USES_QMAA_OVERRIDE_DATA_NET := true
TARGET_USES_QMAA_OVERRIDE_KERNEL_TESTS_INTERNAL := false
TARGET_USES_QMAA_OVERRIDE_MSMIRQBALANCE := true
TARGET_USES_QMAA_OVERRIDE_VIBRATOR := false
TARGET_USES_QMAA_OVERRIDE_DRM     := false
TARGET_USES_QMAA_OVERRIDE_KMGK := false
TARGET_USES_QMAA_OVERRIDE_VPP := false
TARGET_USES_QMAA_OVERRIDE_GP := false
TARGET_USES_QMAA_OVERRIDE_BIOMETRICS := true
TARGET_USES_QMAA_OVERRIDE_SPCOM_UTEST := false
TARGET_USES_QMAA_OVERRIDE_PERF := true
TARGET_USES_QMAA_OVERRIDE_SENSORS := false
TARGET_USES_QMAA_OVERRIDE_SYNX := false
TARGET_USES_QMAA_OVERRIDE_SECUREMSM_TESTS := false
TARGET_USES_QMAA_OVERRIDE_SOTER := false
TARGET_USES_QMAA_OVERRIDE_REMOTE_EFS := false
TARGET_USES_QMAA_OVERRIDE_TFTP := false
TARGET_USES_QMAA_OVERRIDE_EID := false

#Full QMAA HAL List
QMAA_HAL_LIST := audio video camera display sensors gps

ifeq ($(TARGET_USES_QMAA), true)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.confqmaa=true
endif

###########
#QMAA flags ends

CLEAN_UP_JAVA_IN_VENDOR := warning

JAVA_IN_VENDOR_SOONG_WHITE_LIST :=\
CuttlefishService\
pasrservice\
QFingerprintService\
QFPCalibration\
VendorPrivAppPermissionTest\

JAVA_IN_VENDOR_MAKE_WHITE_LIST :=\
AEye\
FDA\
SnapdragonCamera\

# Set kernel version and ion flags
TARGET_KERNEL_VERSION := 5.15
TARGET_USES_NEW_ION := true

# Disable DLKM generation until build support is available
TARGET_KERNEL_DLKM_DISABLE := true

# Tech specific flags
TARGET_KERNEL_DLKM_AUDIO_OVERRIDE := false
TARGET_KERNEL_DLKM_BT_OVERRIDE := false
TARGET_KERNEL_DLKM_CAMERA_OVERRIDE := false
TARGET_KERNEL_DLKM_NFC_OVERRIDE := false
TARGET_KERNEL_DLKM_DATA_OVERRIDE := false
TARGET_KERNEL_DLKM_DISPLAY_OVERRIDE := false
TARGET_KERNEL_DLKM_MM_DRV_OVERRIDE := false
TARGET_KERNEL_DLKM_SECURE_MSM_OVERRIDE := false
TARGET_KERNEL_DLKM_THERMAL_OVERRIDE := false
TARGET_KERNEL_DLKM_TOUCH_OVERRIDE := false
TARGET_KERNEL_DLKM_VIDEO_OVERRIDE := false
TARGET_KERNEL_DLKM_WLAN_OVERRIDE := false
TARGET_KERNEL_DLKM_MMRM_OVERRIDE := false

#Suppot to compile recovery without msm headers
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

###########
# Target configurations

QCOM_BOARD_PLATFORMS += bengal

TARGET_USES_QSSI := true

#Default vendor image configuration
ENABLE_VENDOR_IMAGE := true

# default is nosdcard, S/W button enabled in resource
PRODUCT_CHARACTERISTICS := nosdcard

BOARD_FRP_PARTITION_NAME := frp

# Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

PRODUCT_PACKAGES += fs_config_files
PRODUCT_PACKAGES += gpio-keys.kl
PRODUCT_PACKAGES += libvolumelistener

ifeq ($(ENABLE_AB), true)
# A/B related packages
PRODUCT_PACKAGES += update_engine \
    update_engine_client \
    update_verifier \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

PRODUCT_HOST_PACKAGES += \
    brillo_update_payload
# Boot control HAL test app
PRODUCT_PACKAGES_DEBUG += bootctl

PRODUCT_PACKAGES += \
  update_engine_sideload

endif
DEVICE_FRAMEWORK_MANIFEST_FILE := device/qcom/bengal_515/framework_manifest.xml

DEVICE_MANIFEST_FILE := device/qcom/bengal_515/manifest.xml
DEVICE_MATRIX_FILE   := device/qcom/common/compatibility_matrix.xml

# Enable compilation of image_generation_tool
TARGET_USES_IMAGE_GEN_TOOL := true

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_NAME)/$(KERNEL_MODULES_INSTALL)/lib/modules

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

#target specific runtime prop for qspm
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qspm.enable=true

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

# Audio configuration file
-include $(TOPDIR)vendor/qcom/opensource/audio-hal/primary-hal/configs/bengal/bengal.mk

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

#Enable full treble flag
PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_VENDOR_MOVE_ENABLED := true
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true
BOARD_SYSTEMSDK_VERSIONS := 29
BOARD_VNDK_VERSION := current
TARGET_MOUNT_POINTS_SYMLINKS := false

PRODUCT_BOOT_JARS += telephony-ext
PRODUCT_PACKAGES += telephony-ext

PRODUCT_BOOT_JARS += tcmiface

# Vendor property to enable advanced network scanning
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.enableadvancedscan=true

# Property to disable ZSL mode
PRODUCT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=1

PRODUCT_PROPERTY_OVERRIDES += \
ro.crypto.volume.filenames_mode = "aes-256-cts" \
ro.crypto.allow_encrypt_override = true

PRODUCT_PACKAGES += init.qti.dcvs.sh
PRODUCT_PACKAGES += android.hardware.lights-service.qti

#----------------------------------------------------------------------
# wlan specific
#----------------------------------------------------------------------
ifeq ($(TARGET_USES_QMAA), true)
ifneq ($(TARGET_USES_QMAA_OVERRIDE_WLAN), true)
include device/qcom/wlan/default/wlan.mk
else
include device/qcom/wlan/bengal/wlan.mk
endif
else
include device/qcom/wlan/bengal/wlan.mk
endif

###################################################################################
# This is the End of target.mk file.
# Now, Pickup other split product.mk files:
###################################################################################
# TODO: Relocate the system product.mk files pickup into qssi lunch, once it is up.
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/system/*.mk)
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/vendor/*.mk)
###################################################################################