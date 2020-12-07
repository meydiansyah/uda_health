import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uda_health/model/get_data.dart';
import 'package:uda_health/provider/auth_provider.dart';
import 'package:uda_health/page/authentication/auth_page.dart';
import 'package:uda_health/page/home_page.dart';
import 'package:uda_health/provider/food_provider.dart';
import 'package:uda_health/screen/splash.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => FoodProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => GetApi(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<bool> getSplashScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('hasSplash') == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration(seconds: 2),
        () => getSplashScreen().then((value) async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              if (value) {
                return Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  if (pref.getBool('login') == null) {
                    return AuthPage();
                  } else {
                    return HomePage();
                  }
                }));
              } else {
                return Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Text(
                      "uda",
                      style: GoogleFonts.majorMonoDisplay(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Health",
                  style: GoogleFonts.majorMonoDisplay(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
