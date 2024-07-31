package com.ufscar.dc.movel.walletapp.repository.dto

import com.ufscar.dc.movel.walletapp.repository.common.User

data class LoginUserResponse(
    val success: Boolean,
    val message: String,
    val user: User
)
