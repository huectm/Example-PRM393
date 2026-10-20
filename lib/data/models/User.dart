class User {
  final String? id;
  final String? name;
  final String Email;
  final String Password;
  final String? avatar;
  final String? phone;

  User({
    this.id,
    this.name,
    required this.Email,
    required this.Password,
    this.avatar,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      Email: (json['Email'] ?? json['email'] ?? '') as String,
      Password: (json['Password'] ?? json['password'] ?? '') as String,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'Email': Email,
      'Password': Password,
      'avatar': avatar,
      'phone': phone,
    };
  }
}
