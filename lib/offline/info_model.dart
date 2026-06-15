class Info {
  final String name;
  final String address;
  final int id;
  Info({required this.id, required this.name, required this.address});
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(id: json['id'], name: json['name'], address: json['address']);
  }
  Map<String, dynamic> toJson() => {"name": name, "address": address};
}
