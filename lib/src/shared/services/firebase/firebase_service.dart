abstract class FirebaseService {
  Future<void> initialize();

  Future<void> signIn({required String email, required String password});

  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  });

  Future<void> setTeam({required uidTeam});
}
