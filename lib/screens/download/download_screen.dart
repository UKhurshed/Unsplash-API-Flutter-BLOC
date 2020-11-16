import 'dart:convert';

// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_deeplinks/facebook_deeplinks.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:pic_load/screens/app.dart';
import 'package:pic_load/screens/content/content_screen.dart';
import 'package:pic_load/screens/webView/webView_screen.dart';
import 'package:pic_load/screens/widgets/list_photos.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DownloadScreen extends StatefulWidget {
  // const DownloadScreen({Key key}) : super(key: key);

  @override
  _DownloadScreen createState() => _DownloadScreen();
}

class _DownloadScreen extends State<DownloadScreen> {
  String _deepLink = null;
  String link;
  String decLink;
  Map<String, dynamic> data;
  final fireStoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Remote Config'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(onPressed: () async{
              await getLink();
              // var deepLink = await FacebookDeeplinks().getInitialUrl();
              // _onRedirected(deepLink);
            }, child: Text('Get Data'),),
            SizedBox(height: 15,),
            // Text(decLink ?? 'null')
          ],
        ),
      )
    );
  }

  Future<void> getLink() async{

    //Facebook DeepLink
    String deepLinkUrl;
    var facebookDeepLinks = FacebookDeeplinks();
    facebookDeepLinks.onDeeplinkReceived.listen(_onRedirected);
    deepLinkUrl = await facebookDeepLinks.getInitialUrl();

    print("DeepLink: $deepLinkUrl ");

    if (!mounted) return;

    _onRedirected(deepLinkUrl);

    //Cloud Firestore
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection("test")
        .doc("3BpleA1QXmXFjIbjNvtB")
        .get();
    Map event = ds.data();
    print(event['enLink']);
    if(event['enLink'] == null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    }else {
      decLink = utf8.decode(base64.decode(event['enLink']));
      print('Decode link: $decLink');
      if(deepLinkUrl == null) {

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebViewScreen(link: utf8.decode(base64.decode(event['enLink'])))));
      }else {
        //utf8.decode(base64.decode(link)),
        //'https://mytraffictracker.com/click.php?key=uu123'
        String link = utf8.decode(base64.decode(event['enLink']));
        String deepNewLink = link.substring(0, link.indexOf('key')) +
            deepLinkUrl.substring(6);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebViewScreen(link: deepNewLink)));
      }
    }
  }

  void _onRedirected(String uri) {
    setState(() {
      _deepLink = uri;
    });
  }

  // createData() async{
  //   await _collectionReference.doc("1").set({'title' : 'Mastering', 'description': 'Guide'});
  //
  // }

  // Future<void> getLink() async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     final remoteConfig = await RemoteConfig.instance;
  //     final defaults = <String, dynamic>{
  //       'link': "default link",
  //     };
  //
  //     setState(() {
  //       link = defaults['link'];
  //     });
  //
  //     await remoteConfig.fetch(expiration: const Duration(minutes: 30));
  //     await remoteConfig.activateFetched();
  //
  //     setState(() {
  //       // var remoteLink = remoteConfig.getString('link');
  //       // print('RemoteLink: $remoteLink');
  //       // link = utf8.decode(base64.decode(remoteLink));
  //       // print("Link: $link");
  //       link = remoteConfig.getString('link');
  //       print("Link: $link");
  //       // link=null;
  //       if((link == null || link.isEmpty)){
  //         Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  //       }else{
  //         Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(link: link)));
  //       }
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }
}
