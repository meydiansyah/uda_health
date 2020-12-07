import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrinkScreen extends StatefulWidget {
  @override
  _DrinkScreenState createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  double _water = 0;
  double getPercant = 0.0;

  void addWater(double val) {
    setState(() {
      _water += val;
    });
    addPercant();
  }

  void addPercant() {
    setState(() {
      getPercant = (_water/2000) * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                style: GoogleFonts.poppins(fontSize: 30, color: Colors.white, height: 1),
                  children: [
                    TextSpan(
                        text: "Drink\n",
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)

                    ),
                    TextSpan(
                        text: "Your\n",
                    ),
                    TextSpan(
                        text: "Water\n",
                        style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)

                    ),
                  ]
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: CircularPercentIndicator(
                    radius: 150.0,
                    lineWidth: 10.0,
                    percent: getPercant/100 > 1.0 ? 1.0 : getPercant/100,
                    circularStrokeCap: CircularStrokeCap.round ,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/drops.png', scale: 10, color: Colors.white,),
                        SizedBox(height: 10,),
                        Text(getPercant/100 > 1.0 ? "100%" : "${getPercant.toString().substring(0, 2)}%", style: GoogleFonts.poppins(color: Colors.white),)
                      ],
                    ),
                    progressColor: Colors.white,
                    backgroundColor: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
              Text("It is recommended that about eight glasses measuring 230 ml per day or a total of 2 liters", style: GoogleFonts.poppins(color: Colors.white),),
              SizedBox(height: 50,),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => addWater(200),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.2)
                              ),
                              child: Image.asset('assets/drink.png', scale: 12,),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("200ml", style: GoogleFonts.poppins(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => addWater(230),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.2)
                              ),
                              child: Image.asset('assets/drink.png', scale: 10,),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("230ml", style: GoogleFonts.poppins(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => addWater(250),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.2)
                              ),
                              child: Image.asset('assets/drink.png', scale: 7,),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("250ml", style: GoogleFonts.poppins(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                ],
              )
//          Row(
//            children: [
//              Expanded(
//                child: Container(
//                  margin: EdgeInsets.all(20),
//                  padding: EdgeInsets.all(20),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                    image: DecorationImage(
//                      fit: BoxFit.fitHeight,
//                      image: AssetImage('assets/drink.png'),
//
//                    )
//                  ),
//                ),
//              ),
//              Expanded(
//                child: Container(
//                  margin: EdgeInsets.all(20),
//                  padding: EdgeInsets.all(25),
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(10),
//                    image: DecorationImage(
//                      image: AssetImage('assets/drink.png'),
//
//                    )
//                  ),
//                ),
//              ),
//              Expanded(
//                child: Container(
//                  margin: EdgeInsets.all(20),
//                  padding: EdgeInsets.all(30),
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(10),
//                    image: DecorationImage(
//                      image: AssetImage('assets/drink.png'),
//
//                    )
//                  ),
//                ),
//              ),
//            ],
//          )
            ],
          ),
        ),
      ),
    );
  }
}
