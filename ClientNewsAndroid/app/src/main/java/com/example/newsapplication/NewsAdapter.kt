package com.example.newsapplication

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView
import coil.load

class NewsAdapter(
    private val items: List<NewsItem>,
    private val click: (NewsItem) -> Unit
) : RecyclerView.Adapter<NewsAdapter.VH>() {

    inner class VH(view: View): RecyclerView.ViewHolder(view) {
        val card: CardView = view.findViewById(R.id.card)
        val image: ImageView = view.findViewById(R.id.newsImage)
        val title: TextView = view.findViewById(R.id.newsTitle)
        val date: TextView = view.findViewById(R.id.newsDate)
        val category: TextView = view.findViewById(R.id.newsCategory)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = VH(
        LayoutInflater.from(parent.context).inflate(R.layout.item_news, parent, false)
    )

    override fun getItemCount() = items.size

    override fun onBindViewHolder(holder: VH, position: Int) {
        val item = items[position]
        holder.title.text = item.title
        holder.date.text = item.created_at
        holder.category.text = item.category

        // Load image with Coil
        holder.image.load(item.image_url) {
            placeholder(R.drawable.ic_launcher_foreground)
            error(com.google.android.material.R.drawable.mtrl_ic_error)
        }

        holder.card.setOnClickListener { click(item) }
    }
}