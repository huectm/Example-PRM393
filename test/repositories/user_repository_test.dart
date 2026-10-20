import 'package:flutter_test/flutter_test.dart';
import 'package:example_dart/data/models/user.dart';

void main() {
  group('User Model Unit Tests', () {
    test('Khởi tạo đối tượng User hợp lệ', () {
      final user = User(
        id: 'u1',
        name: 'Nguyễn Văn A',
        Email: 'nguyenvana@gmail.com',
        Password: '123',
      );

      expect(user.id, equals('u1'));
      expect(user.name, equals('Nguyễn Văn A'));
      expect(user.Email, equals('nguyenvana@gmail.com'));
      expect(user.Password, equals('123'));
    });

    test('Chuyển đổi từ và sang JSON chính xác', () {
      final json = {
        'id': 'u2',
        'name': 'Trần Thị B',
        'Email': 'tranthib@gmail.com',
        'Password': '123',
      };

      final user = User.fromJson(json);
      expect(user.name, equals('Trần Thị B'));

      final jsonMap = user.toJson();
      expect(jsonMap['Email'], equals('tranthib@gmail.com'));
    });
  });
}
