import 'package:flutter/material.dart';
import 'package:taskapp/constants/font_styling.dart'; //File containing font styles used in the application.
import 'package:taskapp/screens/login_screen/login_screen.dart'; //File containing the login screen widget.

///This code defines a stateless widget called StartScreen.
///It has a static constant variable id which holds the identifier for this screen.
///The constructor takes an optional key parameter.

class StartScreen extends StatelessWidget {
  static const id = 'start_screen';
  const StartScreen({Key? key}) : super(key: key);

  ///The build method overrides the superclass method to build the UI for the StartScreen.
  ///It returns a Scaffold, which provides the basic structure of the screen.

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///Inside the body property of the Scaffold, a Column widget is used to arrange its children vertically.
      ///The Stack widget stacks its children on top of each other.
      ///It contains three Image.asset widgets, each displaying an image from the assets directory.

      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/img.png'),
              Image.asset('assets/images/triangle_lines.png'),
              Image.asset(
                    'assets/images/task_list.png',
                    height: 350,
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Wrap(
              children: [
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Manage ', style: FontStyling.nunitoBlack),
                      TextSpan(text: 'your task and ', style: FontStyling.nunitoBold),
                      TextSpan(text: 'ideas ', style: FontStyling.nunitoBold),
                    ],
                  ),
                ),
                const Text('quickly', style: FontStyling.nunitoBold),
                Image.asset(
                    'assets/images/bulb.png',
                  height: 90,
                )
              ],
            )
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          //alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(bottom: 50, right: 10),
          width: 370,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30)
          ),
          child: FloatingActionButton(
            elevation: 10,

            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Get Start', style: FontStyling.nunitoBlackWhite,),
                SizedBox(width: 30,),
                Icon(size: 40,
                    Icons.arrow_forward)
              ],
            ),
            onPressed: (){
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
          ),
        ),
      ),
    );
  }
}
