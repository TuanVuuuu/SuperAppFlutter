# Super App Architecture

Dự án này là ví dụ về kiến trúc Super App gồm 3 thành phần chính:

## 1. SuperApp (Native Android Host App)
- Ứng dụng Android native (Compose/Kotlin).
- Tích hợp Mini App SDK dưới dạng .aar.
- Gọi API của SDK để mở mini app (web app) trong WebView.
- Thư mục: `SuperApp/`

## 2. mini_app_android_sdk (Android SDK)
- Android Library đóng gói thành .aar.
- Cung cấp interface chuẩn (`init`, `openWebView`), tự quản lý Activity mở WebView.
- Host app chỉ cần gọi hàm, không cần tự viết lại logic WebView.
- Thư mục: `mini_app_android_sdk/`

## 3. web_app (Flutter Web Mini App)
- Ứng dụng Flutter web, đóng vai trò mini app.
- Chạy trên localhost hoặc LAN (ví dụ: http://localhost:8989).
- Được mở trong WebView của SuperApp qua SDK.
- Thư mục: `web_app/`

---

## Luồng hoạt động tổng quan
1. Chạy web app (Flutter) trên localhost/LAN.
2. SuperApp gọi `MiniAppSDK.openWebView(...)` để mở WebView trỏ tới URL web app.
3. Người dùng tương tác với mini app ngay trong SuperApp.

---

## Tài liệu chi tiết
- Xem thêm hướng dẫn build/run, tích hợp, phát triển tại file [`MINI_APP_SDK_IDEA.md`](./MINI_APP_SDK_IDEA.md) 