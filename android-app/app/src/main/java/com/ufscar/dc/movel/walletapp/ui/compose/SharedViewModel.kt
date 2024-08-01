package com.ufscar.dc.movel.walletapp.ui.compose

import androidx.lifecycle.ViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

class SharedViewModel : ViewModel() {
    private val _languageCode = MutableStateFlow("en")
    val languageCode: StateFlow<String> get() = _languageCode

    fun setLanguageCode(languageCode: String) {
        _languageCode.value = languageCode
    }
}
