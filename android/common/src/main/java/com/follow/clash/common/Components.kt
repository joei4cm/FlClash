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
        "kitty_orange" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconKittyOrange"),
        "kitty_gray" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconKittyGray"),
        "puppy_golden" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconPuppyGolden"),
        "puppy_shiba" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconPuppyShiba"),
        "kitty_cheese" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconKittyCheese"),
        "kitty_white" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconKittyWhite"),
        "kitty_black" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconKittyBlack"),
        "kitty_calico" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconKittyCalico"),
        "puppy_dachshund" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconPuppyDachshund"),
        "puppy_samoyed" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconPuppySamoyed"),
        "puppy_bulldog" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconPuppyBulldog"),
        "puppy_corgi" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconPuppyCorgi"),
        "bunny" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconBunny"),
        "red_panda" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconRedPanda"),
        "hamster" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconHamster"),
        "otter" to ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.IconOtter"),
    )
}
