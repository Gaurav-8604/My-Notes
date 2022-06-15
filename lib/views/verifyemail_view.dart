import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/services/auth/auth_service.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Column(
        children: [
          const Text("Email not verified."),
          const Text("We've sent an email verification link."),
          const Text('Please verify your email address.'),
          const Text(""),
          const Text(""),
          const Text(""),
          const Text("Haven't received email. Click the below button"),
          TextButton(
              onPressed: () {
                AuthService.firebase().sendEmailVerification();
              },
              child: const Text('Send Email')),
          TextButton(
              onPressed: () async {
                AuthService.firebase().logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Restart')),
        ],
      ),
    );
  }
}
