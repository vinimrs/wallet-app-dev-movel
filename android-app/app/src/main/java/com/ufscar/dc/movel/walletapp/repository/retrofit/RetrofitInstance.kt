package com.ufscar.dc.movel.walletapp.repository.retrofit

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object RetrofitInstance {
    private
    const val BASE_URL = "http://10.0.2.2:3000/"
    const val TO_TEST_URL = "http://localhost:3000/"

    val api: UserInterface by lazy {
        val retrofit = Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()

        retrofit.create(UserInterface::class.java)
    }

    val testApi: UserInterface by lazy {
        val retrofit = Retrofit.Builder()
            .baseUrl(TO_TEST_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()

        retrofit.create(UserInterface::class.java)
    }
}