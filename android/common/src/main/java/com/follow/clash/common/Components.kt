package com.follow.clash.common

import android.content.ComponentName

object Components {
    const val PACKAGE_NAME = "com.follow.clash"

    val mainActivity =
        ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.MainActivity")

    val quickActionActivity =
        ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.QuickActionActivity")

    val serviceBroadcastReceiver =
        ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.ServiceBroadcastReceiver")

    /** Phone launcher icons (activity-aliases targeting [mainActivity]). */
    val launcherIcons = listOf(
        "classic" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconClassic"),
        "frost" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconFrost"),
        "midnight" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconMidnight"),
        "indigo" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconIndigo"),
        "tide" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconTide"),
        "graphite" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconGraphite"),
        "kitty_cheese" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconKittyCheese"),
        "kitty_orange" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconKittyOrange"),
        "kitty_black" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconKittyBlack"),
        "kitty_calico" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconKittyCalico"),
        "puppy_corgi" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconPuppyCorgi"),
        "puppy_dachshund" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconPuppyDachshund"),
        "puppy_bulldog" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconPuppyBulldog"),
        "bunny" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconBunny"),
        "hamster" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconHamster"),
        "otter" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconOtter"),
    )
}
