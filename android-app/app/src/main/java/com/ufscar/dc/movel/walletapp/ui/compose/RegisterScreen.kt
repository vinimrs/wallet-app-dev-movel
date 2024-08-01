package com.ufscar.dc.movel.walletapp.ui.compose

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.style.TextDecoration
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
fun RegisterScreen(
    mainViewModel: MainViewModel = viewModel(),
    onRegisterClicked: () -> Unit = {},
    onLoginButtonClicked: () -> Unit = {}
) {
    var name by remember { mutableStateOf("") }
    var email by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    val greenColor = Color(0xFF01AA71)

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Icon(
            imageVector = Icons.Default.Person,
            contentDescription = stringResource(id = R.string.user_icon),
            modifier = Modifier.size(64.dp),
            tint = greenColor
        )
        Spacer(modifier = Modifier.height(16.dp))
        Text(text = stringResource(id = R.string.register), fontSize = 32.sp)
        Spacer(modifier = Modifier.height(16.dp))
        OutlinedTextField(
            value = name,
            onValueChange = { name = it },
            label = { Text(stringResource(id = R.string.name)) },
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )
        Spacer(modifier = Modifier.height(8.dp))
        OutlinedTextField(
            value = email,
            onValueChange = { email = it },
            label = { Text(stringResource(id = R.string.email)) },
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )
        Spacer(modifier = Modifier.height(8.dp))
        OutlinedTextField(
            value = password,
            onValueChange = { password = it },
            label = { Text(stringResource(id = R.string.password)) },
            singleLine = true,
            visualTransformation = PasswordVisualTransformation(),
            modifier = Modifier.fillMaxWidth()
        )
        Spacer(modifier = Modifier.height(8.dp))

        TextButton(onClick = {
            onLoginButtonClicked()
        }) {
            Text(text = stringResource(id = R.string.already_have_account), color = greenColor)
            Text(text = stringResource(id = R.string.login), textDecoration = TextDecoration.Underline, color = greenColor)
        }
        Spacer(modifier = Modifier.height(16.dp))
        Button(
            colors = ButtonDefaults.buttonColors(greenColor),
            onClick = {
                CoroutineScope(Dispatchers.Main).launch {
                    mainViewModel.register(name, email, password)
                    delay(1000)
                    if(mainViewModel.errorMessage.isEmpty())
                        onRegisterClicked()
                }
            },
            modifier = Modifier
                .fillMaxWidth()
                .height(48.dp),
            shape = RoundedCornerShape(8.dp),
        ) {
            Text(text = stringResource(id = R.string.register), fontSize = 16.sp)
        }
    }
}

@Preview(showBackground = true)
@Composable
fun RegisterScreenPreview() {
    WalletAppTheme {
        RegisterScreen()
    }
}
