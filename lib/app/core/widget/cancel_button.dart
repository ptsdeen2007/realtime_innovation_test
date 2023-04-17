import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CancelButton({Key? key,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed: onPressed,
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.blue),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade50,
        ));
  }
}
