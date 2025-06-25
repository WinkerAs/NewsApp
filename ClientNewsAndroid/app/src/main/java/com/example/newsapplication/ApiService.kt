package com.example.newsapplication

import retrofit2.Call
import retrofit2.http.*

data class UserResponse(val status: String, val user_id: Int?)
data class Category(val id: Int, val name: String)

data class NewsItem(
    val id: Int,
    val title: String,
    val image_url: String?,
    val created_at: String,
    val category: String
)

data class NewsDetail(
    val id: Int,
    val title: String,
    val content: String,
    val image_url: String?,
    val created_at: String,
    val category: String
)
interface ApiService {
    @POST("api.php?action=register")
    fun register(@Body params: Map<String, String>): Call<UserResponse>

    @POST("api.php?action=login")
    fun login(@Body params: Map<String, String>): Call<UserResponse>

    @GET("api.php?action=categories")
    fun getCategories(): Call<List<Category>>

    @GET("api.php?action=news")
    fun getNews(@Query("category_id") categoryId: Int?): Call<List<NewsItem>>

    @GET("api.php?action=news_detail")
    fun getNewsDetail(@Query("id") id: Int): Call<NewsDetail>
}