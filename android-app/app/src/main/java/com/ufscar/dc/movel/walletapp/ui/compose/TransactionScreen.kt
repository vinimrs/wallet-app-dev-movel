package com.ufscar.dc.movel.walletapp.ui.compose


import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Close
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.ufscar.dc.movel.walletapp.ui.theme.WalletAppTheme


@Composable
fun TransactionScreen(
    mainViewModel: MainViewModel = viewModel(),
    onTransactionConfirmedClicked: () -> Unit = {},
    onTransactionCancelledClicked: () -> Unit = {}
) {
    var transactionType by remember { mutableStateOf("Receita") }
    var amount by remember { mutableStateOf("") }
    var selectedCategory by remember { mutableStateOf("") }
    val categories = listOf("Mercado", "Saúde", "Lazer", "Contas")

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // Header with close and confirm icons
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 16.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(onClick = onTransactionCancelledClicked) {
                Icon(imageVector = Icons.Default.Close, contentDescription = "Cancelar")
            }
            IconButton(onClick = {
                mainViewModel.addTransaction(transactionType, amount.toDoubleOrNull() ?: 0.0, selectedCategory)
                onTransactionConfirmedClicked()
            }) {
                Icon(imageVector = Icons.Default.Check, contentDescription = "Confirmar")
            }
        }

        // SubHeader for selecting transaction type
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 16.dp),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            TextButton(onClick = { transactionType = "Receita" }) {
                Text(text = "Receita", fontSize = 18.sp, color = if (transactionType == "Receita") MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.onSurface)
            }
            TextButton(onClick = { transactionType = "Despesa" }) {
                Text(text = "Despesa", fontSize = 18.sp, color = if (transactionType == "Despesa") MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.onSurface)
            }
        }

        // Numeric field for amount
        OutlinedTextField(
            value = amount,
            onValueChange = { amount = it },
            label = { Text("Valor (R$)") },
            singleLine = true,
            keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Number),
            modifier = Modifier.fillMaxWidth()
        )

        Spacer(modifier = Modifier.height(8.dp))

        // Dropdown for categories if the transaction type is expense
        if (transactionType == "Despesa") {
            var expanded by remember { mutableStateOf(false) }

            Box(modifier = Modifier.fillMaxWidth()) {
                OutlinedTextField(
                    value = selectedCategory,
                    onValueChange = { selectedCategory = it },
                    label = { Text("Categoria") },
                    readOnly = true,
                    modifier = Modifier.fillMaxWidth().clickable { expanded = true }
                )
                DropdownMenu(
                    expanded = expanded,
                    onDismissRequest = { expanded = false },
                    modifier = Modifier.fillMaxWidth()
                ) {
                    categories.forEach { category ->
                        DropdownMenuItem(
                            text = { Text(category) },
                            onClick = {
                                selectedCategory = category
                                expanded = false
                            }
                        )
                    }
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun TransactionScreenPreview() {
    WalletAppTheme {
        TransactionScreen()
    }
}
