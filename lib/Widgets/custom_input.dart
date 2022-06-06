import 'package:beru_app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

InputDecoration customInput(String label) {
  return InputDecoration(
      labelStyle: const TextStyle(
        color: AppColors.black,
        fontFamily: AppFonts.fontMedium,
        fontSize: 20
      ),
      labelText: label,
      helperText: '',
      helperStyle: const TextStyle(height: 0.7),
      errorStyle: const TextStyle(height: 0.7),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))));
}
