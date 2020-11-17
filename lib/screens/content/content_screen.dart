import 'package:flutter/material.dart';
import 'package:pic_load/repository/photo_repository.dart';
import 'package:pic_load/screens/widgets/list_photos.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPhoto(PhotoRepositoryImpl()),
    );
  }
}