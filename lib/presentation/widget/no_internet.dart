import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:web_app_template/presentation/styles/my_theme_data.dart';

// ignore: must_be_immutable
class NoInternet extends StatelessWidget {
  BuildContext context;
  NoInternet({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottis/nodata.json'),
          SizedBox(height: 5.h),
          Text(
            textAlign: TextAlign.center,
            'no internet connection',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: MyThemeData.customPurple),
          )
        ],
      ),
    );
  }
}
