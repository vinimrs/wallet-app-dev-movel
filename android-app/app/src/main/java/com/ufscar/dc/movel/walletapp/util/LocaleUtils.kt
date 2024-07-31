package com.ufscar.dc.movel.walletapp.util

import android.content.Context
import android.content.res.Configuration
import android.os.Build
import androidx.annotation.RequiresApi
import java.util.Locale

object LocaleUtils {
    @Suppress("DEPRECATION")
    fun setLocale(context: Context, language: String) {
        val locale = Locale(language)
        Locale.setDefault(locale)
        val config = Configuration(context.resources.configuration)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            setLocaleForNougat(config, locale)
        } else {
            setLocaleForPreNougat(config, locale)
        }
        context.createConfigurationContext(config)
    }

    @RequiresApi(Build.VERSION_CODES.N)
    private fun setLocaleForNougat(config: Configuration, locale: Locale) {
        config.setLocale(locale)
    }

    @Suppress("DEPRECATION")
    private fun setLocaleForPreNougat(config: Configuration, locale: Locale) {
        config.locale = locale
    }
}
