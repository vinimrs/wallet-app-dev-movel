package com.ufscar.dc.movel.walletapp.repository.retrofit

import com.ufscar.dc.movel.walletapp.repository.common.GeneralResponse
import com.ufscar.dc.movel.walletapp.repository.common.Transaction
import com.ufscar.dc.movel.walletapp.repository.common.User
import com.ufscar.dc.movel.walletapp.repository.dto.LoginUserData
import com.ufscar.dc.movel.walletapp.repository.dto.LoginUserResponse
import retrofit2.http.Body
import retrofit2.http.DELETE
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Path


interface UserInterface {

    @GET("users")
    suspend fun getUsers() : List<User>

    @POST("users")
    suspend fun addUser(@Body user: User): LoginUserResponse

    @POST("login")
    suspend fun login(@Body loginUserData: LoginUserData): LoginUserResponse

    @GET("users/{id}")
    suspend fun getUser(@Path("id") id: Long): User

    @DELETE("users/{id}")
    suspend fun deleteUser(@Path("id") id: Long): GeneralResponse

    // only for testing
    @GET("reset")
    suspend fun reset(): GeneralResponse

    @POST("users/{id}/transactions")
    suspend fun addTransaction(@Body transaction: Transaction, @Path("id") id: Int): LoginUserResponse

}