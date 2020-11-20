import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pic_load/bloc/photo_list_bloc/photo_list_bloc.dart';
import 'package:pic_load/repository/photo_repository.dart';
import 'package:pic_load/screens/download/download_screen.dart';

class App extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PicLoad',
      theme: ThemeData(primaryColor: Colors.green),
      home: BlocProvider(
        create: (context) => PhotoListBloc(PhotoRepositoryImpl()),
        child: DownloadScreen(),
      ),
    );
  }
}


