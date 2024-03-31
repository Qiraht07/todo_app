import 'dart:async'; //which provides utilities for asynchronous programming, such as Timer.

import 'package:flutter/material.dart'; //The core Flutter framework.
import 'package:get_storage/get_storage.dart'; // A package used for local storage management.
import 'package:taskapp/screens/login_screen/login_screen.dart'; //File containing the login screen widget.
import 'package:taskapp/screens/tabs/start_screen.dart'; //File containing the start screen widget.
import 'package:taskapp/screens/tabs/tabs_screen.dart'; //File containing the tabs screen widget.


///This code defines a SplashScreen widget as a stateful widget.
///It overrides the createState method to return an instance of _SplashScreenState,
///which is the state associated with this widget.


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

///This section defines the state class _SplashScreenState.
///Inside the initState method, openNextPage function is called to schedule the navigation
///to the next screen after 2000 milliseconds (2 seconds).
///This function checks if a 'token' exists in the local storage using GetStorage.
///If the token is present, it navigates to TabsScreen, otherwise it navigates to StartScreen.

class _SplashScreenState extends State<SplashScreen> {
  final GetStorage _getStorage = GetStorage();
  @override
  initState(){
    openNextPage(context);
    super.initState();
  }

 openNextPage(BuildContext context){
   Timer(const Duration(milliseconds: 2000), (){
     if(_getStorage.read('token') == null || _getStorage.read('token') == ''){
       Navigator.pushReplacementNamed(context, StartScreen.id);
     }else{
       Navigator.pushReplacementNamed(context, TabsScreen.id);
     }
   });
 }

 ///This code defines the UI for the splash screen.
  ///It returns a Scaffold with a CircularProgressIndicator widget centered in the body.
  ///This UI is displayed while the application is loading and processing before navigating to the next screen.

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
