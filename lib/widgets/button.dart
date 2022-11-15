import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String inputText;
  final Function() onPressed;

  const CustomButton(
      {super.key, required this.inputText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      height: 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).primaryColor),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          inputText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
