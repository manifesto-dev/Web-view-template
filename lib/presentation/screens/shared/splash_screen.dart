import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:web_app_template/business_logic/global_cubit/global_cubit.dart';
import 'package:web_app_template/constants/app_strings.dart';
import 'package:web_app_template/presentation/router/rout_names_dart.dart';
import 'package:web_app_template/presentation/styles/my_theme_data.dart';
import 'package:web_app_template/presentation/widget/svg_icons_viewer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    GlobalCubit.get(context).navigate(
        afterSuccess: () => Navigator.of(context)
            .pushReplacementNamed(RoutNamesDart.rWebScreen));
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: MyThemeData.customPurple,
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            AppStrings.appSpalshBackground,
            fit: BoxFit.fill,
          ),
        ),
        SvgIconsViewer(
          iconPath: AppStrings.splashLogo,
          iconHeight: 40.h,
          iconWidth: 60.w,
        )
      ],
    ));
  }
}
