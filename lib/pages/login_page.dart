import 'package:aws_image_gallery/services/analytics_events.dart';
import 'package:aws_image_gallery/services/analytics_service.dart';
import 'package:aws_image_gallery/services/auth_credentials.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.didProvideCredentials, this.shouldShowSignUp})
      : super(key: key);

  final ValueChanged<LoginCredentials> didProvideCredentials;
  final VoidCallback shouldShowSignUp;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            _loginForm(),
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                  onPressed: widget.shouldShowSignUp,
                  child: const Text('Don\'t have an account? Sign up.'),
              ),
            )
          ])),
    );
  }

  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            icon: Icon(Icons.mail),
            labelText: 'Username',
          ),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock_open),
            labelText: 'Password',
          ),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        FlatButton(
          onPressed: _login,
          child: const Text('Login'),
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // ignore: avoid_print
    print('username: $username');
    // ignore: avoid_print
    print('password: $password');

    final credentials = LoginCredentials(
        username: username,
        password: password);

    widget.didProvideCredentials(credentials);

    AnalyticsService.log(LoginEvent());
  }
}