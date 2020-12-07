class Food {
  String name;
  String date;

  Food({this.name, this.date});

  factory Food.fromJson(Map<String, dynamic> json) => Food(
      name: json['name'],
      date: json['date']
  );
}