import 'package:aws_image_gallery/services/analytics_events.dart';
import 'package:aws_image_gallery/services/analytics_service.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {

  VerificationPage({Key key, this.didProvideVerificationCode})
      : super(key: key);

  final ValueChanged<String> didProvideVerificationCode;

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 40),
        child: _verificationForm(),
      ),
    );
  }

  Widget _verificationForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Verification Code TextField
        TextField(
          controller: _verificationCodeController,
          decoration: const InputDecoration(
              icon: Icon(Icons.confirmation_number),
              labelText: 'Verification code',
          ),
        ),

        // Verify Button
        FlatButton(
            onPressed: _verify,
            child: const Text('Verify'),
            color: Theme.of(context).accentColor,
        )
      ],
    );
  }

  void _verify() {
    final verificationCode = _verificationCodeController.text.trim();

    widget.didProvideVerificationCode(verificationCode);

    AnalyticsService.log(VerificationEvent());
  }
}