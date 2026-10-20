import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/account.dart';

part 'account_repository.g.dart';

@riverpod
AccountRepository accountRepository(Ref ref) {
  return AccountRepository();
}

class AccountRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'Account';

  // Tài khoản mẫu theo yêu cầu
  final Account sampleAccount = Account(
    id: "account1",
    email: "huectm@gmail.com",
    name: "Chu Thị Minh Huệ",
    avatar: "https://i.pravatar.cc/150?img=5",
    phone: "0901234567",
  );

  // 1. Lấy tất cả danh sách tài khoản từ bảng Account trên Firebase
  Future<List<Account>> getAccounts() async {
    try {
      final snapshot = await _firestore.collection(collectionName).get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((doc) => Account.fromJson(doc.data(), id: doc.id))
            .toList();
      }
    } catch (_) {}

    // Trả về tài khoản mẫu nếu trên Firestore chưa có dữ liệu hoặc offline
    return [sampleAccount];
  }

  // 2. Lấy thông tin tài khoản chi tiết theo Email (Hiển thị Avatar & Profile khi Login)
  Future<Account?> getAccountByEmail(String email) async {
    try {
      final snapshot = await _firestore
          .collection(collectionName)
          .where('email', isEqualTo: email.toLowerCase().trim())
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        return Account.fromJson(doc.data(), id: doc.id);
      }
    } catch (_) {}

    // Fallback cho tài khoản mẫu
    if (email.toLowerCase().trim() == sampleAccount.email.toLowerCase()) {
      return sampleAccount;
    }

    return null;
  }

  // 3. Lấy thông tin chi tiết người dùng theo ID
  Future<Account?> getAccountById(String id) async {
    try {
      final doc = await _firestore.collection(collectionName).doc(id).get();
      if (doc.exists && doc.data() != null) {
        return Account.fromJson(doc.data()!, id: doc.id);
      }
    } catch (_) {}

    if (id == sampleAccount.id) return sampleAccount;
    return null;
  }

  // 4. Lưu / Thêm tài khoản mới vào bảng Account trên Firebase Firestore
  Future<void> saveAccount(Account account) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(account.id.isEmpty ? null : account.id)
          .set(account.toJson(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Lưu tài khoản thất bại: $e');
    }
  }
}
