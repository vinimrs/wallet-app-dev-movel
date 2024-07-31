package com.ufscar.dc.movel.walletapp.repository.common

data class User (
    val id: Int = 3,
    val name: String = "",
    val email: String = "",
    val password: String = "",
    val planning: Planning = Planning()
)