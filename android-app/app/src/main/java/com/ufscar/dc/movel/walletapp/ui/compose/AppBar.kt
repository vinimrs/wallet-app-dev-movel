package com.ufscar.dc.movel.walletapp.ui.compose

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.ufscar.dc.movel.walletapp.R
import com.ufscar.dc.movel.walletapp.ui.theme.Green40
import com.ufscar.dc.movel.walletapp.util.LocaleUtils
import kotlinx.coroutines.launch

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AppBar(
    canNavigateBack: Boolean,
    navigateUp: () -> Unit,
    modifier: Modifier = Modifier
) {
    val coroutineScope = rememberCoroutineScope()
    val context = LocalContext.current
    TopAppBar(
        title = { Text(stringResource(id = R.string.app_name)) },
        colors = TopAppBarDefaults.mediumTopAppBarColors(
            containerColor = Green40
        ),
        modifier = modifier,
        navigationIcon = {
            if (canNavigateBack) {
                IconButton(onClick = navigateUp) {
                    Icon(
                        imageVector = Icons.Filled.ArrowBack,
                        contentDescription = stringResource(id = R.string.back)
                    )
                }
            }
        },
        actions = {
            LanguageDropdownMenu(onLocaleChange = { languageCode ->
                coroutineScope.launch {
                    LocaleUtils.setLocale(context, languageCode)
                }
            })
        }
    )
}

@Composable
fun LanguageDropdownMenu(onLocaleChange: (String) -> Unit) {
    var expanded by remember { mutableStateOf(false) }
    val languages = listOf(
        "pt" to R.drawable.ic_brazil_flag,
        "en" to R.drawable.ic_us_flag
    )
    var selectedLanguage by remember { mutableStateOf("en") }

    Box(modifier = Modifier.wrapContentSize(Alignment.TopEnd)) {
        IconButton(onClick = { expanded = true }) {
            Image(
                painter = painterResource(id = if (selectedLanguage == "pt") R.drawable.ic_brazil_flag else R.drawable.ic_us_flag),
                contentDescription = stringResource(id = R.string.change_language),
                modifier = Modifier
                    .size(24.dp)
                    .clip(CircleShape)
            )
        }
        DropdownMenu(
            expanded = expanded,
            onDismissRequest = { expanded = false }
        ) {
            languages.forEach { (code, flag) ->
                DropdownMenuItem(
                    text = {
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Image(
                                painter = painterResource(id = flag),
                                contentDescription = if (code == "pt") "Português" else "English",
                                modifier = Modifier.size(24.dp)
                            )
                            Spacer(modifier = Modifier.width(8.dp))
                            Text(text = if (code == "pt") "Português" else "English")
                        }
                    },
                    onClick = {
                        onLocaleChange(code)
                        selectedLanguage = code
                        expanded = false
                    }
                )
            }
        }
    }
}
