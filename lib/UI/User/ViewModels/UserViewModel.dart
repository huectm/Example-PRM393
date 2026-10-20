import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:example_dart/data/reposistories/UserReposistory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'UserViewModel.g.dart';

@riverpod
class UserViewModel extends _$UserViewModel {
  @override
  Stream<fb.User?> build() {
    final repository = ref.watch(userreposistoryProvider);
    return repository.authStateChanges;
  }

  // Đăng nhập Firebase Auth
  Future<fb.UserCredential?> Login(String email, String password) async {
    try {
      final repository = ref.read(userreposistoryProvider);
      return await repository.login(email, password);
    } catch (_) {
      return null;
    }
  }

  // Đăng ký tài khoản Firebase
  Future<fb.UserCredential?> register(String email, String password) async {
    try {
      final repository = ref.read(userreposistoryProvider);
      return await repository.register(email, password);
    } catch (_) {
      return null;
    }
  }

  // Đổi mật khẩu
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final repository = ref.read(userreposistoryProvider);
      await repository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  // Đặt lại mật khẩu qua email
  Future<bool> resetPassword(String email) async {
    try {
      final repository = ref.read(userreposistoryProvider);
      await repository.resetPassword(email);
      return true;
    } catch (_) {
      return false;
    }
  }

  // Đăng xuất
  Future<void> logout() async {
    final repository = ref.read(userreposistoryProvider);
    await repository.logout();
  }
}
