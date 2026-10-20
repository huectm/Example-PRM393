import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'UserReposistory.g.dart';

@riverpod
Userreposistory userreposistory(Ref ref) => Userreposistory();

class Userreposistory {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  // Lấy thông tin user đang đăng nhập
  fb.User? get currentUser => _auth.currentUser;

  // Lắng nghe thay đổi trạng thái đăng nhập
  Stream<fb.User?> get authStateChanges => _auth.authStateChanges();

  // 1. Đăng ký tài khoản (Register)
  Future<fb.UserCredential> register(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Đăng ký tài khoản thất bại!');
    } catch (e) {
      throw Exception('Lỗi đăng ký: $e');
    }
  }

  // 2. Đăng nhập (Login)
  Future<fb.UserCredential> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Đăng nhập thất bại!');
    } catch (e) {
      throw Exception('Lỗi đăng nhập: $e');
    }
  }

  // 3. Đổi mật khẩu (Change Password)
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) {
      throw Exception('Người dùng chưa đăng nhập!');
    }

    try {
      // Re-authenticate bằng mật khẩu hiện tại trước khi cập nhật
      final fb.AuthCredential credential = fb.EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Tiến hành cập nhật mật khẩu mới
      await user.updatePassword(newPassword);
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Đổi mật khẩu thất bại!');
    } catch (e) {
      throw Exception('Lỗi đổi mật khẩu: $e');
    }
  }

  // 4. Quên / Khôi phục mật khẩu qua Email (Reset Password)
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Gửi yêu cầu đặt lại mật khẩu thất bại!');
    } catch (e) {
      throw Exception('Lỗi đặt lại mật khẩu: $e');
    }
  }

  // 5. Đăng xuất (Logout)
  Future<void> logout() async {
    await _auth.signOut();
  }
}
