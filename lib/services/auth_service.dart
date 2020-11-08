import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:equatable/equatable.dart';

import 'auth_credentials.dart';

enum AuthFlowStatus { 
  login, 
  signUp, 
  verification, 
  session,
}

class AuthState extends Equatable {
  AuthState({this.authFlowStatus});

  final AuthFlowStatus authFlowStatus;

  @override
  List<Object> get props => [authFlowStatus];

  @override
  bool get stringify => true;
}

class AuthService {
  final authStateController = StreamController<AuthState>();

  AuthCredentials _credentials;

  void showSignUp() {
    _emitState(AuthFlowStatus.signUp);
  }
  
  void showLogin() {
    _emitState(AuthFlowStatus.login);
  }

  void signUpWithCredentials(SignUpCredentials credentials) async {
    try {
      final userAttributes = {'email': credentials.email};

      final result = await Amplify.Auth.signUp(
        username: credentials.username,
        password: credentials.password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );

      // ignore: avoid_print
      print ('SignUp result $result');

      _credentials = credentials;
      _emitState(AuthFlowStatus.verification);

      // this is original block of code which didn't work as expected
      // reason: result.isSignUpComplete is true even if singUp
      // of account is not yet confirmed using confirmSignUp and confirmation code.
      // I felt it safe to change this so that signUp needs always to be verified
      // result: login never follows signUp directly as each singUp is verified always
      // docs: https://docs.amplify.aws/lib/auth/signin/q/platform/flutter
      /*
      if (result.isSignUpComplete) {
        loginWithCredentials(credentials);
      } else {
        _credentials = credentials;
        _emitState(AuthFlowStatus.verification);
      }
      */

    } on AuthError catch (authError) {

      // ignore: avoid_print
      print('Failed to sign up - ${authError.cause}');
    }
  }

  void verifyCode(String verificationCode) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: _credentials.username,
        confirmationCode: verificationCode,
      );

      if (result.isSignUpComplete) {
        loginWithCredentials(_credentials);
      } else {
        // ??
      }
    } on AuthError catch (authError) {

      // ignore: avoid_print
      print('Could not verify code - ${authError.cause}');
    }
  }

  void loginWithCredentials(AuthCredentials credentials) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: credentials.username,
        password: credentials.password,
      );

      if (result.isSignedIn) {
        _emitState(AuthFlowStatus.session);
      } else {

        // ignore: avoid_print
        print('User could not be signed in');
      }

    } on AuthError catch (authError) {

      // ignore: avoid_print
      print('Could not login - ${authError.cause}');
    }
  }

  void logOut() async {
    try {
      await Amplify.Auth.signOut();

      showLogin();
    } on AuthError catch (authError) {

      // ignore: avoid_print
      print('Could not log out - ${authError.cause}');
    }
  }

  void checkAuthStatus() async {
    try {
      await Amplify.Auth.fetchAuthSession();

      _emitState(AuthFlowStatus.session);
    } catch (_) {
      _emitState(AuthFlowStatus.login);
    }
  }

  void _emitState(AuthFlowStatus authFlowStatus) {
    // ignore: avoid_print
    print ('auth emits $authFlowStatus');

    authStateController.add(AuthState(authFlowStatus: authFlowStatus));
  }

}