import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key? key, required this.onPress, this.title, this.color,this.titleColor,this.width}) : super(key: key);
  final VoidCallback onPress;
  final String? title;
  final double ? width;
  final Color? color;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: sh_colorPrimary,
      color: color,
      minWidth: width,
      padding: const EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, top: 0, bottom: 0),
      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(spacing_large),
        side: const BorderSide(color: sh_colorPrimary),
      ),
      onPressed: onPress,
      child: text(title??sh_lbl_add_card, fontSize: textSizeSMedium, textColor: titleColor??sh_colorPrimary),
    );
  }
}
