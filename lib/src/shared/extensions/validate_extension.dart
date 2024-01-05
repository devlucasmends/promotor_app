extension ValidateExtension on String {
  String? validateEmail() {
    final regexEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!regexEmail.hasMatch(this)) return 'E-mail inválido';

    return null;
  }

  String? validatePassword() {
    if (isEmpty) {
      return 'Campo obrigatório';
    } else if (length < 6) {
      return "A senha precisa ter mais de 6 dígitos";
    }
    return null;
  }
}
