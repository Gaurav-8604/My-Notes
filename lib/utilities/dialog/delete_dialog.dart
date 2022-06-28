import 'package:flutter/material.dart';
import 'package:notes/utilities/dialog/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: "Delete Note",
      content: "Are you sure you want to delete?",
      optionsBuilder: () => {
            'Cancel': false,
            'Delete': true,
          }).then((value) => value ?? false);
}
