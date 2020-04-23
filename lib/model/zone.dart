class Zone {
  String code;
  String location;
  String state;
  String country;

  Zone.fromJson(Map<String, dynamic> json): code = json['code'],
        location = json['location'],
        state = json["state"],
        country = json["country"];

  Map toJson() {
    return {'code': code, 'location': location, 'state': state, 'country': country};
  }
}
