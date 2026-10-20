import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../data/models/account.dart';
import '../../../../data/reposistories/account_repository.dart';

part 'AccountViewModel.g.dart';

@riverpod
class AccountViewModel extends _$AccountViewModel {
  @override
  FutureOr<Account?> build() {
    // Trạng thái tài khoản người dùng hiện tại đang đăng nhập (null là chưa đăng nhập)
    return null;
  }

  // Đăng nhập & Lấy thông tin chi tiết Account (gồm Avatar) từ bảng Account trên Firebase
  Future<Account?> loginAndFetchProfile(String email) async {
    state = const AsyncValue.loading();
    final repository = ref.read(accountRepositoryProvider);

    final account = await repository.getAccountByEmail(email);
    state = AsyncValue.data(account);
    return account;
  }

  // Đăng xuất
  void logout() {
    state = const AsyncValue.data(null);
  }

  // Lấy danh sách tất cả người dùng
  Future<List<Account>> getAllAccounts() async {
    final repository = ref.read(accountRepositoryProvider);
    return await repository.getAccounts();
  }

  // Lấy thông tin chi tiết người dùng khi bấm xem
  Future<Account?> getAccountDetail(String id) async {
    final repository = ref.read(accountRepositoryProvider);
    return await repository.getAccountById(id);
  }

  // Cập nhật hoặc lưu thông tin tài khoản
  Future<void> saveAccount(Account account) async {
    final repository = ref.read(accountRepositoryProvider);
    await repository.saveAccount(account);
    state = AsyncValue.data(account);
  }
}
