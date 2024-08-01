package com.ufscar.dc.movel.walletapp.ui.compose

import androidx.compose.foundation.background
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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.ufscar.dc.movel.walletapp.R
import com.ufscar.dc.movel.walletapp.ui.theme.WalletAppTheme
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

@Composable
fun TransactionScreen(
    mainViewModel: MainViewModel = viewModel(),
    onTransactionConfirmedClicked: () -> Unit = {},
    onTransactionCancelledClicked: () -> Unit = {}
) {
    var amount by remember { mutableStateOf("") }
    var description by remember { mutableStateOf("") }
    val greenColor = Color(0xFF01AA71)
    val incomeString = stringResource(id = R.string.income)
    val expenseString = stringResource(id = R.string.expense)
    var selectedCategory by remember { mutableStateOf(incomeString) }
    var transactionType by remember { mutableStateOf(incomeString) }
    val categories = listOf(
        stringResource(id = R.string.market),
        stringResource(id = R.string.health),
        stringResource(id = R.string.leisure),
        stringResource(id = R.string.bills)
    )

    Column(
        modifier = Modifier
            .fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .background(greenColor)
                .padding(vertical = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 0.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(onClick = onTransactionCancelledClicked) {
                    Icon(imageVector = Icons.Default.Close, contentDescription = stringResource(id = R.string.cancel), tint = Color.White)
                }
                Text(
                    text = stringResource(id = R.string.new_transaction),
                    fontSize = 24.sp,
                    color = Color.White
                )
                IconButton(onClick = {
                    CoroutineScope(Dispatchers.Main).launch {
                        mainViewModel.addTransaction(transactionType, amount.toDoubleOrNull() ?: 0.0,
                            selectedCategory, description, transactionType == incomeString)
                        delay(1000)
                        if(mainViewModel.errorMessage.isEmpty())
                            onTransactionConfirmedClicked()
                    }

                }) {
                    Icon(imageVector = Icons.Default.Check, contentDescription = stringResource(id = R.string.confirm), tint = Color.White)
                }
            }

            Spacer(modifier = Modifier.height(8.dp))
            Divider(color = Color.White, thickness = 1.dp)
            Spacer(modifier = Modifier.height(8.dp))

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                TextButton(onClick = { transactionType = incomeString
                    selectedCategory = incomeString
                }) {
                    Text(
                        text = incomeString,
                        fontSize = 18.sp,
                        color = if (transactionType == incomeString) Color.White else Color.Black
                    )
                }
                TextButton(onClick = { transactionType = expenseString
                    selectedCategory = ""
                }) {
                    Text(
                        text = expenseString,
                        fontSize = 18.sp,
                        color = if (transactionType == expenseString) Color.White else Color.Black
                    )
                }
            }
        }

        OutlinedTextField(
            value = description,
            onValueChange = { description = it },
            label = { Text(stringResource(id = R.string.description)) },
            singleLine = true,
            keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Text),
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp, vertical = 16.dp)
        )
        OutlinedTextField(
            value = amount,
            onValueChange = { amount = it },
            label = { Text(stringResource(id = R.string.amount)) },
            singleLine = true,
            keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Decimal),
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp, vertical = 16.dp)
        )

        if (transactionType == expenseString) {
            var expanded by remember { mutableStateOf(false) }

            Box(modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp)) {
                OutlinedTextField(
                    value = selectedCategory,
                    onValueChange = { selectedCategory = it },
                    label = { Text(stringResource(id = R.string.category)) },
                    readOnly = true,
                    modifier = Modifier.fillMaxWidth()
                )
                Box(
                    modifier = Modifier
                        .matchParentSize()
                        .clickable { expanded = true }
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
        } else {
            Box(modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp)) {
                OutlinedTextField(
                    value = incomeString,
                    onValueChange = { selectedCategory = it },
                    label = { Text(stringResource(id = R.string.category)) },
                    readOnly = true,
                    modifier = Modifier.fillMaxWidth()
                )
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
