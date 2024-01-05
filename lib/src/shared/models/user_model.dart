class UserModel {
  late String uid;
  final String name;
  final String phone;
  final String email;
  final String team;
  final int yellowAlert;
  final int redAlert;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    this.yellowAlert = 30,
    this.redAlert = 15,
    this.team = '',
  });

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'].toString(),
        name: json['name'].toString(),
        phone: json['phone'].toString(),
        email: json['email'].toString(),
        team: json['team'].toString(),
        yellowAlert: json['yellowAlarm'] ?? 30,
        redAlert: json['redAlarm'] ?? 15,
      );

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
      'team': team,
      'yellowAlarm': yellowAlert,
      'redAlarm': redAlert,
    };
  }
}
