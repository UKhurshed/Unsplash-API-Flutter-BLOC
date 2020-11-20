import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pic_load/model/item_picture.dart';

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
  String content = 'content';
  String title ='title';

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
                height: 30,
              ),
              Text(title ?? '' ),
              SizedBox(
                height: 10,
              ),
              Text(content ?? ''),
            ],
          ),
        ),
      ),
    );
  }

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
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      setState(() {
        title = notification.payload.title;
        content = notification.payload.body;

      });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('Notification');
    });
  }
}
