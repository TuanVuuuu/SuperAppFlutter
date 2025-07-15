# SETUP FLUTTER SUPER APP GUIDE

Hướng dẫn chi tiết từ Maven Local đến build và run Flutter Super App.

## 📋 Mục lục
1. [Cài đặt Maven Local](#1-cài-đặt-maven-local)
2. [Cấu hình Plugin Flutter](#2-cấu-hình-plugin-flutter)
3. [Build và Run Super App](#3-build-và-run-super-app)
4. [Troubleshooting](#4-troubleshooting)

---

## 1. Cài đặt Maven Local

### 1.1. Chuẩn bị file .aar
```bash
# Đảm bảo file .aar có trong thư mục
mini_app_flutter_sdk/android/libs/mini_app_android_sdk-release.aar
```

### 1.2. Tạo thư mục Maven
```bash
mkdir mini_app_android_sdk_maven
cp mini_app_flutter_sdk/android/libs/mini_app_android_sdk-release.aar mini_app_android_sdk_maven/
```

### 1.3. Tạo file pom.xml
Tạo file `mini_app_android_sdk_maven/pom.xml`:
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>mini_app_android_sdk</artifactId>
    <version>1.0.0</version>
    <packaging>aar</packaging>
    <name>Mini App Android SDK</name>
    <description>Mini App Android SDK as an AAR package</description>
</project>
```

### 1.4. Cài đặt vào Maven Local
```bash
cd mini_app_android_sdk_maven
mvn install:install-file \
  -Dfile=mini_app_android_sdk-release.aar \
  -DgroupId=com.example \
  -DartifactId=mini_app_android_sdk \
  -Dversion=1.0.0 \
  -Dpackaging=aar
```

### 1.5. Kiểm tra cài đặt
```bash
ls ~/.m2/repository/com/example/mini_app_android_sdk/1.0.0/
# Kết quả mong đợi:
# mini_app_android_sdk-1.0.0.aar
# mini_app_android_sdk-1.0.0.pom
```

---

## 2. Cấu hình Plugin Flutter

### 2.1. Sửa build.gradle của plugin
Mở file `mini_app_flutter_sdk/android/build.gradle`:

```groovy
allprojects {
    repositories {
        mavenLocal()  // Thêm dòng này
        google()
        mavenCentral()
    }
}

dependencies {
    // Thay thế dòng cũ:
    // implementation(name: 'mini_app_android_sdk-release', ext: 'aar')
    
    // Bằng dòng mới:
    implementation 'com.example:mini_app_android_sdk:1.0.0@aar'
}
```

### 2.2. Kiểm tra Plugin Implementation
Đảm bảo file `MiniAppFlutterSdkPlugin.kt` có đúng imports:

```kotlin
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
```

### 2.3. Cấu hình pubspec.yaml của plugin
Đảm bảo `mini_app_flutter_sdk/pubspec.yaml` có:

```yaml
plugin:
  platforms:
    android:
      package: com.example.mini_app_flutter_sdk
      pluginClass: MiniAppFlutterSdkPlugin
```

---

## 3. Build và Run Super App

### 3.1. Cấu hình Super App
Trong `super_app_flutter/pubspec.yaml`:

```yaml
dependencies:
  mini_app_flutter_sdk:
    path: ../mini_app_flutter_sdk
```

### 3.2. Clean và Get Dependencies
```bash
cd super_app_flutter
fvm flutter clean
fvm flutter pub get
```

### 3.3. Build APK
```bash
fvm flutter build apk
```

### 3.4. Run trên thiết bị
```bash
fvm flutter run
```

### 3.5. Test chức năng
- Mở app trên thiết bị
- Bấm nút "Mở Mini App"
- Kiểm tra log để đảm bảo không có lỗi

---

## 4. Troubleshooting

### 4.1. Lỗi "Could not find :mini_app_android_sdk-release"
**Nguyên nhân:** Chưa cài đúng Maven Local hoặc chưa thêm `mavenLocal()` vào repositories.

**Giải pháp:**
```bash
# Kiểm tra Maven Local
ls ~/.m2/repository/com/example/mini_app_android_sdk/1.0.0/

# Nếu chưa có, cài lại
cd mini_app_android_sdk_maven
mvn install:install-file \
  -Dfile=mini_app_android_sdk-release.aar \
  -DgroupId=com.example \
  -DartifactId=mini_app_android_sdk \
  -Dversion=1.0.0 \
  -Dpackaging=aar
```

### 4.2. Lỗi "NO_ACTIVITY, No activity attached"
**Nguyên nhân:** Plugin chưa implement `ActivityAware`.

**Giải pháp:** Đảm bảo plugin có đúng imports và implementation như hướng dẫn ở mục 2.2.

### 4.3. Lỗi "Unresolved reference: ActivityAware"
**Nguyên nhân:** Import sai package.

**Giải pháp:** Sử dụng imports đúng:
```kotlin
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
```

### 4.4. Lỗi NDK Version
**Nguyên nhân:** Khác version NDK giữa app và plugin.

**Giải pháp:** Thêm vào `super_app_flutter/android/app/build.gradle.kts`:
```kotlin
android {
    ndkVersion = "27.0.12077973"
}
```

### 4.5. Lỗi FVM/Dart
**Nguyên nhân:** Cache pub bị lỗi hoặc version không tương thích.

**Giải pháp:**
```bash
# Clean pub cache
rm -rf ~/.pub-cache

# Deactivate và activate lại FVM
dart pub global deactivate fvm
dart pub global activate fvm

# Clean và build lại
fvm flutter clean
fvm flutter pub get
fvm flutter build apk
```

---

## 5. Cấu trúc thư mục cuối cùng

```
SuperAppFlutter/
├── mini_app_android_sdk_maven/
│   ├── mini_app_android_sdk-release.aar
│   └── pom.xml
├── mini_app_flutter_sdk/
│   ├── android/
│   │   ├── build.gradle (đã cấu hình mavenLocal)
│   │   └── src/main/kotlin/.../MiniAppFlutterSdkPlugin.kt
│   └── pubspec.yaml
├── super_app_flutter/
│   ├── android/app/build.gradle.kts (đã cấu hình ndkVersion)
│   └── pubspec.yaml (đã import plugin)
└── SETUP_FLUTTER_SUPER_APP_GUIDE.md
```

---

## 6. Lưu ý quan trọng

1. **Luôn clean và pub get sau khi thay đổi plugin**
2. **Kiểm tra log khi test để debug nhanh**
3. **Đảm bảo version NDK đồng nhất**
4. **Backup file .aar trước khi thay đổi**
5. **Test trên thiết bị thật, không chỉ emulator**

---

## 7. Liên hệ hỗ trợ

Nếu gặp lỗi không có trong troubleshooting, hãy:
1. Gửi log lỗi chi tiết
2. Gửi nội dung file cấu hình liên quan
3. Mô tả bước nào gặp lỗi

---

**Chúc bạn build thành công! 🚀** 