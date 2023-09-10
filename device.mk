PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/xiaomi

TARGET_BOARD_PLATFORM := bengal
TARGET_BOARD_SUFFIX := _515
TARGET_KERNEL_VERSION := 5.15

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

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# APEX
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Attestation
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml

# Audio
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc) \
    $(LOCAL_PATH)/configs/audio/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/mixer_paths_bengal_idp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_idp_india.xml

PRODUCT_ODM_PROPERTIES += \
    vendor.audio.offload.buffer.size.kb=256

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

# Authsecret
PRODUCT_PACKAGES += \
    android.hardware.authsecret@1.0.vendor

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Bluetooth
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.bluetooth.disableabsvol=true \
    persist.vendor.btstack.aac_frm_ctl.enabled=true \
    persist.sys.btsatck.absvolfeature=true \
    persist.vendor.service.bdroid.soc.alwayson=true \
    ro.bluetooth.emb_wp_mode=false \
    ro.bluetooth.wipower=false

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.qcom.bluetooth.soc=cherokee \
    persist.vendor.qcom.bluetooth.enable.splita2dp=true \
    persist.vendor.qcom.bluetooth.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac \
    persist.vendor.qcom.bluetooth.twsp_state.enabled=false \
    persist.vendor.qcom.bluetooth.scram.enabled=false \
    persist.vendor.qcom.bluetooth.aac_vbr_ctl.enabled=false \
    ro.vendor.bluetooth.wipower=false

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.vendor.btstack.enable.lpa=true

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service_64 \
    libcamera2ndk_vendor \
    libdng_sdk.vendor \
    libstdc++.vendor \
    vendor.qti.hardware.camera.device@1.0.vendor \
    vendor.qti.hardware.camera.postproc@1.0.vendor

PRODUCT_VENDOR_PROPERTIES += \
    camera.disable_zsl_mode=1 \
    sys.haptic.ignoreWhenCamera=true

PRODUCT_SYSTEM_PROPERTIES += \
    persist.vendor.camera.aon.cameraId=8 \
    persist.vendor.camera.aon8475.cameraId=9

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

# Characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Consumer IR AIDL
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml

# Crypto
PRODUCT_VENDOR_PROPERTIES += \
    ro.crypto.volume.filenames_mode=aes-256-cts \
    ro.crypto.allow_encrypt_override=true

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Device Settings
PRODUCT_PACKAGES += \
    XiaomiParts

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/parts/privapp-permissions-parts.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-parts.xml

# Display
PRODUCT_PACKAGES += \
    android.frameworks.displayservice@1.0.vendor \
    android.hardware.graphics.common-V2-ndk.vendor \
    vendor.qti.hardware.display.config-V2-ndk.vendor \
    vendor.qti.hardware.display.config-V5-ndk.vendor \
    vendor.qti.hardware.memtrack-service

PRODUCT_PRODUCT_PROPERTIES += \
    debug.sf.disable_backpressure=1

PRODUCT_VENDOR_PROPERTIES += \
    debug.sf.disable_client_composition_cache=1 \
    debug.sf.layer_caching_active_layer_timeout_ms=1000 \
    debug.sf.treat_170m_as_sRGB=1 \
    ro.surface_flinger.set_display_power_timer_ms=1000 \
    ro.surface_flinger.set_idle_timer_ms=1000 \
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
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4.vendor \
    android.hardware.drm-service.clearkey \
    android.hardware.drm-service.widevine

PRODUCT_VENDOR_PROPERTIES += \
    drm.service.enabled=true

# Fastboot
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Fingerprint
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.fp.sideCap=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# FRP
PRODUCT_VENDOR_PROPERTIES += \
    ro.frp.pst=/dev/block/bootdevice/by-name/frp

#  FUSE passthrough
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss-V2-ndk.vendor

# IDC
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/idc/,$(TARGET_COPY_OUT_VENDOR)/usr/idc)

# Identity
PRODUCT_PACKAGES += \
    android.hardware.identity-V3-ndk.vendor

# Incremental FS
PRODUCT_VENDOR_PROPERTIES += \
    ro.incremental.enable=1

# Kernel
KERNEL_PREBUILT_DIR := $(LOCAL_PATH)-kernel

# Keyguard
PRODUCT_VENDOR_PROPERTIES += \
    persist.wm.enable_remote_keyguard_animation=0

# Keylayout
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/keylayout/,$(TARGET_COPY_OUT_VENDOR)/usr/keylayout)

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0.vendor \
    android.hardware.keymaster@4.1.vendor \
    libkeymaster_messages.vendor

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.hardware_keystore.xml \
    android.hardware.security.keymint-V1-ndk.vendor \
    android.hardware.security.secureclock-V1-ndk.vendor \
    android.hardware.security.sharedsecret-V1-ndk.vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail_vendor \
    libcodec2_hidl@1.0.vendor \
    libcodec2_soft_common.vendor \
    libsfplugin_ccodec_utils.vendor

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

PRODUCT_VENDOR_PROPERTIES += \
    ro.mediaserver.64b.enable=true

# NDK
NEED_AIDL_NDK_PLATFORM_BACKEND := true

# Netmgr
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.data.netmgrd.qos.enable=true

# Neural Networks
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks-V1-ndk.vendor

# NFC
$(call inherit-product, hardware/st/nfc/nfc_vendor_product.mk)
TARGET_USES_ST_AIDL_NFC := true

PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    libchrome.vendor \
    NfcNci \
    SecureElement \
    Tag

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/nfc/libnfc-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st.conf

PRODUCT_SYSTEM_PROPERTIES += \
    ro.nfc.port=I2C

# Overlays
PRODUCT_PACKAGES += \
    AOSPATopazFrameworksOverlay \
    TopazCarrierConfigOverlay \
    TopazFrameworksOverlay \
    TopazSettingsOverlay \
    TopazSystemUIOverlay \
    TopazWifiOverlay

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Perf
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/perf/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf \
    $(LOCAL_PATH)/configs/perf/perfboostsconfig.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/perfboostsconfig.xml \
    $(LOCAL_PATH)/configs/perf/perfconfigstore.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/perfconfigstore.xml

# QC common
TARGET_ADRENO_COMPONENT_VARIANT := adreno
TARGET_GPS_COMPONENT_VARIANT := gps
TARGET_MEDIA_COMPONENT_VARIANT := media
TARGET_PERF_COMPONENT_VARIANT := perf
TARGET_WLAN_COMPONENT_VARIANT := wlan
TARGET_USE_AIDL_QTI_HEALTH := true

TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    alarm \
    audio \
    av \
    bt \
    charging \
    display \
    gps \
    init \
    media \
    overlay \
    perf \
    telephony \
    usb \
    vibrator \
    wfd \
    wlan

# Radio
PRODUCT_PRODUCT_PROPERTIES += \
    persist.vendor.ims.no_stapa=1 \
    persist.vendor.radio.enable_temp_dds=true \
    rild.libpath=/vendor/lib64/libril-qc-hal-qmi.so \
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
    persist.vendor.rcs.singlereg.feature=1

# Rootdir / Init script files
PRODUCT_PACKAGES += \
    init.goodix.events.sh \
    init.qti.dcvs.sh \
    init.qti.early_init.sh

PRODUCT_PACKAGES += \
    init.target.rc \
    init.topaz.rc \
    init.topaz.perf.rc \
    init.xiaomi.fingerprint.rc \
    init.xiaomi.rc \
    ueventd.xiaomi.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(LOCAL_PATH)/init/fstab.zram:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.zram \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.qcom \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.xiaomi-multihal \
    android.hardware.sensors@2.0-ScopedWakelock.vendor \
    android.frameworks.sensorservice@1.0.vendor \
    libsensorndkbridge

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.sensors.debug.ssc_qmi_debug=true \
    persist.vendor.sensors.hal_trigger_ssr=false \
    persist.vendor.sensors.enable.rt_task=false \
    persist.vendor.sensors.support_direct_channel=false \
    persist.vendor.sensors.enable.bypass_worker=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

# Set GRF/Vendor freeze properties
SHIPPING_API_LEVEL := 33
PRODUCT_SHIPPING_API_LEVEL := $(SHIPPING_API_LEVEL)

BOARD_SHIPPING_API_LEVEL := 33
BOARD_API_LEVEL := 33

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service.qti-v2

PRODUCT_VENDOR_PROPERTIES += \
    vendor.sys.thermal.data.path=/data/vendor/thermal/

# Time-services
PRODUCT_PRODUCT_PROPERTIES += \
    persist.timed.enable=true

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true

# TrustedUI
PRODUCT_PACKAGES += \
    android.hidl.memory.block@1.0.vendor \
    vendor.qti.hardware.systemhelper@1.0.vendor

# USB
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.usb.config=mtp,adb
endif

# Inherit from vendor blobs
$(call inherit-product, vendor/xiaomi/topaz/topaz-vendor.mk)

# Verified Boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# Wlan
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.wlan.vendor=qcom \
    ro.hardware.wlan.chip=wcn3950 \
    ro.hardware.wlan.mimo=0 \
    ro.hardware.wlan.dbs=0
