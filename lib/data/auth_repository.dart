import '../core/storage.dart';
import '../models/auth_user.dart';
import 'auth_remote_source.dart';

class AuthRepository {
  final AuthRemoteSource remote;
  final AuthStorage storage;

  AuthRepository({required this.remote, required this.storage});

  Future<AuthUser> login(String email, String password) async {
    final user = await remote.login(email, password);
    await storage.save(user);
    return user;
  }

  AuthUser? get currentUser => storage.user;

  Future<void> logout() async => await storage.clear();
}
