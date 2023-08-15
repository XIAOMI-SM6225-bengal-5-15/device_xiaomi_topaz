PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

TARGET_BOARD_PLATFORM := bengal
TARGET_BOARD_SUFFIX := _515

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/android_t_baseline.mk)
PRODUCT_VIRTUAL_AB_COMPRESSION_METHOD := gz

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service \
    checkpoint_gc \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Camera
PRODUCT_VENDOR_PROPERTIES += \
    camera.disable_zsl_mode=1

# Characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Crypto
PRODUCT_VENDOR_PROPERTIES += \
    ro.crypto.volume.filenames_mode=aes-256-cts \
    ro.crypto.allow_encrypt_override=true

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Fastboot
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

#  FUSE passthrough
PRODUCT_VENDOR_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# Incremental FS
PRODUCT_VENDOR_PROPERTIES += \
    ro.incremental.enable=1

# Kernel
KERNEL_PREBUILT_DIR := $(LOCAL_PATH)-kernel

# NDK
NEED_AIDL_NDK_PLATFORM_BACKEND := true

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Rootdir / Init script files
PRODUCT_PACKAGES += \
    init.qti.dcvs.sh \
    init.qti.early_init.sh

PRODUCT_PACKAGES += \
    init.target.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.qcom \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.multihal

# Set GRF/Vendor freeze properties
SHIPPING_API_LEVEL := 33
PRODUCT_SHIPPING_API_LEVEL := $(SHIPPING_API_LEVEL)

BOARD_SHIPPING_API_LEVEL := 33
BOARD_API_LEVEL := 33

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true
