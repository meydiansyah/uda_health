import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../page/authentication/auth_page.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white
                          ),
                          child: Text("uda", style: GoogleFonts.majorMonoDisplay(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),)),
                      Text("Health", style: GoogleFonts.majorMonoDisplay(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("In this app you will get : ", style: TextStyle(fontSize: 20, color: Colors.white),),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Image.asset('assets/drops.png', color: Colors.white, scale: 15,),
                          SizedBox(width: 20,),
                          Flexible(child: Text("Water tracking", style: TextStyle(fontSize: 18, color: Colors.white),)),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Image.asset('assets/dish.png', color: Colors.white, scale: 15,),
                          SizedBox(width: 20,),
                          Flexible(child: Text("Food tracking", style: TextStyle(fontSize: 18, color: Colors.white),)),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Image.asset('assets/newspaper.png', color: Colors.white, scale: 15,),
                          SizedBox(width: 20,),
                          Flexible(child: Text("News Updated in Health category", style: TextStyle(fontSize: 18, color: Colors.white),)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: RoundedLoadingButton(
                        controller: _btnController,
                        onPressed: () async {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          pref.setBool('hasSplash', true);
                          Timer(Duration(seconds: 3), () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthPage()));

                          });
                        },
                        borderRadius: 8,
                        valueColor: Colors.blue,
                        color: Colors.white,
                        successColor: Colors.white,
                        child: Text("Next", style: TextStyle(color: Colors.blue),),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Powered by Udacoding", style: TextStyle(fontSize: 18, color: Colors.white),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
