import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pic_load/screens/webView/itemMenu.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'navigation_controls.dart';

class WebViewScreen extends StatefulWidget {
  final String link;

  const WebViewScreen({Key key, this.link}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState(link);
}

JavascriptChannel snackBarJavaScriptChannel(BuildContext context) {
  return JavascriptChannel(
    name: 'SnackBarJSChannel',
    onMessageReceived: (JavascriptMessage message){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message.message),
      ));
    }
  );
}

class _WebViewScreenState extends State<WebViewScreen> {
  final String link;
   _WebViewScreenState(this.link);
  // static String URL = link;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WebView Demo',
        ),
        actions: [NavigationControls(_controller.future), ItemMenu(_controller.future)],
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          // initialUrl: utf8.decode(base64.decode(link)),
          initialUrl: link,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            snackBarJavaScriptChannel(
              context,
            )
          ].toSet(),
          navigationDelegate: (NavigationRequest request){
            if(request.url.startsWith("https://www.youtube.com")){
              print("Blocking navigation");
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        );
      }),
    );
  }
}
