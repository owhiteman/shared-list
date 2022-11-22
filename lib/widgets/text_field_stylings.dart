import 'package:flutter/material.dart';

class LoginTextFieldDecoration {
  InputDecoration decoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: const Color.fromARGB(255, 232, 232, 232),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    );
  }
}
