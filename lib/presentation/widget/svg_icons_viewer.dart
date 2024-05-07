import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconsViewer extends StatelessWidget {
  final double? iconWidth;
  final double? iconHeight;
  final String iconPath;
  final Color? iconColor;
  const SvgIconsViewer({
    Key? key,
    this.iconWidth,
    this.iconHeight,
    this.iconColor,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: iconWidth,
      height: iconWidth,
      child: iconColor == null
          ? SvgPicture.asset(
              iconPath,
            )
          : SvgPicture.asset(
              iconPath,
              color: iconColor,
              semanticsLabel: 'Acme Logo',
            ),
    );
  }
}
