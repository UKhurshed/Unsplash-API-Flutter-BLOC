import 'package:flutter/material.dart';
import 'package:pic_load/bloc/photo_list_bloc/search_list_bloc/search_list_bloc.dart';
import 'package:pic_load/repository/search_photo_repository.dart';
import 'package:pic_load/screens/pages/search_photo.dart';
import 'package:pic_load/screens/widgets/list_photos.dart';
import 'package:pic_load/screens/widgets/search_field.dart';

class MainPage extends StatelessWidget {
  static final routeName = 'homePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                SearchBar(),
                // SearchPhoto(repository: SearchPhotoRepositoryImpl(),)
                SearchPhotos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}