
class Food {
  String name;
  String date;

  Food({this.name, this.date});

  factory Food.fromJson(Map<String, dynamic> data) => Food(
    name: data['name'],
    date: data['date']
  );


}