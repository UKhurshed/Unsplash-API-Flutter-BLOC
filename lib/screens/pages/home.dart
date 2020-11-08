import 'package:flutter/material.dart';
import 'package:pic_load/repository/photo_repository.dart';
import 'package:pic_load/screens/widgets/list_photos.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPhoto(PhotoRepositoryImpl()),
    );
  }
}
