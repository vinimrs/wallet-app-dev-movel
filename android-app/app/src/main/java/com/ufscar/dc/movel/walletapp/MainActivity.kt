package com.ufscar.dc.movel.walletapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Modifier
import androidx.lifecycle.viewmodel.compose.viewModel
import com.ufscar.dc.movel.walletapp.ui.compose.App
import com.ufscar.dc.movel.walletapp.ui.compose.SharedViewModel
import com.ufscar.dc.movel.walletapp.ui.theme.WalletAppTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            WalletAppTheme {
                val sharedViewModel: SharedViewModel = viewModel()
                val languageCodeState = sharedViewModel.languageCode.collectAsState()
                val languageCode = languageCodeState.value

                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    App(sharedViewModel = sharedViewModel)
                }
            }
        }
    }
}

