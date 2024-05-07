import 'package:flutter/material.dart';
import 'package:web_app_template/presentation/styles/my_theme_data.dart';

class LoadingDataWidget extends StatelessWidget {
  const LoadingDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: MyThemeData.customPurple,
      ),
    );
  }
}
