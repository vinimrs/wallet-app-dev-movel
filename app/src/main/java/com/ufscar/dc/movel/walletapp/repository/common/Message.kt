package com.ufscar.dc.movel.walletapp.repository.common

data class Message (
    val from: String = "",
    val to: String = "",
    val text: String = "",
    val timestamp: String = "",
)