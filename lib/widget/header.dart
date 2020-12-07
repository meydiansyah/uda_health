import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uda_health/page/authentication/auth_page.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue
                ),
                child: Text("uda", style: GoogleFonts.majorMonoDisplay(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)),
            Text("Health", style: GoogleFonts.majorMonoDisplay(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),)
          ],
        ),
        PopupMenuButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.menu),
            onSelected: (value) async {
              switch (value) {
                case 1:
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.remove('login');
                  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthPage()));
                  break;
              }
            },
            itemBuilder: (context) {
              var ls = List<PopupMenuEntry<Object>>();
              ls.add(PopupMenuItem(
                value: 1,
                child: Text("Log Out"),
              ));
              return ls;
            })
      ],
    );
  }
}
