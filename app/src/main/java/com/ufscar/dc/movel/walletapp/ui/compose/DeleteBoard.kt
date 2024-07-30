package com.ufscar.dc.movel.walletapp.ui.compose

import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import androidx.lifecycle.viewmodel.compose.viewModel
import com.ufscar.dc.movel.walletapp.ui.theme.WalletAppTheme

@Composable
fun DeleteBoard(
    mainViewModel: MainViewModel = viewModel()
) {
    Text(text = "Delete Board")
}

@Preview(showBackground = true)
@Composable
fun DeleteBoardPreview() {
    WalletAppTheme {
        DeleteBoard()
    }
}