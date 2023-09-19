import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.0,
      child: Center(
        child: Text(message),
      ),
    );
  }
}
