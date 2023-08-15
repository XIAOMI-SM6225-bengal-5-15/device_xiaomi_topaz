#
# This empty Android.mk file exists to prevent the build system from
# automatically including any other Android.mk files under this directory.
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),topaz)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

endif