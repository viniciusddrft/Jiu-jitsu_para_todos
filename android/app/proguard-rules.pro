# Regras para evitar remoção de classes necessárias, copiadas do missing_rules.txt
-dontwarn org.conscrypt.Conscrypt
-dontwarn org.conscrypt.OpenSSLProvider


# O google_mobile_ads traz androidx.work 2.7 + Room 2.2.5, cuja regra de
# consumidor (`-keep class * extends RoomDatabase`) não mantém o construtor.
# Com o R8 em full mode o construtor some e o WorkManager crasha no startup
# ("Failed to create an instance of androidx.work.impl.WorkDatabase").
-keep class * extends androidx.room.RoomDatabase { <init>(); }
-keep class * extends androidx.work.ListenableWorker {
    <init>(android.content.Context, androidx.work.WorkerParameters);
}
