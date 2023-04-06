import 'package:ecommerce_responsive/main.dart';
import 'package:ecommerce_responsive/screens/screen_account.dart';
import 'package:ecommerce_responsive/screens/screen_cart.dart';
import 'package:ecommerce_responsive/screens/screen_home.dart';
import 'package:ecommerce_responsive/screens/screen_wishlist.dart';
import 'package:ecommerce_responsive/utils/common_widget.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:nb_utils/nb_utils.dart';

import '../colors_constant.dart';
import '../images_constant.dart';



class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar(
      {Key? key,this.title,this.showActionIcon = true, this.backgroundColor, this.onBackPress, this.centerTitle, this.showLeading})
      : super(key: key);

  final String? title;
  final bool showActionIcon;
  final Color? backgroundColor;
  final VoidCallback? onBackPress;
  final bool? centerTitle;
  final bool? showLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      automaticallyImplyLeading: showLeading ?? !kIsWeb,
      title:  kIsWeb?
        GestureDetector(
          onTap: (){
            if(Get.routing.route!.settings.name != ScreenHome.tag){
              Get.toNamed(ScreenHome.tag);
            }
          },
          child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
          text("Shop", textColor: sh_textColorPrimary, fontSize: spacing_xlarge, fontFamily: fontBold),
          text("X", textColor: sh_colorPrimary, fontSize: spacing_xlarge, fontFamily: fontBold),
      ]),
        ):
      Text(title??'',style: boldTextStyle(size: 20)),
      backgroundColor: backgroundColor??Colors.transparent,
      elevation: 0,
      centerTitle: centerTitle??false,
      actions: showActionIcon ? [

        if(Get.routing.route!.settings.name != ScreenWishlist.tag)
        IconButton(
          icon: SvgPicture.asset(sh_ic_heart,color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
          onPressed: () {
            Get.toNamed(ScreenWishlist.tag);
          },
        ),
        if(Get.routing.route!.settings.name != ScreenCart.tag)
          cartIcon(context, 3),

        if(Get.routing.route!.settings.name != ScreenAccount.tag  && !context.isPhone())
          IconButton(
            icon: Image.asset(sh_user_placeholder,color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
            onPressed: () {
              Get.toNamed(ScreenAccount.tag);
            },
          ),
        const SizedBox(width: 10,)
      ]:
      null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height) ;
}
