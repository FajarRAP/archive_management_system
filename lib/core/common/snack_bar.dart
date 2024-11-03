import 'package:flutter/material.dart';

import 'constants.dart';

void showSnackBar({required String message}) {
  rootScaffoldMessengerState.currentState!.showSnackBar(
    SnackBar(content: Text(message)),
  );
}
