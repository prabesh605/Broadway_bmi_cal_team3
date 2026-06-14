class Info {
  final String name;
  final String address;
  Info({required this.name, required this.address});
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(name: json['name'], address: json['address']);
  }
  Map<String, dynamic> toJson() => {"name": name, "address": address};
}
