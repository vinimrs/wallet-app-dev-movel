package com.ufscar.dc.movel.walletapp.ui.compose

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.res.stringResource
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.ufscar.dc.movel.walletapp.R
import com.ufscar.dc.movel.walletapp.repository.common.Transaction
import com.ufscar.dc.movel.walletapp.repository.common.User
import com.ufscar.dc.movel.walletapp.repository.common.UserRepository
import kotlinx.coroutines.launch

class MainViewModel : ViewModel() {
    private val repository = UserRepository(test = false)

    var email by mutableStateOf("")
    var password by mutableStateOf("")
    var name by mutableStateOf("")
    var amount by mutableStateOf(0.0)
    var transactionType by mutableStateOf("")
    var selectedCategory by mutableStateOf("")

    val incomeString = R.string.income.toString()
    val expenseString = R.string.expense.toString()

    var userData: User by mutableStateOf(User())
    var showNetworkErrorSnackBar by mutableStateOf(false)

    var msg_boardID by mutableStateOf("")
    var msg_boardIdError by mutableStateOf(false)
    var errorMessage by mutableStateOf("")

    fun login(email1: String, password1: String) {
        viewModelScope.launch {
            email = email1
            password = password1
            try {
                val response = repository.login(email1, password1)
                if(response.success) {
                    showNetworkErrorSnackBar = false
                    errorMessage = ""
                    userData = response.user
                } else {
                    errorMessage = response.message
                    showNetworkErrorSnackBar = true
                }
            } catch (e: Exception) {
                errorMessage = e.message ?: "Unknown error"
                showNetworkErrorSnackBar = true
                if(e.message!!.contains("404"))
                    errorMessage = "E-mail ou senha inválidos"
            }
        }
    }

    fun register(name1: String, email1: String, password1: String) {
        viewModelScope.launch {
            email = email1
            password = password1
            name = name1
            try {
                val response = repository.addUser(User(name = name1, email = email1, password = password1))
                if(response.success) {
                    showNetworkErrorSnackBar = false
                    errorMessage = ""
                    userData = response.user
                } else {
                    errorMessage = response.message
                    showNetworkErrorSnackBar = true
                }
            } catch (e: Exception) {
                errorMessage = e.message ?: "Unknown error"
                showNetworkErrorSnackBar = true
                if(e.message!!.contains("400"))
                    errorMessage = "Usuário já existe"
            }
        }
    }

    fun logout() {
        viewModelScope.launch {
            userData = User()
//            repository.logout()
        }
    }

    fun getUserName(): String {
        return email
    }

    fun addTransaction (transactionType1: String, amount1: Double, selectedCategory1: String, description: String){
        viewModelScope.launch {
            try {
                val response = repository.addTransaction(Transaction(value = if (transactionType1 == incomeString) amount1 else -amount1,
                    description = description,
                    category = selectedCategory1), userData.id)
                if(response.success) {
                    showNetworkErrorSnackBar = false
                    errorMessage = ""
                    userData = response.user
                } else {
                    errorMessage = response.message
                    showNetworkErrorSnackBar = true
                }
            } catch (e: Exception) {
                errorMessage = e.message ?: "Unknown error"
                showNetworkErrorSnackBar = true
            }
        }
    }

    fun dismissNetworkErrorSnackBar() {
        showNetworkErrorSnackBar = false
    }

    private fun validateBoardId(): Boolean {
        val boardId = runCatching { msg_boardID.toLong() }.getOrNull()
        if (boardId == null) {
            msg_boardIdError = true
            errorMessage = "Board ID should be an integer"
            return false
        } else {
            msg_boardIdError = false
            return true
        }
    }

}