import 'package:flutter/material.dart';
import 'package:pic_load/model/search_photos.dart';

class PhotoDetailPageArguments {
  final SearchPhotoList searchPhotoList;
  PhotoDetailPageArguments( this.searchPhotoList);
}

class DetailsPage extends StatelessWidget {
  static final routeName = "photoDetailPage";

  @override
  Widget build(BuildContext context) {
    PhotoDetailPageArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(body: PhotoDetailWidget(searchPhotoList: args.searchPhotoList));
  }
}

class PhotoDetailWidget extends StatefulWidget {
  final SearchPhotoList searchPhotoList;

  const PhotoDetailWidget({Key key, this.searchPhotoList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PhotoDetailWidgetState();
  }
}

class PhotoDetailWidgetState extends State<PhotoDetailWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchPhotoList.results.user.name),
        backgroundColor: Colors.white,
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
                  tag: 'photo#${widget.searchPhotoList.results.id}',
                  child: Image.network(widget.searchPhotoList.results.urls.regular),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.searchPhotoList.results.description ?? 'None',
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
                        widget.searchPhotoList.results.user.profileImage.medium),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.searchPhotoList.results.user.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.searchPhotoList.results.user.instagramUsername ?? 'None',
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
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    widget.searchPhotoList.results.likes.toString(),
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
