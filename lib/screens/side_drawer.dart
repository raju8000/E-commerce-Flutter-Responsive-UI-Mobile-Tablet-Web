import 'package:ecommerce_responsive/models/model_category.dart';
import 'package:ecommerce_responsive/screens/screen_account.dart';
import 'package:ecommerce_responsive/screens/screen_contact_us.dart';
import 'package:ecommerce_responsive/screens/screen_faq.dart';
import 'package:ecommerce_responsive/screens/screen_order_list.dart';
import 'package:ecommerce_responsive/screens/screen_category.dart';
import 'package:ecommerce_responsive/screens/screen_wishlist.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/root_bundle.dart';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/size_constant.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  int selectedTab = 0;
  List<ModelCategory> drawerList = [];

  fetchData(){
    loadCategory().then((categories) {
      setState(() {
        drawerList.clear();
        drawerList.addAll(categories);
      });
    }).catchError((error) {
      toasty(context, error);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        elevation: 8,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: appStore.isDarkModeOn ? scaffoldDarkColor : white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                const SizedBox(height: 30),
                Container(
                  color: context.cardColor,
                  padding: const EdgeInsets.fromLTRB(0, spacing_standard, 0, spacing_standard),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Get.toNamed(ScreenOrderList.tag);
                          },
                          child: Column(
                            children: <Widget>[
                              text("08", textColor: sh_colorPrimary, fontFamily: fontMedium),
                              const SizedBox(height: spacing_control),
                              text("My Order", textColor: appStore.isDarkModeOn ? white : sh_textColorPrimary, fontFamily: fontMedium),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Get.toNamed(ScreenWishlist.tag);
                          },
                          child: Column(
                            children: <Widget>[
                              text("07", textColor: sh_colorPrimary, fontFamily: fontMedium),
                              const SizedBox(height: spacing_control),
                              text("Wishlist", textColor: appStore.isDarkModeOn ? white : sh_textColorPrimary, fontFamily: fontMedium),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if(drawerList.isNotEmpty)
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: drawerList.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return getDrawerItem(drawerList[index].image, drawerList[index].name,
                      callback: () {
                        ScreenCategory(category: drawerList[index]).launch(context);
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
                const Divider(color: sh_view_color, height: 1),
                const SizedBox(height: 20),
                getDrawerItem(sh_user_placeholder, sh_lbl_account, callback: () {
                  Navigator.of(context).pop();
                  Get.toNamed(ScreenAccount.tag);

                  /*bool isWishlist = launchScreen(context, ShAccountScreen.tag) ?? false;
                    if (isWishlist) {
                      selectedTab = 1;
                      setState(() {});
                    }*/
                }),
                const SizedBox(height: 20),
                getDrawerItem(null, sh_lbl_faq, callback: () {
                  Navigator.of(context).pop();
                  Get.toNamed(ScreenFAQ.tag);
                }),
                getDrawerItem(null, sh_lbl_contact_us, callback: () {
                  Navigator.of(context).pop();
                  Get.toNamed(ScreenContactUs.tag);
                }),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: sh_colorPrimary.withOpacity(0.2)),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: <Widget>[
                      Image.asset(ic_app_icon, width: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text("Shop", textColor: sh_textColorPrimary, fontSize: textSizeMedium, fontFamily: fontBold),
                          text("X", textColor: sh_colorPrimary, fontSize: textSizeMedium, fontFamily: fontBold),
                        ],
                      ),
                      4.height,
                      Text("v 1.0", style: primaryTextStyle(color: appStore.isDarkModeOn ? white : sh_textColorPrimary, size: 14))
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawerItem(String? icon, String? name, {VoidCallback? callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
        color: context.cardColor,
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: Row(
          children: <Widget>[
            icon != null ? Image.asset(icon, width: 20, height: 20, color: appStore.isDarkModeOn ? white : black) : Container(width: 20),
            const SizedBox(width: 20),
            Text(name!, style: primaryTextStyle(color: appStore.isDarkModeOn ? white : sh_textColorPrimary))
          ],
        ),
      ),
    );
  }
}
