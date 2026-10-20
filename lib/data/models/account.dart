class Account {
  final String id;
  final String email;
  final String name;
  final String avatar;
  final String phone;

  Account({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.phone,
  });

  // Chuyển đổi từ JSON Map sang đối tượng Account
  factory Account.fromJson(Map<String, dynamic> json, {String? id}) {
    return Account(
      id: id ?? (json['id'] as String? ?? ''),
      email: (json['email'] as String? ?? ''),
      name: (json['name'] as String? ?? ''),
      avatar: (json['avatar'] as String? ?? ''),
      phone: (json['phone'] as String? ?? ''),
    );
  }

  // Chuyển đổi từ Account sang Map để lưu trên Firebase Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'phone': phone,
    };
  }

  // Tạo bản sao đối tượng khi cần cập nhật
  Account copyWith({
    String? id,
    String? email,
    String? name,
    String? avatar,
    String? phone,
  }) {
    return Account(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
    );
  }
}
