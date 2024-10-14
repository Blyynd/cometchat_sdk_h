package com.cometchat.cometchat_sdk

class Utils {
    fun getSDKVersion(): String {
        return BuildConfig.SDK_VERSION
    }

    fun getPlatform(): String {
        return BuildConfig.PLATFORM
    }
}

