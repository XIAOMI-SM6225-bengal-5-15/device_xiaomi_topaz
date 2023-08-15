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

# Audio
PRODUCT_VENDOR_PROPERTIES += \
    debug.stagefright.c2inputsurface=-1 \
    ro.audio.monitorRotation=false \
    ro.vendor.audio.game.mode=true \
    ro.vendor.audio.policy.engine.odm=true \
    ro.vendor.audio.soundfx.type=mi \
    ro.vendor.audio.soundfx.usb=true \
    ro.vendor.audio.surround.support=true \
    ro.vendor.audio.scenario.support=true \
    ro.vendor.audio.sfx.scenario=true \
    ro.vendor.audio.sfx.earadj=true \
    ro.vendor.audio.sdk.fluencetype=none \
    ro.vendor.audio.vocal.support=true \
    ro.vendor.audio.voice.change.support=true \
    ro.vendor.audio.voice.change.version=2

# Bluetooth
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.vendor.btstack.aac_frm_ctl.enabled=true \
    persist.sys.btsatck.absvolfeature=true \
    persist.vendor.service.bdroid.soc.alwayson=true \
    ro.bluetooth.emb_wp_mode=false \
    ro.bluetooth.wipower=false

PRODUCT_VENDOR_PROPERTIES += \
    persist.bluetooth.disableabsvol=true \
    persist.vendor.qcom.bluetooth.soc=cherokee \
    persist.vendor.qcom.bluetooth.enable.splita2dp=true \
    persist.vendor.qcom.bluetooth.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac \
    persist.vendor.qcom.bluetooth.twsp_state.enabled=false \
    persist.vendor.qcom.bluetooth.scram.enabled=false \
    persist.vendor.qcom.bluetooth.aac_vbr_ctl.enabled=false \
    ro.vendor.bluetooth.wipower=false

# Camera
PRODUCT_VENDOR_PROPERTIES += \
    camera.disable_zsl_mode=1 \
    sys.haptic.ignoreWhenCamera=true

PRODUCT_SYSTEM_PROPERTIES += \
    persist.vendor.camera.aon.cameraId=8 \
    persist.vendor.camera.aon8475.cameraId=9

# Characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Crypto
PRODUCT_VENDOR_PROPERTIES += \
    ro.crypto.volume.filenames_mode=aes-256-cts \
    ro.crypto.allow_encrypt_override=true

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Display
PRODUCT_PRODUCT_PROPERTIES += \
    debug.sf.disable_backpressure=1

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.display.sensortype=2 \
    ro.vendor.display.svi=1 \
    vendor.display.idle_time=0 \
    vendor.display.svi.config=1 \
    vendor.display.svi.config_path=/vendor/etc/SVIConfig.xml

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.histogram.enable=true \
    ro.vendor.xiaomi.bl.poll=true

# DPM vndr
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.dpm.vndr.idletimer.mode=default \
    persist.vendor.dpm.vndr.halservice.enable=1 \
    persist.vendor.dpm.vndr.feature=1

# DRM
PRODUCT_VENDOR_PROPERTIES += \
    drm.service.enabled=true

# Fastboot
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Fingerprint
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.fp.sideCap=true

# FRP
PRODUCT_VENDOR_PROPERTIES += \
    ro.frp.pst=/dev/block/bootdevice/by-name/frp

#  FUSE passthrough
PRODUCT_VENDOR_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# Incremental FS
PRODUCT_VENDOR_PROPERTIES += \
    ro.incremental.enable=1

# Kernel
KERNEL_PREBUILT_DIR := $(LOCAL_PATH)-kernel

# Media
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    media.aac_51_output_enabled=true \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-fma2dp=true \
    media.stagefright.enable-http=true \
    media.stagefright.enable-player=true \
    media.stagefright.enable-qcp=true \
    media.stagefright.enable-scan=true \
    mmp.enable.3g2=true \
    persist.mm.enable.prefetch=true

# NDK
NEED_AIDL_NDK_PLATFORM_BACKEND := true

# Netmgr
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.data.netmgrd.qos.enable=true

# NFC
PRODUCT_SYSTEM_PROPERTIES += \
    ro.nfc.port=I2C

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Radio
PRODUCT_PRODUCT_PROPERTIES += \
    persist.vendor.ims.no_stapa=1 \
    persist.vendor.radio.enable_temp_dds=true \
    ro.vendor.radio.features_common=3 \
    ro.vendor.radio.fastdormancy=true

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.se.type=HCE,UICC \
    persist.vendor.data.iwlan.enable=true \
    persist.vendor.radio.data_con_rprt=1 \
    persist.vendor.radio.snapshot_enabled=1 \
    persist.vendor.radio.snapshot_timer=5 \
    persist.vendor.radio.manual_nw_rej_ct=1 \
    persist.vendor.radio.atfwd.start=true \
    persist.vendor.rcs.singlereg.feature=1 \
    rild.libpath=/vendor/lib64/libril-qc-hal-qmi.so

# Rootdir / Init script files
PRODUCT_PACKAGES += \
    init.qti.dcvs.sh \
    init.qti.early_init.sh

PRODUCT_PACKAGES += \
    init.target.rc \
    init.xiaomi.fingerprint.rc \
    init.xiaomi.rc \
    ueventd.xiaomi.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.qcom \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.multihal

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.sensors.debug.ssc_qmi_debug=true \
    persist.vendor.sensors.hal_trigger_ssr=false \
    persist.vendor.sensors.enable.rt_task=false \
    persist.vendor.sensors.support_direct_channel=false \
    persist.vendor.sensors.enable.bypass_worker=true

# Set GRF/Vendor freeze properties
SHIPPING_API_LEVEL := 33
PRODUCT_SHIPPING_API_LEVEL := $(SHIPPING_API_LEVEL)

BOARD_SHIPPING_API_LEVEL := 33
BOARD_API_LEVEL := 33

# Thermal
PRODUCT_VENDOR_PROPERTIES += \
    vendor.sys.thermal.data.path=/data/vendor/thermal/

# Time-services
PRODUCT_VENDOR_PROPERTIES += \
    persist.timed.enable=true

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true

# Wlan
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.wlan.vendor=qcom \
    ro.hardware.wlan.chip=wcn3950 \
    ro.hardware.wlan.mimo=0 \
    ro.hardware.wlan.dbs=0
