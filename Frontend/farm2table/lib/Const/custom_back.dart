import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/Images/const/back.png',
        width: 22,
        height: 22,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}