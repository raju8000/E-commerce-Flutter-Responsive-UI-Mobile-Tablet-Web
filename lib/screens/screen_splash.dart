import 'dart:async';

import 'package:ecommerce_responsive/screens/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors_constant.dart';
import '../utils/images_constant.dart';
import '../utils/widgets/app_widget.dart';

class ScreenSplash extends StatefulWidget {
  static const String tag = '/';

  const ScreenSplash({super.key});

  @override
  ScreenSplashState createState() => ScreenSplashState();
}

class ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    changeStatusColor(Colors.transparent);
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    finish(context);
    Get.offAndToNamed(ScreenHome.tag);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        width: width + width * 0.4,
        child: Stack(
          children: <Widget>[
            Image.asset(
              splash_bg,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: -width * 0.2,
              left: -width * 0.2,
              child: Container(
                width: width * 0.65,
                height: width * 0.65,
                decoration: BoxDecoration(shape: BoxShape.circle, color: sh_colorPrimary.withOpacity(0.3)),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(ic_app_icon, width: width * 0.3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Shop", style: boldTextStyle(color: sh_textColorPrimary, size: 35, fontFamily: 'Bold')),
                      Text("X", style: boldTextStyle(color: sh_colorPrimary, size: 35, fontFamily: 'Bold')),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: -width * 0.2,
                    right: -width * 0.2,
                    child: Container(
                      width: width * 0.65,
                      height: width * 0.65,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: sh_colorPrimary.withOpacity(0.3)),
                    ),
                  ),
                ],
              ),
            ),
            Align(alignment: Alignment.bottomRight, child: Image.asset(splash_img, width: width * 0.5, height: width * 0.5))
          ],
        ),
      ),
    );
  }
}
