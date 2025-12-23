import 'package:hive/hive.dart';
import '../models/auth_user.dart';

class AuthStorage {
  final Box<AuthUser> box;
  AuthStorage(this.box);

  AuthUser? get user => box.isNotEmpty ? box.getAt(0) : null;

  Future<void> save(AuthUser user) async {
    await box.clear();
    await box.add(user);
  }

  Future<void> clear() async => await box.clear();
}
