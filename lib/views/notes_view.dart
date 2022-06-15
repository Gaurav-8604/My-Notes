// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:notes/main.dart';
import '../constants/routes.dart';
import '../enums/menu_actions.dart';
import '../services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notes"),
          actions: [
            PopupMenuButton(onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final logout = await logoutDialog(context);
                  if (logout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
              }
            }, itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text("Log out"),
                )
              ];
            })
          ],
        ),
        body: const Text("Hello World"));
  }
}
