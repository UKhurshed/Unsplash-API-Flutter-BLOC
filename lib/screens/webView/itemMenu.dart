// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class ItemMenu extends StatelessWidget {
//   final Future<WebViewController> controller;
//   final CookieManager cookieManager = CookieManager();
//   ItemMenu(this.controller);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<WebViewController>(
//       future: controller,
//       builder:
//           (BuildContext context, AsyncSnapshot<WebViewController> controller) {
//         return PopupMenuButton<MenuOptions>(
//           itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
//             PopupMenuItem(
//               value: MenuOptions.showUserAgent,
//               child: const Text('Show User Agent'),
//               enabled: controller.hasData,
//             ),
//             PopupMenuItem(
//               value: MenuOptions.listCookies,
//               child: const Text('List Cookies'),
//             ),
//             PopupMenuItem(
//               value: MenuOptions.clearCookies,
//               child: const Text('Clear Cookies'),
//             ),
//             PopupMenuItem(
//               value: MenuOptions.navigationDelegate,
//               child: const Text('Navigation Delegate Demo'),
//             )
//           ],
//           onSelected: (MenuOptions value) {
//             switch (value) {
//               case MenuOptions.showUserAgent:
//                 showUserAgent(controller.data, context);
//                 break;
//               case MenuOptions.listCookies:
//                 listCookies(controller.data, context);
//                 break;
//               case MenuOptions.clearCookies:
//                 clearCookies(controller.data, context);
//                 break;
//               case MenuOptions.navigationDelegate:
//                 navigationDelegateDemo(controller.data, context);
//                 break;
//               default:
//             }
//           },
//         );
//       },
//     );
//   }
//
//   navigationDelegateDemo(
//       WebViewController controller, BuildContext context) async {
//     final String contentBase64 =
//     base64Encode(const Utf8Encoder().convert(examplePage));
//     controller.loadUrl('data:text/html;base64,$contentBase64');
//   }
//
//   listCookies(WebViewController controller, BuildContext context) async {
//     final String cookies =
//     await controller.evaluateJavascript('document.cookie');
//     Scaffold.of(context).showSnackBar(
//       SnackBar(
//         content: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[const Text('Cookies:'), getCookies(cookies)],
//         ),
//       ),
//     );
//   }
//
//   Widget getCookies(String cookies) {
//     if (null == cookies || cookies.isEmpty) {
//       return Container();
//     }
//     final List<String> cookieList = cookies.split(';');
//     final Iterable<Text> cookieWidgets = cookieList.map(
//           (String cookie) => Text(cookie),
//     );
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       mainAxisSize: MainAxisSize.min,
//       children: cookieWidgets.toList(),
//     );
//   }
//
//   void clearCookies(WebViewController controller, BuildContext context) async {
//     final bool hadCookies = await cookieManager.clearCookies();
//     String message = 'Not Found';
//     Scaffold.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//   }
//
//   showUserAgent(WebViewController controller, BuildContext context) {
//     controller.evaluateJavascript(
//         'SnackBarJSChannel.postMessage("User Agent: " + navigator.userAgent);');
//   }
// }
//
// enum MenuOptions {
//   showUserAgent,
//   listCookies,
//   clearCookies,
//   addToCache,
//   listCache,
//   clearCache,
//   navigationDelegate
// }
//
// const String examplePage = '''
//       <!DOCTYPE html><html>
//       <head><title>Navigation Delegate Example</title></head>
//       <body>
//       <p>
//       The navigation delegate is set to block navigation to the youtube website.
//       </p>
//       <ul>
//       <ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
//       <ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
//       </ul>
//       </body>
//       </html>
//       ''';
//
