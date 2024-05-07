import 'package:flutter/material.dart';
import 'package:web_app_template/presentation/styles/my_theme_data.dart';

class ErrorSnackBar extends SnackBar {
  final String errorText;
  final Color? newcolor;
  ErrorSnackBar({
    Key? key,
    required this.errorText,
    this.newcolor,
  }) : super(
          key: key,
          content: Text(errorText),
          backgroundColor: newcolor ?? MyThemeData.customRed,
          duration: const Duration(milliseconds: 2000),
        );
}
