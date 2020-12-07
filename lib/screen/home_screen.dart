import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uda_health/model/get_data.dart';
import 'package:uda_health/model/news.dart';
import 'package:uda_health/widget/header.dart';
import 'package:uda_health/widget/news_landing.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<GetApi>(context);

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Header(),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Updated Covid",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        prov.date == null ? "-" : prov.date,
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "Deaths",
                                  style: GoogleFonts.poppins(
                                      color: Colors.red, fontSize: 18),
                                ),
                                Center(
                                    child: AutoSizeText(
                                  prov.death == null
                                      ? "0"
                                      : prov.death.toString(),
                                  minFontSize: 12,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(fontSize: 40),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "Recovered",
                                  style: GoogleFonts.poppins(
                                      color: Colors.green, fontSize: 18),
                                ),
                                Center(
                                    child: AutoSizeText(
                                  prov.recovered == null
                                      ? "0"
                                      : prov.recovered.toString(),
                                  minFontSize: 12,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(fontSize: 40),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "Active",
                                  style: GoogleFonts.poppins(
                                      color: Colors.orange, fontSize: 18),
                                ),
                                Center(
                                    child: AutoSizeText(
                                  prov.active == null
                                      ? "0"
                                      : prov.active.toString(),
                                  minFontSize: 12,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(fontSize: 40),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "Confirmed",
                                  style: GoogleFonts.poppins(
                                      color: Colors.blue, fontSize: 18),
                                ),
                                Center(
                                    child: AutoSizeText(
                                  prov.confirmed == null
                                      ? "0"
                                      : prov.confirmed.toString(),
                                  minFontSize: 12,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(fontSize: 40),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder<News>(
              future: prov.getNews(),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Center(child: Text("Data is null"));
                List<String> title = new List<String>();
                List<String> desc = new List<String>();
                List<String> url = new List<String>();
                List<String> urlImage = new List<String>();
                List<String> source = new List<String>();

                if (snapshot.data != null) {
                  for (int i = 0; i < 5; i++) {
                    if (snapshot.data.news[i].title != null)
                      title.add(snapshot.data.news[i].title);
                    else
                      title.add("");

                    if (snapshot.data.news[i].description != null)
                      desc.add(snapshot.data.news[i].description);
                    else if (snapshot.data.news[i].content != null)
                      desc.add(snapshot.data.news[i].content);
                    else
                      desc.add("");

                    if (snapshot.data.news[i].url != null)
                      url.add(snapshot.data.news[i].url);
                    else
                      url.add("");

                    if (snapshot.data.news[i].urlToImage != null)
                      urlImage.add(snapshot.data.news[i].urlToImage);
                    else
                      urlImage.add("");

                    if (snapshot.data.news[i].source != null)
                      source.add(snapshot.data.news[i].source);
                    else
                      source.add("");
                  }
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                        child: Text(
                          "News Updated",
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      NewsLandingPage(
                        title: title[0],
                        url: url[0],
                        desc: desc[0],
                        urlToImage: urlImage[0],
                        source: source[0],
                      ),
                      NewsLandingPage(
                        title: title[1],
                        url: url[1],
                        desc: desc[1],
                        urlToImage: urlImage[1],
                        source: source[1],
                      ),
                      NewsLandingPage(
                        title: title[2],
                        url: url[2],
                        desc: desc[2],
                        urlToImage: urlImage[2],
                        source: source[2],
                      ),
                      NewsLandingPage(
                        title: title[3],
                        url: url[3],
                        desc: desc[3],
                        urlToImage: urlImage[3],
                        source: source[3],
                      ),
                      NewsLandingPage(
                        title: title[4],
                        url: url[4],
                        desc: desc[4],
                        urlToImage: urlImage[4],
                        source: source[4],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
