package com.jiu_jitsu_para_todos

import android.app.WallpaperManager
import android.content.Context
import androidx.annotation.Keep
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.net.HttpURLConnection
import java.net.URI

/**
 * Define o papel de parede a partir de uma URL. Chamado direto do Dart via
 * bindings JNIgen (lib/src/shared/plugins/wallpaper/bindings/), sem
 * MethodChannel. A `suspend fun` vira um `Future` no Dart.
 */
@Keep
class WallpaperSetter(private val context: Context) {

    suspend fun setFromUrl(url: String, home: Boolean, lock: Boolean) {
        require(home || lock) { "Informe ao menos um destino (home/lock)" }
        val flags = (if (home) WallpaperManager.FLAG_SYSTEM else 0) or
            (if (lock) WallpaperManager.FLAG_LOCK else 0)

        withContext(ioDispatcher) {
            val connection = URI(url).toURL().openConnection() as HttpURLConnection
            connection.connectTimeout = 15_000
            connection.readTimeout = 30_000
            try {
                connection.inputStream.use { stream ->
                    WallpaperManager.getInstance(context).setStream(stream, null, true, flags)
                }
            } finally {
                connection.disconnect()
            }
        }
    }

    private companion object {
        // Não usar `Dispatchers.IO` direto: o continuation que o package:jni
        // passa já declara `Dispatchers.IO` como contexto, então o
        // `withContext(Dispatchers.IO)` rodaria "undispatched" na thread que
        // chamou (a main/UI) e daria NetworkOnMainThreadException. Uma view
        // própria do IO é um dispatcher diferente e força a troca de thread.
        val ioDispatcher = Dispatchers.IO.limitedParallelism(2)
    }
}
