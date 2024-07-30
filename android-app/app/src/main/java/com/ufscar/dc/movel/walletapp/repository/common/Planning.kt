package com.ufscar.dc.movel.walletapp.repository.common

data class Planning(
    val initBalance: Double = 0.0,
    val balance: Double = 0.0,
    val transactions: List<Transaction>
)
