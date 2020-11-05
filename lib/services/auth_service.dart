import 'dart:async';

import 'auth_credentials.dart';

enum AuthFlowStatus { 
  login, 
  signUp, 
  verification, 
  session,
}

class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({this.authFlowStatus});
}

class AuthService {
  final authStateController = StreamController<AuthState>();

  void showSignUp() {
    _emitState(AuthFlowStatus.signUp);
  }
  
  void showLogin() {
    _emitState(AuthFlowStatus.login);
  }

  void loginWithCredentials(AuthCredentials credentials) {
    _emitState(AuthFlowStatus.session);
  }

  void signUpWithCredentials(SignUpCredentials credentials) {
    _emitState(AuthFlowStatus.verification);
  }

  void verifyCode(String verificationCode) {
    _emitState(AuthFlowStatus.session);
  }

  void logOut() {
    _emitState(AuthFlowStatus.login);
  }

  void _emitState(AuthFlowStatus authFlowStatus) {
    final state = AuthState(authFlowStatus: authFlowStatus);
    authStateController.add(state);
  }

}