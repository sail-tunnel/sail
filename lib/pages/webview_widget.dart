import 'package:flutter/material.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String url;
  final String name;

  const WebViewWidget(this.url, this.name, {Key key}) : super(key: key);

  @override
  WebViewWidgetState createState() => WebViewWidgetState();
}

class WebViewWidgetState extends State<WebViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.url.isEmpty ? AppStrings.appName : widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
