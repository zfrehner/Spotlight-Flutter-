import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Messenger extends StatefulWidget {
  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: WebView(
          initialUrl: "https://spotlightgymapp.wixsite.com/spotlight/blog",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
    );
  }
}