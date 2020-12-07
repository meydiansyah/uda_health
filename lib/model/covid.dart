
class Covid {
  String date;
  int confirmed;
  int deaths;
  int active;
  int recovered;

  Covid({this.date, this.confirmed, this.deaths, this.active,
      this.recovered});

  factory Covid.fromJson(Map<String, dynamic> data) => Covid(
    date: data['Date'],
    confirmed: data['Confirmed'],
    deaths: data['Deaths'],
    active: data['Active'],
    recovered: data['Recovered']
  );

}