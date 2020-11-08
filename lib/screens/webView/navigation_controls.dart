import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  final Future<WebViewController> _webViewController;

  const NavigationControls(this._webViewController);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _webViewController,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapShot) {
        final bool webViewReady =
            snapShot.connectionState == ConnectionState.done;
        final WebViewController controller = snapShot.data;
        return Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                      content: Text('No back history item')));
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoForward()) {
                  controller.goForward();
                } else {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                      content: Text('Forward Not Found')));
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: !webViewReady
                  ? null
                  : () async {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}