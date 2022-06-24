[English](./README.md) | 简体中文

# Sail

[![Flutter](https://github.com/losgif/sail/actions/workflows/flutter.yml/badge.svg)](https://github.com/losgif/sail/actions/workflows/flutter.yml)

使用 [Flutter](https://github.com/flutter/flutter) 为 [V2Board](https://github.com/v2board/v2board) ~~及 [SSPanel-Uim](https://github.com/Anankke/SSPanel-Uim) 构建的应用~~  

现在支持iOS而非Android, 我没有Android设备😂.

重现 [Mohammad Reza Farahzad 的设计](https://dribbble.com/shots/14028358-VPN-App-Ui-Design?utm_source=Clipboard_Shot&utm_campaign=mrfarahzad&utm_content=VPN%20App%20Ui%20Design&utm_medium=Social_Share)

**如果这个项目对你有帮助，请给我一颗小星星⭐️。**

## 截图

<img src="https://user-images.githubusercontent.com/13404752/174476441-973c2a23-d0fe-4742-8d6c-df5b52635a97.png" width="300" alt="Screenshot">
<img src="https://user-images.githubusercontent.com/13404752/174476492-0ffbb49e-f903-4663-9b34-79f91c1c33ed.png" width="300" alt="Screenshot">
<img src="https://user-images.githubusercontent.com/13404752/110204822-1b29cc00-7eb0-11eb-8a95-a7c3ca7aa472.png" width="300" alt="Screenshot">

## 资源
- [Mohammad Reza Farahzad 的设计](https://dribbble.com/shots/14028358-VPN-App-Ui-Design?utm_source=Clipboard_Shot&utm_campaign=mrfarahzad&utm_content=VPN%20App%20Ui%20Design&utm_medium=Social_Share)
- [flat flags](https://github.com/wobblecode/flat-flags)
- [flutter icons](https://pub.dev/packages/flutter_icons)

## 联络我

[Telegram](https://t.me/losgif)

## 待办事项：
- [ ] 支持安卓设备。
- [ ] Dart ffi 与 iOS 和 android 来控制 vpn。
- [ ] 订单页面
- [ ] 我的设置页面
- [x] 服务器列表页面支持 ping 操作。
- [ ] 按Material主题重构颜色。

## 环境

- Flutter 3.0.1
- Dart 2.17.1
- macOS 12.4
- IntelliJ IDEA 2022.1.1 (Ultimate Edition) (感谢 [jetbrains 开源计划](https://www.jetbrains.com/opensource/))
- Xcode 13.4.1
- iOS 15.5

## 安装

```shell
flutter pub get
```

## 开发
```shell
flutter run
```

## 构建
build android apk
```shell
flutter build apk
```

build ios
```shell
flutter build ios
```
