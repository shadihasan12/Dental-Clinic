import java.util.Properties
import java.io.FileInputStream

// Release signing lives in android/key.properties, which is gitignored - the
// upload key must never be in the repo. A machine without that file (CI, a
// fresh clone) still builds debug and profile; only `release` needs it.
val keystoreProperties = Properties().apply {
    val f = rootProject.file("key.properties")
    if (f.exists()) load(FileInputStream(f))
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Resolves android/app/google-services.json at build time and bakes the
    // Firebase project config into the APK. Must come AFTER the android plugin.
    id("com.google.gms.google-services")
}

android {
    namespace = "tech.runbit.dentas"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Required by flutter_local_notifications (v21+): backports java.time
        // and other newer JDK APIs so the plugin runs on older Android.
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // Must match the package_name of the Android app registered in the
        // Firebase project, or the google-services plugin fails the build with
        // "No matching client found for package name".
        applicationId = "tech.runbit.dentas"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            // Left unconfigured when key.properties is absent; the release
            // build type below then falls back to debug signing rather than
            // failing the whole Gradle configuration phase.
            val storePath = keystoreProperties.getProperty("storeFile")
            if (storePath != null) {
                storeFile = file(storePath)
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            // A Play upload signed with the debug key is rejected, so the
            // real config is used whenever key.properties is present.
            signingConfig = if (keystoreProperties.getProperty("storeFile") != null) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            // Minify/shrink deliberately left off: enabling it needs keep
            // rules for Firebase and the notification plugins, and a wrong
            // rule fails at runtime in release only. Worth doing later, on
            // its own, with a real device test.
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Pairs with isCoreLibraryDesugaringEnabled above — supplies the
    // backported JDK APIs flutter_local_notifications relies on.
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
