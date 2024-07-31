package com.ufscar.dc.movel.walletapp.repository.common

import com.ufscar.dc.movel.walletapp.repository.dto.LoginUserData
import com.ufscar.dc.movel.walletapp.repository.dto.LoginUserResponse
import com.ufscar.dc.movel.walletapp.repository.retrofit.UserInterface
import com.ufscar.dc.movel.walletapp.repository.retrofit.RetrofitInstance

class UserRepository(
    private val test: Boolean = true
) {
    private lateinit var client: UserInterface

    init {
        if (test)
            client = RetrofitInstance.testApi
        else
            client = RetrofitInstance.api
    }


    suspend fun addUser(user: User): LoginUserResponse = client.addUser(user)

    suspend fun deleteUser(id: Long) = client.deleteUser(id)

    suspend fun login(email: String, password: String): LoginUserResponse = client.login(LoginUserData(email, password))

}