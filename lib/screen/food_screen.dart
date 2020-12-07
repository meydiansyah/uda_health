import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uda_health/model/food.dart';
import 'package:uda_health/provider/food_provider.dart';

class FoodScreen extends StatefulWidget {
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<FoodProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                      style: GoogleFonts.poppins(
                          fontSize: 28, color: Colors.white, height: 1),
                      children: [
                        TextSpan(
                            text: "Track\n",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: "Your\n",
                        ),
                        TextSpan(
                            text: "Food\n",
                            style: TextStyle(
                                fontSize: 43, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "Today\n",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ]),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  splashColor: Colors.white.withOpacity(0.5),
                  highlightColor: Colors.white.withOpacity(0.2),
                  onPressed: () => _modalButtom(prov),
                  iconSize: 30,
                  color: Colors.white,
                )
              ],
            ),
            Flexible(
              child: FutureBuilder<List<Food>>(
                future: prov.getData(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return InkWell(
                      onTap: () => _modalButtom(prov),
                      borderRadius: BorderRadius.circular(10),
                      highlightColor: Colors.white.withOpacity(0.2),
                      splashColor: Colors.white.withOpacity(0.4),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.2)),
                          child: Center(
                            child: Text(
                              "Food is null",
                              style: GoogleFonts.poppins(
                                  fontSize: 28, color: Colors.white),
                            ),
                          )),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.2)
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                child: Container(
                                  color: Colors.white,
                                  width: 3,
                                  height: 50,
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data[index].name, style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),),
                                      Text(snapshot.data[index].date, style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modalButtom(FoodProvider prov) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add Food",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF65F9C)),
                    ),
                    RaisedButton(
                      onPressed: () {
                        prov.createData();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      color: Color(0xffF65F9C),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF65F9C).withOpacity(0.2)),
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextFormField(
                    autofocus: true,
                    onChanged: prov.setName,
                    enableSuggestions: false,
                    autocorrect: false,
                    cursorColor: Color(0xffF65F9C),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Name food",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
