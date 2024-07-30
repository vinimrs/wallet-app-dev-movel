package com.ufscar.dc.movel.walletapp.repository.retrofit

import com.ufscar.dc.movel.walletapp.repository.common.GeneralResponse
import com.ufscar.dc.movel.walletapp.repository.common.User
import retrofit2.http.Body
import retrofit2.http.DELETE
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Path


interface UserInterface {

    @GET("users")
    suspend fun getUsers() : List<User>

    @POST("users")
    suspend fun addUser(@Body user: User): User

    @GET("login")
    suspend fun login(@Body email: String, @Body password: String): GeneralResponse

    @GET("users/{id}")
    suspend fun getUser(@Path("id") id: Long): User

    @DELETE("users/{id}")
    suspend fun deleteUser(@Path("id") id: Long): GeneralResponse

    // only for testing
    @GET("reset")
    suspend fun reset(): GeneralResponse

}