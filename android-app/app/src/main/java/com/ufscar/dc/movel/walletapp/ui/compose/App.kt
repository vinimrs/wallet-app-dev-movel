package com.ufscar.dc.movel.walletapp.ui.compose

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.ufscar.dc.movel.walletapp.ui.theme.WalletAppTheme
import kotlinx.coroutines.launch

@Composable
fun App(
    navController: NavHostController = rememberNavController(),
    sharedViewModel: SharedViewModel = viewModel()
) {
    // Get current back stack entry
    val backStackEntry by navController.currentBackStackEntryAsState()
    val mainViewModel = viewModel<MainViewModel>()
    val snackbarHostState = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()

    Scaffold(
        topBar = {
            AppBar(
                canNavigateBack = backStackEntry?.destination?.route != "Login" &&
                        backStackEntry?.destination?.route != "Register" &&
                        backStackEntry?.destination?.route != "Main",
                navigateUp = {
                    navController.navigateUp() },
                sharedViewModel = sharedViewModel
            )
        },
        snackbarHost = {
            SnackbarHost(hostState = snackbarHostState)
        }
    ) { innerPadding ->
        NavHost(
            navController = navController,
            startDestination = "Login",
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
        ) {
            composable("Login") {
                LoginScreen(
                    mainViewModel,
                    onLoginClicked = {
                        if(mainViewModel.errorMessage.isEmpty())
                            navController.navigate("Main") },
                    onRegisterButtonClicked = { navController.navigate("Register")}
                )
            }

            composable("Register") {
                RegisterScreen(
                    mainViewModel,
                    onRegisterClicked = { navController.navigate("Main") },
                    onLoginButtonClicked = { navController.navigate("Login") }
                )
            }

            composable("Transaction") {
                TransactionScreen(
                    mainViewModel,
                    onTransactionCancelledClicked = { navController.navigate("Main") },
                    onTransactionConfirmedClicked = { navController.navigate("Main") }
                )
            }

            composable("Main") {
                MainScreen(
                    mainViewModel,
                    onNewTransactionClicked = { navController.navigate("Transaction") },
                    onLogoutClicked = { navController.navigate("Login") }
                )
            }
        }
    }

    if (mainViewModel.showNetworkErrorSnackBar) {
        LaunchedEffect(mainViewModel.showNetworkErrorSnackBar) {
            scope.launch {
                val result = snackbarHostState.showSnackbar(
                    mainViewModel.errorMessage ?:
                    "Network error. Try again later!",
                    actionLabel = "OK"
                )
                when(result) {
                    SnackbarResult.Dismissed -> mainViewModel.dismissNetworkErrorSnackBar()
                    SnackbarResult.ActionPerformed -> mainViewModel.dismissNetworkErrorSnackBar()
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun AppPreview() {
    WalletAppTheme {
        App()
    }
}
