import 'package:ecommerce_responsive/screens/screen_account.dart';
import 'package:ecommerce_responsive/screens/screen_contact_us.dart';
import 'package:ecommerce_responsive/screens/screen_faq.dart';
import 'package:ecommerce_responsive/screens/screen_home.dart';
import 'package:ecommerce_responsive/screens/screen_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../app_constant.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: orange,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Wrap(
          children: [
            if(Get.routing.route!.settings.name != ScreenHome.tag)
            footerItem("Home", ScreenHome.tag),

            10.width,
            if(Get.routing.route!.settings.name != ScreenWishlist.tag)
            footerItem("Wish List", ScreenWishlist.tag),

            10.width,
            if(Get.routing.route!.settings.name != ScreenAccount.tag)
            footerItem("Account", ScreenAccount.tag),

            10.width,
            if(Get.routing.route!.settings.name != ScreenContactUs.tag)
            footerItem("Contact Us", ScreenContactUs.tag),

            10.width,
            if(Get.routing.route!.settings.name != ScreenFAQ.tag)
            footerItem("FAQ", ScreenFAQ.tag),

          ],
        ),
      ),
    );
  }

  Widget footerItem(String item,String routeName){
    return Text(item,style: const TextStyle(fontSize: textSizeLargeMedium,fontFamily: fontMedium,color: white,decoration: TextDecoration.underline),).onTap((){
      Get.toNamed(routeName);
    });
  }
}
