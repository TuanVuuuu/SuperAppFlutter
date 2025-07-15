# Ý tưởng xây dựng Mini App SDK cho Android

## 1. Tổng quan ý tưởng

- **Mini App** sẽ được public thành một webapp (giai đoạn đầu có thể để localhost để phát triển/test).
- **Mini App SDK (Android)**: Định nghĩa các interface chuẩn (ví dụ: `init`, `openWebView`), đóng gói thành thư viện SDK. SDK cung cấp sẵn Activity mở WebView, host app chỉ cần gọi hàm SDK.
- **Host App**: 
  - Import SDK và gọi trực tiếp các hàm (không cần tự implement lại Activity/WebView).

## 2. Kiến trúc tổng quát

```mermaid
graph TD
  subgraph MiniApp SDK
    A[MiniAppSDK (object/interface)]
    B[MiniAppWebViewActivity]
  end
  D[Host App: Native/Flutter]
  A --> B
  D --> A
```

## 3. Luồng giao tiếp

1. **Host app** gọi hàm qua SDK (ví dụ: `init`, `openWebView`).
2. **SDK** mở Activity WebView, truyền URL/config vào.
3. WebView hiển thị mini app (web app).

## 4. Điểm mạnh của mô hình

- **Chuẩn hóa API**: Host app chỉ cần gọi hàm SDK, không cần biết chi tiết bên trong.
- **Dễ tích hợp**: Host app không cần tự viết lại Activity/WebView.
- **Tách biệt rõ ràng**: Mini App SDK độc lập, dễ bảo trì, dễ mở rộng.
- **Có thể đóng gói thành .aar**: Import vào host app dễ dàng.

## 5. Gợi ý mở rộng

| Hạng mục | Gợi ý |
|----------|-------|
| **Naming** | Đặt tên hàm, activity, package rõ ràng, ví dụ: `MiniAppSDK`, `MiniAppWebViewActivity` |
| **Error Handling** | Trả về lỗi rõ ràng qua callback hoặc log |
| **Versioning** | Ghi log version SDK khi init, quản lý version trong build.gradle |
| **Mở rộng API** | Thiết kế interface native dễ mở rộng |
| **WebView/JS Bridge** | Nếu cần giao tiếp 2 chiều với webapp, dùng addJavascriptInterface |

## 6. Ví dụ code mẫu

### Android (Kotlin)
```kotlin
interface MiniAppSDKInterface {
    fun init(application: Application, config: String? = null)
    fun openWebView(context: Context, url: String)
}

object MiniAppSDK : MiniAppSDKInterface {
    private var application: Application? = null
    private var config: String? = null

    override fun init(application: Application, config: String?) {
        this.application = application
        this.config = config
    }

    override fun openWebView(context: Context, url: String) {
        val intent = Intent(context, MiniAppWebViewActivity::class.java)
        intent.putExtra("url", url)
        intent.putExtra("config", config)
        context.startActivity(intent)
    }
}
```

### MiniAppWebViewActivity
```kotlin
class MiniAppWebViewActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val webView = WebView(this)
        webView.webViewClient = WebViewClient()
        webView.settings.javaScriptEnabled = true
        val url = intent.getStringExtra("url") ?: "https://example.com"
        webView.loadUrl(url)
        setContentView(webView)
    }
}
```

### Host app sử dụng
```kotlin
MiniAppSDK.init(application, "config data")
MiniAppSDK.openWebView(this, "http://localhost:8989")
```

## 7. Kết luận

- Mô hình này giúp chuẩn hóa tích hợp mini app vào host app native.
- Host app chỉ cần import SDK, gọi hàm là mở được mini app (web app) trong WebView.
- Dễ mở rộng, bảo trì, đóng gói thành .aar hoặc maven package. 

## 8. Hướng dẫn chạy thử & build

### 8.1. Chạy web app (Flutter web) trên localhost/LAN

1. Mở terminal, cd vào thư mục web app (ví dụ: `web_app`)
2. Cài dependencies (chỉ cần lần đầu hoặc khi thay đổi pubspec.yaml):
   ```sh
   flutter pub get
   ```
3. Chạy web server (mặc định port 8989, có thể đổi):
   ```sh
   flutter run -d web-server --web-port=8989 --web-hostname=0.0.0.0
   ```
   - Nếu muốn truy cập từ thiết bị khác trong LAN, dùng IP máy tính thay cho localhost (ví dụ: `http://192.168.x.x:8989`).

### 8.2. Build lại Mini App SDK (.aar)

1. Mở terminal, cd vào thư mục SDK (ví dụ: `mini_app_sdk_android`)
2. Build .aar:
   ```sh
   ./gradlew assembleRelease
   ```
3. File .aar sẽ nằm ở: `mini_app_sdk_android/build/outputs/aar/mini_app_sdk_android-release.aar`

### 8.3. Tích hợp .aar vào SuperApp (nếu chưa làm)

1. Copy file .aar vào thư mục: `SuperApp/app/libs/`
2. Đảm bảo cấu hình `flatDir` trong `build.gradle.kts` và `settings.gradle.kts` để nhận diện thư viện local.
3. Thêm dòng sau vào dependencies của app module:
   ```kotlin
   implementation(name = "mini_app_sdk_android-release", ext = "aar")
   ```

### 8.4. Build & run SuperApp

1. Mở terminal, cd vào thư mục SuperApp (ví dụ: `SuperApp`)
2. Build & cài app lên thiết bị/emulator:
   ```sh
   ./gradlew installDebug
   ```
   hoặc mở Android Studio, chọn Run.
3. Mở app trên thiết bị, nhấn nút để mở mini app (web app) trong WebView.

---

**Lưu ý:**
- Đảm bảo thiết bị Android và máy tính chạy web server cùng mạng LAN nếu muốn truy cập qua IP.
- Nếu web app đổi port hoặc IP, cần sửa URL khi gọi `MiniAppSDK.openWebView(...)`.
- Hoặc cắm usb tới thiết bị, sử dụng lệnh `adb reverse --remove tcp:8989` để mặc định cổng 8989, lúc này thiết bị có thể chạy trên `https://localhost:8989` mà không cần quan tâm đến ip, nhưng khi ngắt kết nối giữa máy tính và thiết bị, miniapp sẽ không kết nối tới được -> chỉ dùng khi dev.