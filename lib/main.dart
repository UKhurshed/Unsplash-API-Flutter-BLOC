import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pic_load/screens/app.dart';
import 'package:pic_load/simple_bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // OneSignal.shared.init('643d680b-e014-40fd-beb6-11cdbd4ed222', iOSSettings: null);
  // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}


//ca-app-pub-6246157961341960~8828179846