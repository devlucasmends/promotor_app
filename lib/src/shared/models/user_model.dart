class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String squad;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    this.squad = '',
  });

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'].toString(),
        name: json['name'].toString(),
        phone: json['phone'].toString(),
        email: json['email'].toString(),
      );

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}
