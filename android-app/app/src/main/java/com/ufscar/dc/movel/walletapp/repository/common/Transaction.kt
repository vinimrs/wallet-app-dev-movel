package com.ufscar.dc.movel.walletapp.repository.common

data class Transaction(
    val id: Int = 0,
    val value: Double = 0.0,
    val description: String = "",
    val date: String = ""
)
