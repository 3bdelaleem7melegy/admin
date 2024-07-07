import 'dart:io';

import 'package:admin/Admin/Doctor.dart';
import 'package:admin/Admin/RegisterDoctor.dart';
import 'package:admin/LoginUser/Login.dart';
import 'package:admin/LoginUser/doctor_model.dart';
import 'package:admin/User%20Details%20And%20Update/userProfile.dart';
import 'package:admin/firebaseAuth.dart';
import 'package:admin/Admin/report.dart';
import 'package:admin/skip.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyCbw2AOKUq4JfVoZceQsZP27aCa6Q2z2-U",
              appId: "1:474247137471:android:474f58b5863b60faf3de0a",
              messagingSenderId: "474247137471",
              projectId: "final-project-b67b9"))
      // WidgetsFlutterBinding.ensureInitialized();
      // SystemChrome.setPreferredOrientations(
      //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      : await Firebase.initializeApp();

  await Hive.initFlutter();

  // Bloc.observer = SimpleBlocObserver();
  // Hive.registerAdapter(NoteModelAdapter());
  // await Hive.openBox<NoteModel>(kNotesBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _getUser();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      title: 'Flutter Demo',
      initialRoute: '/',
      //
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => Skip());
          case '/login':
            return MaterialPageRoute(builder: (context) => FireBaseAuth());
          case '/SignIn':
            return MaterialPageRoute(builder: (context) => SignIn());
            case '/AdminScreen':
            return MaterialPageRoute(builder: (context) => AdminScreen());
            case '/RegisterDoctor':
            return MaterialPageRoute(builder: (context) => RegisterDoctor());
                        case '/UserProfile':
            return MaterialPageRoute(builder: (context) => UserProfile());

          default:
        }
      },
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/': (context) => Skip(),
      //   '/login': (context) => FireBaseAuth(),

      //   '/SignIn': (context) => SignIn(),
      //   '/doctorScreen': (context) => doctorScreen(),
      //   '/Users': (context) => Users(),
      //   '/MyAppointments': (context) => MyAppointments(),
      //    '/HomePageDoctor': (context) => HomePageDoctor(),

      // }
    );
  }
}
