package com.example.newsapplication

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class LoginActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        val etUser = findViewById<EditText>(R.id.etUsername)
        val etPass = findViewById<EditText>(R.id.etPassword)
        findViewById<Button>(R.id.btnLogin).setOnClickListener {
            val user = etUser.text.toString()
            val pass = etPass.text.toString()
            RetrofitClient.instance.login(mapOf("username" to user, "password" to pass))
                .enqueue(object: Callback<UserResponse> {
                    override fun onResponse(call: Call<UserResponse>, response: Response<UserResponse>) {
                        if (response.isSuccessful && response.body()?.status == "success") {
                            val intent = Intent(this@LoginActivity, NewsActivity::class.java)
                            startActivity(intent)
                            finish()
                        } else Toast.makeText(this@LoginActivity, "Login failed", Toast.LENGTH_SHORT).show()
                    }
                    override fun onFailure(call: Call<UserResponse>, t: Throwable) {}
                })
        }
        findViewById<Button>(R.id.btnRegister).setOnClickListener {
            startActivity(Intent(this, RegisterActivity::class.java))
        }
    }
}