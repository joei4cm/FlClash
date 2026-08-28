package com.follow.clash.core

import androidx.annotation.Keep

@Keep
interface TunInterface {
    /** Returns false when the socket could not be kept out of the tunnel. */
    fun protect(fd: Int): Boolean

    fun resolverProcess(protocol: Int, source: String, target: String, uid: Int): String
}
