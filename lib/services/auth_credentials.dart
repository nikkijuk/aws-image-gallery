abstract class AuthCredentials {

  AuthCredentials({this.username, this.password});

  final String username;
  final String password;
}

class LoginCredentials extends AuthCredentials {
  LoginCredentials({String username, String password})
      : super(username: username, password: password);
}

class SignUpCredentials extends AuthCredentials {
  SignUpCredentials({String username, String password, this.email})
      : super(username: username, password: password);

  final String email;
}