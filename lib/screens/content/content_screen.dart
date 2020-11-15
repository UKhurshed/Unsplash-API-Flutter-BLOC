import 'package:facebook_deeplinks/facebook_deeplinks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({Key key}) : super(key: key);
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  String _deeplinkUrl = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String deeplinkUrl;

    var facebookDeeplinks = FacebookDeeplinks();
    facebookDeeplinks.onDeeplinkReceived.listen(_onRedirected);
    deeplinkUrl = await facebookDeeplinks.getInitialUrl();
    print("DeepLink: ${deeplinkUrl} ");

    if (!mounted) return;

    _onRedirected(deeplinkUrl);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Deeplink URL: $_deeplinkUrl'),
              RaisedButton(
                child: Text('GET INITIAL URL'),
                onPressed: () async {
                  var deeplinkUrl = await FacebookDeeplinks().getInitialUrl();
                  _onRedirected(deeplinkUrl);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onRedirected(String uri) {
    setState(() {
      _deeplinkUrl = uri;
    });
  }
}
