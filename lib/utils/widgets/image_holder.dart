import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class ImageHolder extends StatelessWidget {
  const ImageHolder({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 180, minWidth: 90),
      child: Image.asset(
       imagePath,
        width: context.width * 0.25,
        height: context.width * 0.3,
        fit: BoxFit.contain,
      ),
    );
  }
}
