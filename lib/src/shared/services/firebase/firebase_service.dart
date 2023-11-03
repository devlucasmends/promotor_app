abstract class FirebaseService {
  Future<void> initialize();

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();

  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  });

  Future<void> createTeam();

  Future<void> setTeam({required uidTeam});
}
