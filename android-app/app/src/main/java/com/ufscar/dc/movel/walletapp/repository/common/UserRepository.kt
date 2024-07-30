package com.ufscar.dc.movel.walletapp.repository.common

import com.ufscar.dc.movel.walletapp.repository.retrofit.UserInterface
import com.ufscar.dc.movel.walletapp.repository.retrofit.RetrofitInstance

class UserRepository(
    private val test: Boolean = false
) {
    private lateinit var client: UserInterface

    init {
        if (test)
            client = RetrofitInstance.testApi
        else
            client = RetrofitInstance.api
    }

    suspend fun getUsers(): List<User> = client.getUsers()

    suspend fun addUser(board: User) = client.addUser(board)

    suspend fun deleteUser(id: Long) = client.deleteUser(id)

    suspend fun login(email: String, password: String): GeneralResponse = client.login(email, password)
}