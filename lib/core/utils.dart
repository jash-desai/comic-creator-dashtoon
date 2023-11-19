import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'globals/colors_globals.dart';
import 'globals/fonts_globals.dart';

// toast with given input text
void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    fontSize: 16,
  );
}

// generalized text decoration to reduce code repetitions

InputDecoration textboxDecoration(String text) {
  return InputDecoration(
    filled: true,
    hintText: text,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: iconColor),
      borderRadius: BorderRadius.circular(7.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kBlue),
      borderRadius: BorderRadius.circular(7.5),
    ),
    hintStyle: Fonts.light.setColor(textColor.withOpacity(0.7)).size(15),
    fillColor: const Color.fromRGBO(39, 41, 45, 1),
    border: InputBorder.none,
    contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: iconColor),
      borderRadius: BorderRadius.circular(7.5),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: iconColor),
      borderRadius: BorderRadius.circular(7.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kBlue),
      borderRadius: BorderRadius.circular(7.5),
    ),

    //THIS WAS WHAT WAS NEEDED:
    errorStyle: const TextStyle(height: 0, color: Colors.transparent),
  );
}
