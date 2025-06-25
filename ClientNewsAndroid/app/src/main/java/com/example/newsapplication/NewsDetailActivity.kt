package com.example.newsapplication

import android.os.Bundle
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import coil.load
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class NewsDetailActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_news_detail)

        val ivImage = findViewById<ImageView>(R.id.detailImage)
        val tvTitle = findViewById<TextView>(R.id.detailTitle)
        val tvCategory = findViewById<TextView>(R.id.detailCategory)
        val tvDate = findViewById<TextView>(R.id.detailDate)
        val tvContent = findViewById<TextView>(R.id.detailContent)

        val newsId = intent.getIntExtra("news_id", -1)
        if (newsId == -1) return finish()

        RetrofitClient.instance.getNewsDetail(newsId)
            .enqueue(object: Callback<NewsDetail> {
                override fun onResponse(call: Call<NewsDetail>, response: Response<NewsDetail>) {
                    val d = response.body() ?: return
                    ivImage.load(d.image_url) {
                        placeholder(R.drawable.ic_launcher_foreground)
                    }
                    tvTitle.text = d.title
                    tvCategory.text = d.category
                    tvDate.text = d.created_at
                    tvContent.text = d.content
                }
                override fun onFailure(call: Call<NewsDetail>, t: Throwable) {}
            })
    }
}