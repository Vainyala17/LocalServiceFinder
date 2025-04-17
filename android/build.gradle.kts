// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    repositories {
        google()  // ✅ Required for Firebase
        mavenCentral()
        maven { url = uri("https://maven.google.com") }
    }
    dependencies {
        classpath("com.google.gms:google-services:4.3.15") // ✅ Google Services Plugin
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://jitpack.io") }
    }
}

// Define a new build directory
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

// Task to clean the build directory
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
