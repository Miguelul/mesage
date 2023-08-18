import 'package:flutter/material.dart';

import '../constanst.dart';


class InputDecorations {

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: kPrimaryColor
          ),
        ),
        focusedBorder: UnderlineInputBorder(
           borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: kPrimaryColor,
            width: 2
          )
        ),
        filled: true,
        fillColor: primaryColor,
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey
        ),

        prefixIcon: prefixIcon != null 
          ? Icon( prefixIcon, color: kPrimaryColor )
          : null
      );
  }  

}