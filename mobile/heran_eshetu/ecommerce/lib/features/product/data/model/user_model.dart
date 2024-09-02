import '../../domain/entitity/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['_id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'email': super.email,
    };
  }

  factory UserModel.fromUser(User user) {
    return UserModel(id: user.id, name: user.name, email: user.email);
  }
}
