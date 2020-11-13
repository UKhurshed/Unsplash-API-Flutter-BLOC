import 'dart:convert';

// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
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
  String link;
  Map<String, dynamic> data;
  final firestoreInstance = FirebaseFirestore.instance;
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('test');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Remote Config'),
      ),
      body:
        // FutureBuilder(
        //   future: retrieveCollection(),
        //   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return Column(
        //         children: [
        //           Container(
        //             height: 27,
        //             child: Text(
        //               "Name: ${snapshot.data.data()['test']}",
        //               overflow: TextOverflow.fade,
        //               style: TextStyle(fontSize: 20),
        //             ),
        //           ),
        //         ],
        //       );
        //     } else if (snapshot.connectionState == ConnectionState.none) {
        //       return Text('No Data');
        //     }
        //     return CircularProgressIndicator();
        //   }
        // )
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           data.toString(),
      //           style: TextStyle(fontSize: 20),
      //         ),
      //         RaisedButton(
      //           child: Text('GET URL'),
      //           onPressed: fetchData,
      //             // CircularProgressIndicator(),
      //             // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()))
      //
      //
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // StreamBuilder(
      //   stream: _collectionReference.snapshots(),
      //   builder: (context, snapshot){
      //      switch(snapshot.connectionState){
      //        case ConnectionState.waiting:
      //          return Center(child: CircularProgressIndicator());
      //          break;
      //        default:
      //          return ListView.builder(
      //            itemCount: snapshot.data.documents.length,
      //              itemBuilder: (context, index){
      //              return _mainContent(snapshot.data.documents[index]);
      //              }
      //          );
      //     }
      //   },
      // )
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(onPressed: () async{
              DocumentSnapshot ds = await FirebaseFirestore.instance
                  .collection("test")
                  .doc("3BpleA1QXmXFjIbjNvtB")
                  .get();
              Map event = ds.data();
              print(event['event']);
              print(event['link']);
              _mainContent(ds);
            }, child: Text('Get Data'),),
            RaisedButton(onPressed: createData, child: Text('Create Data'),),
          ],
        ),
      )
    );
  }

  Widget _mainContent(DocumentSnapshot snapshot) => ListTile(title: Text(snapshot.data()['link']), trailing: Text(snapshot.data()['event']),);

  createData() async{
    await _collectionReference.doc("1").set({'title' : 'Mastering', 'description': 'Guide'});

  }
  fetchData(){
    // CollectionReference collectionReference = firestoreInstance.collection('test');
    // collectionReference.snapshots().listen((snapshot) {
    //   setState(() {
    //     data = snapshot.docs[0].data as Map<String, dynamic>;
    //     print("Data: $data");
    //   });
    // });
    _collectionReference.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) => print('####################################: ${element.data}'));
    });
  }

  Future<DocumentSnapshot> retrieveCollection() async{
    await Firebase.initializeApp();
      // firestoreInstance.collection("test").get().then((value){
      //   value.docs.forEach((element){
      //     print(element.data());
      //     link = element.toString();
      //   });
      // });
    return await firestoreInstance.collection("test").doc("qEvGUoiXtqHCf96q5xzR").get();
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
