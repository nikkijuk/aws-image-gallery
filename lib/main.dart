import 'package:aws_image_gallery/pages/login_page.dart';
import 'package:aws_image_gallery/pages/signup_page.dart';
import 'package:aws_image_gallery/pages/verification_page.dart';
import 'package:aws_image_gallery/services/auth_service.dart';
import 'package:aws_image_gallery/widgets/camera_flow.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AwsGalleryApp());
}

class AwsGalleryApp extends StatefulWidget {

  @override
  _AwsGalleryAppState createState() => _AwsGalleryAppState();
}

class _AwsGalleryAppState extends State<AwsGalleryApp> {

  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.showLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                // Show Login Page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(
                    child: LoginPage(
                      didProvideCredentials: _authService.loginWithCredentials,
                      shouldShowSignUp: _authService.showSignUp,
                    ),
                  ),

                // Show Sign Up Page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(
                      child: SignUpPage(
                        didProvideCredentials: _authService.signUpWithCredentials,
                        shouldShowLogin: _authService.showLogin,
                      ),
                  ),

                // // Show Verification Code Page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                  MaterialPage(
                    child: VerificationPage(
                      didProvideVerificationCode: _authService.verifyCode,
                    ),
                  ),

                // Show Camera Flow
                if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                    MaterialPage(
                      child: CameraFlow(shouldLogOut: _authService.logOut),
                    )
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        })
    );
  }
}

