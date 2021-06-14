import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/auth_screen.dart';
import 'package:flutter/material.dart';
//import './screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : MaterialApp(
              title: 'Flutter Chat',
              theme: ThemeData(
                  backgroundColor: Colors.pink,
                  accentColor: Colors.deepPurple,
                  accentColorBrightness: Brightness.dark,
                  primarySwatch: Colors.pink,
                  buttonTheme: ButtonTheme.of(context).copyWith(
                      buttonColor: Colors.pink,
                      textTheme: ButtonTextTheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
              home: StreamBuilder(
                builder: (context, usersnapshot) {
                  if (usersnapshot.connectionState == ConnectionState.waiting) {
                    return SplashScreen();
                  }
                  if (usersnapshot.hasData) {
                    return ChatScreen();
                  } else {
                    return AuthScreen();
                  }
                },
                stream: FirebaseAuth.instance.authStateChanges(),
              ),
            ),
    );
  }
}
