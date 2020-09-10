import 'package:flutter/material.dart';
import 'package:pic_load/screens/pages/details_screen.dart';
import 'package:pic_load/screens/pages/search_photo.dart';

import 'pages/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PicLoad',
      theme: ThemeData(primaryColor: Colors.grey),
      initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName: (context) => MainPage(),
        DetailsPage.routeName: (context) => DetailsPage(),
      },
    );
  }
}

