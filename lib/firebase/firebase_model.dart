class FirebaseModel {
  String? id;
  String name;
  String year;
  String marks;
  FirebaseModel({
    required this.name,
    required this.year,
    required this.marks,
    required this.id,
  });
  factory FirebaseModel.fromJson(Map<String, dynamic> json, String id) {
    return FirebaseModel(
      id: id,
      name: json['Name'],
      year: json['Year'],
      marks: json['Marks'],
    );
  }
  Map<String, dynamic> toJson() => {
    'Name': name,
    'Year': year,
    'Marks': marks,
    // 'id': id,
  };
}
