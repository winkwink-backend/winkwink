allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://jitpack.io") }
    }
}

val customBuildDir: File = rootProject.layout.buildDirectory.asFile.get().resolve("../../build")

subprojects {
    val newSubprojectBuildDir = customBuildDir.resolve(project.name)
    project.layout.buildDirectory.value(
        project.layout.projectDirectory.dir(newSubprojectBuildDir.absolutePath)
    )
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(customBuildDir)
}