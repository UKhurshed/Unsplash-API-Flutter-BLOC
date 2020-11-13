import 'dart:convert';

// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:pic_load/screens/app.dart';
import 'package:pic_load/screens/content/content_screen.dart';
import 'package:pic_load/screens/webView/webView_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DownloadScreen extends StatefulWidget {
  // const DownloadScreen({Key key}) : super(key: key);

  @override
  _DownloadScreen createState() => _DownloadScreen();
}

class _DownloadScreen extends State<DownloadScreen> {
  String link;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Remote Config'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Link: $link',
                style: TextStyle(fontSize: 20),
              ),
              RaisedButton(
                child: Text('GET URL'),
                onPressed: () async => {
                  CircularProgressIndicator(),
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()))
                  await getLink(),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getLink() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final remoteConfig = await RemoteConfig.instance;
      final defaults = <String, dynamic>{
        'link': "default link",
      };

      setState(() {
        link = defaults['link'];
      });

      await remoteConfig.fetch(expiration: const Duration(minutes: 30));
      await remoteConfig.activateFetched();

      setState(() {
        // var remoteLink = remoteConfig.getString('link');
        // print('RemoteLink: $remoteLink');
        // link = utf8.decode(base64.decode(remoteLink));
        // print("Link: $link");
        link = remoteConfig.getString('link');
        print("Link: $link");
        // link=null;
        if((link == null || link.isEmpty)){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(link: link)));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
