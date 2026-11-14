package com.jiu_jitsu_para_todos

import android.content.ContentValues
import android.content.Context
import android.os.Environment
import android.provider.MediaStore
import androidx.annotation.Keep
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URI

/**
 * Baixa um PDF e salva na pasta Downloads pela MediaStore (Android 10+),
 * sem precisar de permissão de armazenamento. Chamado direto do Dart via
 * bindings JNIgen (lib/src/modules/rules/data/), sem MethodChannel.
 */
@Keep
class PdfDownloader(private val context: Context) {

    suspend fun saveToDownloads(url: String, fileName: String) {
        withContext(ioDispatcher) {
            val resolver = context.contentResolver
            val values = ContentValues().apply {
                put(MediaStore.Downloads.DISPLAY_NAME, fileName)
                put(MediaStore.Downloads.MIME_TYPE, "application/pdf")
                put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
                put(MediaStore.Downloads.IS_PENDING, 1)
            }
            val item = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
                ?: throw IOException("Não foi possível criar o arquivo em Downloads")

            try {
                val connection = URI(url).toURL().openConnection() as HttpURLConnection
                connection.connectTimeout = 15_000
                connection.readTimeout = 30_000
                try {
                    val output = resolver.openOutputStream(item)
                        ?: throw IOException("Não foi possível abrir o arquivo em Downloads")
                    output.use { out ->
                        connection.inputStream.use { input -> input.copyTo(out) }
                    }
                } finally {
                    connection.disconnect()
                }
                values.clear()
                values.put(MediaStore.Downloads.IS_PENDING, 0)
                resolver.update(item, values, null, null)
            } catch (e: Exception) {
                resolver.delete(item, null, null) // não deixa arquivo pela metade
                throw e
            }
        }
    }

    private companion object {
        // Ver WallpaperSetter: o continuation do package:jni já declara
        // Dispatchers.IO, então é preciso um dispatcher diferente para que o
        // withContext troque de fato de thread (senão roda na main).
        val ioDispatcher = Dispatchers.IO.limitedParallelism(2)
    }
}
