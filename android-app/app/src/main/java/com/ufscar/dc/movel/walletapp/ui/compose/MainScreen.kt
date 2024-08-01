package com.ufscar.dc.movel.walletapp.ui.compose

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ShoppingCart
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.ufscar.dc.movel.walletapp.R
import com.ufscar.dc.movel.walletapp.ui.theme.WalletAppTheme
import androidx.compose.ui.tooling.preview.Preview
import java.text.NumberFormat
import java.util.Locale
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MainScreen(
    viewModel: MainViewModel = viewModel(),
    onNewTransactionClicked: () -> Unit = {},
    onLogoutClicked: () -> Unit = {}
) {
    val moeda = stringResource(id = R.string.coin)
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(text = "${stringResource(id = R.string.greeting)}, ${viewModel.getUserName()}", fontSize = 16.sp, fontWeight = FontWeight.Bold)
            Button(
                colors = ButtonDefaults.buttonColors(Color(0xFF01AA71)),
                onClick = {
                    viewModel.logout()
                    onLogoutClicked()
                },
            ) {
                Text(text = stringResource(id = R.string.logout))
            }
        }
        Spacer(modifier = Modifier.height(16.dp))

        Text(
            modifier = Modifier.align(Alignment.CenterHorizontally),
            text = stringResource(id = R.string.balance), fontSize = 18.sp, fontWeight = FontWeight.Bold, textAlign = TextAlign.Center)

        Spacer(modifier = Modifier.height(8.dp))

        Card(
            modifier = Modifier
                .width(200.dp)
                .align(Alignment.CenterHorizontally),
            shape = RoundedCornerShape(8.dp),
            colors = CardDefaults.cardColors(
                containerColor = Color(0xFF01AA71)
            ),
        ) {
            Text(
                text = "${moeda} ${NumberFormat.getNumberInstance(Locale("pt", "BR")).format(viewModel.userData.planning.balance)}",
                modifier = Modifier
                    .padding(16.dp)
                    .align(Alignment.CenterHorizontally),
                color = Color.White,
                fontSize = 24.sp,
            )
        }

        Spacer(modifier = Modifier.height(16.dp))

        Text(text = stringResource(id = R.string.overview), fontSize = 18.sp, fontWeight = FontWeight.Bold)

        Spacer(modifier = Modifier.height(8.dp))

        LazyColumn(
            modifier = Modifier.weight(1f)
        ) {
            items(viewModel.userData.planning.transactions) { transaction ->
                RecentItem(
                    category = transaction.category + " - " + transaction.description,
                    amount = if (transaction.value < 0) "- ${moeda} ${NumberFormat.getNumberInstance(Locale("pt", "BR")).format(transaction.value + 2*(-transaction.value))}"
                    else "+ ${moeda} ${NumberFormat.getNumberInstance(Locale("pt", "BR")).format(transaction.value)}",
                    date = transaction.date,
                    iconColor = if (transaction.expense) Color.Red else Color.Green
                )
                Spacer(modifier = Modifier.height(8.dp))
            }
        }

        Spacer(modifier = Modifier.height(8.dp))

        Button(
            onClick = { onNewTransactionClicked() },
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp),
            colors = ButtonDefaults.buttonColors(Color(0xFF01AA71)),
            shape = RoundedCornerShape(8.dp)
        ) {
            Text(stringResource(id = R.string.new_transaction), color = Color.White)
        }
    }
}

@Composable
fun RecentItem(category: String, amount: String, date: String, iconColor: Color) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(8.dp)
    ) {
        Icon(
            imageVector = Icons.Default.ShoppingCart,
            contentDescription = category,
            tint = iconColor,
            modifier = Modifier.size(32.dp)
        )
        Spacer(modifier = Modifier.width(8.dp))
        Column {
            Text(text = category, fontWeight = FontWeight.Bold)
            Text(text = date, color = Color.Gray)
        }
        Spacer(modifier = Modifier.weight(1f))
        Text(text = amount,
            color = if (amount.startsWith("-")) Color.Red else Color.Green)
    }
}

@Preview(showBackground = true)
@Composable
fun MainScreenPreview() {
    WalletAppTheme {
        MainScreen()
    }
}
