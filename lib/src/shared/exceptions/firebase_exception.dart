///
/// 1: invalid-email - Auth
///
/// 2: user-disabled - Auth
///
/// 3: user-not-found - Auth
///
/// 4: wrong-password - Auth
///

class FirebaseException implements Exception {
  final int statusCode;
  final String message;

  const FirebaseException([this.statusCode = 0, this.message = '']);

  @override
  String toString() =>
      "${(FirebaseException).toString()}: $statusCode: $message";
}
