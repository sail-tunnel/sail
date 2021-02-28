import 'package:flutter/material.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  String bannerDetailUrl;
  var bannerName;

  WebViewPage(this.bannerDetailUrl, this.bannerName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bannerName),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: bannerDetailUrl.isEmpty ? AppStrings.APP_NAME : bannerDetailUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
