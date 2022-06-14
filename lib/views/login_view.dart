// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import '../firebase_options.dart';
import '../utilities/show_error.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _pass;

  @override
  void initState() {
    _email = TextEditingController();
    _pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(children: [
                TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(hintText: "Enter your email")),
                TextField(
                    controller: _pass,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                    )),
                TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final pass = _pass.text;
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: pass,
                        );
                        final userCredential =
                            FirebaseAuth.instance.currentUser;
                        if (userCredential?.emailVerified == true) {
                          Navigator.of(context).pushNamed(notesRoute);
                        } else {
                          await showError(context, "Email not verified");
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              verifyEmailRoute, (route) => false);
                        }
                      } on FirebaseAuthException catch (e) {
                        await showError(context, 'Error: ${e.code}');
                      } catch (e) {
                        await showError(context, e.toString());
                      }
                    },
                    child: const Text("Login")),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute, (route) => false);
                  },
                  child: const Text("Not Registered yet? Register Here"),
                ),
              ]);
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
