package com.ufscar.dc.movel.walletapp.ui.compose

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.ufscar.dc.movel.walletapp.repository.common.User
import com.ufscar.dc.movel.walletapp.repository.common.UserRepository
import kotlinx.coroutines.launch

class MainViewModel : ViewModel() {
    private val repository = UserRepository()

    var email by mutableStateOf("")
    var password by mutableStateOf("")
    var name by mutableStateOf("")
    var amount by mutableStateOf(0.0)
    var transactionType by mutableStateOf("")
    var selectedCategory by mutableStateOf("")

    var numberOfBoardsMsg by mutableStateOf("")
    var users = mutableStateListOf<User>()
    var showNetworkErrorSnackBar by mutableStateOf(false)

    var msg_boardID by mutableStateOf("")
    var msg_boardIdError by mutableStateOf(false)
    var errorMessage = ""

    fun login(email1: String, password1: String) {
        viewModelScope.launch {
            email = email1
            password = password1
            repository.login(email, password)
        }
    }

    fun logout() {
        viewModelScope.launch {
            email = ""
            password = ""
//            repository.logout()
        }
    }

    fun register(name1: String, email1: String, password1: String) {
        viewModelScope.launch {
            email = email1
            password = password1
            name = name1
//            repository.register(username, password)
        }
    }

    fun getUserName(): String {
        return email
    }

    fun addTransaction (transactionType1: String, amount1: Double, selectedCategory1: String){
        viewModelScope.launch {
            amount = amount1
            transactionType = transactionType1
            selectedCategory = selectedCategory1
//            repository.addTransaction(transactionType, amount, selectedCategory)
        }
    }

    fun dismissNetworkErrorSnackBar() {
        showNetworkErrorSnackBar = false
    }

    fun updateMsg_boardID(s: String) {
        msg_boardID = s
        if (msg_boardID == "")
            return
        validateBoardId()
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