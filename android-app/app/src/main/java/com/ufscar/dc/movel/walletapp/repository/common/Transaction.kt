package com.ufscar.dc.movel.walletapp.repository.common

import android.annotation.SuppressLint
import java.text.SimpleDateFormat
import java.util.Date

data class Transaction(
    val id: Int = 0,
    val value: Double = 0.0,
    val description: String = "",
    val category: String = "",
    @SuppressLint("SimpleDateFormat") val date: String = SimpleDateFormat("dd/MM/yyyy").format(Date()),
    val expense: Boolean = false,
)
