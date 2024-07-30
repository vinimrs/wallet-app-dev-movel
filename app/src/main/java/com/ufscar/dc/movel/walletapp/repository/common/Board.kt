package com.ufscar.dc.movel.walletapp.repository.common

data class Board (
    val id: Int = 0,
    val name: String = "",
    val messages: List<Message>
)