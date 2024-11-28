import 'package:flutter/material.dart';

// display error massage to user
void DisplayErrorMassageToUser(String massage, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(massage),
    ),
  );
}
