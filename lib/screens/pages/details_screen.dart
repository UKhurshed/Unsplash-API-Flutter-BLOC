import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pic_load/model/item_picture.dart';
import 'package:pic_load/model/message.dart';

import '../../admob_manager.dart';

class PhotoDetailPageArguments {
  final PhotoListBean photoListBean;

  PhotoDetailPageArguments(this.photoListBean);
}

class DetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PhotoDetailPageArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(body: PhotoDetailWidget(photoListBean: args.photoListBean));
  }
}

class PhotoDetailWidget extends StatefulWidget {
  final PhotoListBean photoListBean;

  const PhotoDetailWidget({Key key, this.photoListBean}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PhotoDetailWidgetState();
  }
}

class PhotoDetailWidgetState extends State<PhotoDetailWidget> {
  bool isLiked = false;
  BannerAd _bannerAd;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.arrow_back),
        title: Text(widget.photoListBean.user.name),
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Hero(
                  tag: 'photo#${widget.photoListBean.id}',
                  child: Image.network(widget.photoListBean.urls.regular),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.photoListBean.altDescription ?? 'None',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        widget.photoListBean.user.profileImage.medium),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.photoListBean.user.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.photoListBean.user.instagramUsername ?? 'None',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      size: 30,
                    ), onPressed: () { },
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    widget.photoListBean.likes.toString(),
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: messages.map(buildMessage).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: AdManager.bannerAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }
  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    _bannerAd = createBannerAd()
    ..load()
    ..show();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async{
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true)
    );
  }
}
