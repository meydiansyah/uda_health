import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uda_health/screen/drink_screen.dart';
import 'package:uda_health/screen/food_screen.dart';
import 'package:uda_health/screen/home_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  List<Widget> listOption = [
    DrinkScreen(),
    HomeScreen(),
    FoodScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _selectedIndex == 1
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: _selectedIndex == 0
            ? Colors.blue
            : _selectedIndex == 1 ? Colors.grey.shade50 : Color(0xffF65F9C),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/drops.png',
                scale: 25,
                color: _selectedIndex == 0 ? Colors.blue : Colors.black45,
              ),
              title: Text('Drink'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/dish.png',
                scale: 25,
                color: _selectedIndex == 2 ? Colors.blue : Colors.black45,
              ),
              title: Text('Food'),
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black45,
          selectedItemColor: Colors.blue,
          showUnselectedLabels: false,
          onTap: (val) {
            setState(() {
              _selectedIndex = val;
            });
          },
        ),
        body: listOption.elementAt(_selectedIndex),
      ),
    );
  }
}
