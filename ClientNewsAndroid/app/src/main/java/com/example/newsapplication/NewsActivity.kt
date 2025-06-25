package com.example.newsapplication

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Spinner
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class NewsActivity : AppCompatActivity() {
    private lateinit var recyclerView: RecyclerView
    private lateinit var spinner: Spinner
    private var categories: List<Category> = emptyList()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_news)

        recyclerView = findViewById(R.id.recyclerNews)
        spinner = findViewById(R.id.spinnerCategory)
        recyclerView.layoutManager = LinearLayoutManager(this)

        loadCategories()
    }

    private fun loadCategories() {
        RetrofitClient.instance.getCategories().enqueue(object: Callback<List<Category>> {
            override fun onResponse(call: Call<List<Category>>, response: Response<List<Category>>) {
                if (response.isSuccessful) {
                    categories = listOf(Category(0, "All")) + response.body().orEmpty()
                    val adapter = ArrayAdapter(
                        this@NewsActivity,
                        android.R.layout.simple_spinner_item,
                        categories.map { it.name }
                    )
                    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
                    spinner.adapter = adapter

                    spinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                        override fun onItemSelected(parent: AdapterView<*>, view: View?, position: Int, id: Long) {
                            val catId = categories[position].id
                            loadNews(catId)
                        }
                        override fun onNothingSelected(parent: AdapterView<*>) {}
                    }
                } else Toast.makeText(this@NewsActivity, "Failed to load categories", Toast.LENGTH_SHORT).show()
            }
            override fun onFailure(call: Call<List<Category>>, t: Throwable) {}
        })
    }

    private fun loadNews(categoryId: Int) {
        RetrofitClient.instance.getNews(if (categoryId == 0) null else categoryId)
            .enqueue(object: Callback<List<NewsItem>> {
                override fun onResponse(call: Call<List<NewsItem>>, response: Response<List<NewsItem>>) {
                    if (response.isSuccessful) {
                        recyclerView.adapter = NewsAdapter(response.body().orEmpty()) {
                            val intent = Intent(this@NewsActivity, NewsDetailActivity::class.java)
                            intent.putExtra("news_id", it.id)
                            startActivity(intent)
                        }
                    } else Toast.makeText(this@NewsActivity, "Failed to load news", Toast.LENGTH_SHORT).show()
                }
                override fun onFailure(call: Call<List<NewsItem>>, t: Throwable) {}
            })
    }
}