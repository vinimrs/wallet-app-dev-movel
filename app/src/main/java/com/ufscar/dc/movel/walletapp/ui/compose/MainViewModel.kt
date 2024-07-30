package com.ufscar.dc.movel.walletapp.ui.compose

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.ufscar.dc.movel.walletapp.repository.common.Board
import com.ufscar.dc.movel.walletapp.repository.common.BoardRepository
import com.ufscar.dc.movel.walletapp.repository.common.Message
import kotlinx.coroutines.launch

class MainViewModel : ViewModel() {
    private val repository = BoardRepository()

    var email by mutableStateOf("")
    var password by mutableStateOf("")
    var name by mutableStateOf("")
    var amount by mutableStateOf(0.0)
    var transactionType by mutableStateOf("")
    var selectedCategory by mutableStateOf("")

    var numberOfBoardsMsg by mutableStateOf("")
    var boards = mutableStateListOf<Board>()
    var messages = mutableStateListOf<Message>()
    var showNetworkErrorSnackBar by mutableStateOf(false)

    var msg_boardID by mutableStateOf("")
    var msg_boardIdError by mutableStateOf(false)
    var errorMessage = ""

    fun login(email1: String, password1: String) {
        viewModelScope.launch {
            email = email1
            password = password1
//            repository.login(username, password)
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

    fun getBoards() {
        viewModelScope.launch {
            try {
                val rBoards = repository.getBoards()
                numberOfBoardsMsg = "#Boards: " + rBoards.size
                boards.clear()
                rBoards.forEach { boards.add(it) }
            } catch (e: Exception) {
                numberOfBoardsMsg = ""
                boards.clear()
                showNetworkErrorSnackBar = true
            }
        }
        numberOfBoardsMsg = "loading..."
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

    fun loadMessages() {
        if (validateBoardId()) {
            viewModelScope.launch {
                val rMessages = repository.getMessages(msg_boardID.toLong())
                messages.clear()
                rMessages.forEach {
                    messages.add(it)
                }
            }
        }
    }

    fun postMessage(boardId: String, from: String, to: String, text: String) {
        viewModelScope.launch {
            val newMsg = Message(from, to, text)
            repository.postMessage(boardId.toLong(), newMsg)
        }
    }
}