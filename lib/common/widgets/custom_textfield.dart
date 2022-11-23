// ignore_for_file: prefer_const_constructors

import 'package:amazon_clone/constants/global%20variables.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  CustomTextField(
    this.controller,
    this.hintText,
    this.obsecureText,
  );
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        // labelText: hintText,
        // labelStyle: TextStyle(color: GlobalVariables.secondaryColor),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: GlobalVariables.secondaryColor),
        ),
        hintText: hintText,
        // hintStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${hintText}';
        }
        return null;
      },
    );
  }
}
