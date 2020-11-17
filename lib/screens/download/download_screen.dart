import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_deeplinks/facebook_deeplinks.dart';
import 'package:flutter/material.dart';
import 'package:pic_load/screens/content/content_screen.dart';
import 'package:pic_load/screens/webView/webView_screen.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key key}) : super(key: key);

  @override
  _DownloadScreen createState() => _DownloadScreen();
}

class _DownloadScreen extends State<DownloadScreen> {
  String deepLinkUrl;
  String link;
  // String decLink;
  bool isLink = false;
  Map<String, dynamic> data;
  final fireStoreInstance = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      )
    );
  }

  Future<void> deepLink() async{
    //Facebook DeepLink
    var facebookDeepLinks = FacebookDeeplinks();
    // facebookDeepLinks.onDeeplinkReceived.listen(_onRedirected);
    deepLinkUrl = await facebookDeepLinks.getInitialUrl();

    print("DeepLink: $deepLinkUrl ");
    // if(deepLinkUrl != null){
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(link: 'https://mytraffictracker.com/click.php?key=uu123',)));
    // }

    if (!mounted) return;

    // _onRedirected(deepLinkUrl);
  }

  Future<void> getLink() async{

    //Cloud Firestore
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection("test")
        .doc("3BpleA1QXmXFjIbjNvtB")
        .get();
    Map event = ds.data();
    print(event['enLink']);
    if(event['enLink'] == null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ContentScreen()));
    }else {
      // decLink = utf8.decode(base64.decode(event['enLink']));
      // print('Decode link: $decLink');
      if(deepLinkUrl == null) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebViewScreen(link: utf8.decode(base64.decode(event['enLink'])))));
      }else {
        //'https://mytraffictracker.com/click.php?key=uu123'
        String link = utf8.decode(base64.decode(event['enLink']));
        String deepNewLink = link.substring(0, link.indexOf('key')) +
            deepLinkUrl.substring(6);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebViewScreen(link: deepNewLink)));
      }
    }
  }

  // void _onRedirected(String uri) {
  //   setState(() {
  //     _deepLink = uri;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    deepLink();
    getLink();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
