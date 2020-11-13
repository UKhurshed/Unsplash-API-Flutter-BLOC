import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pic_load/bloc/photo_list_bloc/photo_list_bloc.dart';
import 'package:pic_load/repository/photo_repository.dart';
import 'package:pic_load/screens/content/content_screen.dart';
import 'package:pic_load/screens/download/download_screen.dart';


import 'pages/home.dart';
import 'webView/webView_screen.dart';

class App extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PicLoad',
      theme: ThemeData(primaryColor: Colors.green),
      home: BlocProvider(
        create: (context) => PhotoListBloc(PhotoRepositoryImpl()),
        child: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<Widget> pages = [
    // DownloadScreen(key: PageStorageKey('ContentScreen'),),
    // WebViewScreen(key: PageStorageKey('WebView'),)
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  int _currentIndex = 0;

  Widget _bottomNavigationBar(int currentIndex) => BottomNavigationBar(
      selectedItemColor: Colors.blue[600],
      unselectedItemColor: Colors.black,
      onTap: (int index) => setState(() => _currentIndex = index),
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        // BottomNavigationBarItem(icon: Icon(Icons.web,), label: 'WebView'),
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: _bottomNavigationBar(_currentIndex),
      // body: PageStorage(
      //   child: pages[_currentIndex],
      //   // bucket: bucket,
      // ),
      body: DownloadScreen() ,
    );
  }
}

