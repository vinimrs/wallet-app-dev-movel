package com.ufscar.dc.movel.walletapp.repository.common

import kotlin.random.Random

data class User (
    val id: Int = generateRandomIntId(),
    val name: String = "",
    val email: String = "",
    val password: String = "",
    val planning: Planning = Planning()
)

fun generateRandomIntId(): Int {
    val randomSuffix = Random.nextInt(100, 999)

    return randomSuffix
}