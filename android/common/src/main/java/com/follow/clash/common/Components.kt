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
        "mascot_cloud" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconMascotCloud"),
        "mascot_fox" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconMascotFox"),
        "mascot_penguin" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconMascotPenguin"),
        "mascot_robot" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconMascotRobot"),
    )
}
