// import 'package:facebook_deeplinks/facebook_deeplinks.dart';
// import 'package:facebook_deeplinks/facebook_deeplinks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pic_load/screens/download/download_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deeplinkUrl = 'Unknown';

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Future<void> initPlatformState() async {
  //   String deeplinkUrl;
  //
  //   var facebookDeeplinks = FacebookDeeplinks();
  //   facebookDeeplinks.onDeeplinkReceived.listen(_onRedirected);
  //   deeplinkUrl = await facebookDeeplinks.getInitialUrl();
  //   print('Link: $deeplinkUrl');
  //   if (!mounted) return;
  //
  //   _onRedirected(deeplinkUrl);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Deeplink URL: $_deeplinkUrl'),
              RaisedButton(
                child: Text('GET INITIAL URL'),
                onPressed: () async {
                  // var deeplinkUrl = await FacebookDeeplinks().getInitialUrl();
                  // _onRedirected(deeplinkUrl);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _onRedirected(String uri) {
  //   setState(() {
  //     _deeplinkUrl = uri;
  //   });
  // }
}

//
// class TestConfig extends StatefulWidget {
//   const TestConfig({Key key}) : super(key: key);
//
//   @override
//   _TestConfigState createState() => _TestConfigState();
// }
//
// class _TestConfigState extends State<TestConfig> {
//   // String predictions, link;
//   String _deepLinkUrl = 'unknown';
//
//
//   Future<void> initPlatformState() async {
//     String deepLinkUrl;
//
//     var facebookDeepLinks = FacebookDeeplinks();
//     facebookDeepLinks.onDeeplinkReceived.listen(_onRedirected);
//     deepLinkUrl = await facebookDeepLinks.getInitialUrl();
//
//     if (!mounted) return;
//
//     _onRedirected(deepLinkUrl);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Remote Config'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Text('Predictions: $predictions', style: TextStyle(fontSize: 18),),
//             // Text('Link: $link', style: TextStyle(fontSize: 20),),
//             Text('DeepLink URL: $_deepLinkUrl'),
//             RaisedButton(
//               child: Text('GET INITIAL URL'),
//               onPressed: () async {
//                 var deepLinkUrl = await FacebookDeeplinks().getInitialUrl();
//                 _onRedirected(deepLinkUrl);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _onRedirected(String uri) {
//     setState(() {
//       _deepLinkUrl = uri;
//     });
//   }
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // WidgetsBinding.instance.addPostFrameCallback((_) async {
//   //   //   final remoteConfig = await RemoteConfig.instance;
//   //   //   final defaults = <String, dynamic>{
//   //   //     'link': "default link",
//   //   //     "predictions": "default predictions"
//   //   //   };
//   //   //
//   //   //   setState(() {
//   //   //     link = defaults['link'];
//   //   //     predictions = defaults['predictions'];
//   //   //   });
//   //   //
//   //   //   await remoteConfig.fetch(expiration: const Duration(minutes: 30));
//   //   //   await remoteConfig.activateFetched();
//   //   //
//   //   //   setState(() {
//   //   //     predictions = remoteConfig.getString('predictions');
//   //   //     link = remoteConfig.getString('link');
//   //   //   });
//   //   // });
//   // }
// }
//

// class ContentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Content'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Content Screen"),
//
//           ],
//         ),
//       ),
//     );
//   }
// }

