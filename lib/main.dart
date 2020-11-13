import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pic_load/screens/app.dart';
import 'package:pic_load/simple_bloc_observer.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}


//ca-app-pub-6246157961341960~8828179846