import 'package:ecommerce_responsive/screens/screen_contact_us.dart';
import 'package:ecommerce_responsive/screens/screen_profile.dart';
import 'package:ecommerce_responsive/screens/screen_sign_in.dart';
import 'package:ecommerce_responsive/screens/screen_wishlist.dart';
import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/footer.dart';
import 'package:ecommerce_responsive/utils/widgets/material_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/screens/screen_address_manager.dart';
import 'package:ecommerce_responsive/screens/screen_quick_pay_cards.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/main.dart';
import 'screen_order_list.dart';

class ScreenAccount extends StatefulWidget {
  static const String tag = '/account';

  const ScreenAccount({super.key});

  @override
  ScreenAccountState createState() => ScreenAccountState();
}

class ScreenAccountState extends State<ScreenAccount> {
  var firstNameCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      firstNameCont.text = "+919656231245";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: sh_lbl_account,),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: constraints.copyWith(
                minHeight: constraints.maxHeight,
                maxHeight: double.infinity,
              ),
              child: IntrinsicHeight(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: <Widget>[
                      30.height,
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: spacing_standard,
                        margin: const EdgeInsets.all(spacing_control),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                        child: const CircleAvatar(backgroundImage: AssetImage(ic_user), radius: 60).paddingAll(4),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Michal Deerman", style: boldTextStyle(size: 24)),
                          const SizedBox(width: 20,),

                          Card(
                            elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.edit),
                              )
                          ).onTap(()=> Get.toNamed(ScreenProfile.tag))

                        ],
                      ),

                      Card(
                        elevation: 5,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          padding: const EdgeInsets.all(spacing_middle),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(child: Text(sh_lbl_please_verify_your_email_or_number, style: primaryTextStyle(),maxLines: 2,overflow: TextOverflow.ellipsis)),
                                  Image.asset(sh_radar, width: 30, height: 30),
                                ],
                              ),
                              2.height,
                              Text(sh_lbl_get_newest_offers, style: secondaryTextStyle()),
                              16.height,
                              Stack(
                                alignment: Alignment.centerRight,
                                children: <Widget>[
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    controller: firstNameCont,
                                    textCapitalization: TextCapitalization.words,
                                    style: primaryTextStyle(),
                                    decoration: InputDecoration(
                                        filled: false,
                                        contentPadding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5)),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0))),
                                  ),
                                  RoundedButton(
                                    title: sh_lbl_verify_now,
                                    color: sh_colorPrimary,
                                    titleColor: sh_white,
                                    onPress:(){},
                                  ).marginSymmetric(horizontal: 20),
                                ],
                              )
                            ],
                          ),
                        ),
                      ).marginAll(spacing_standard_new),

                      Padding(
                        padding: const EdgeInsets.only(left: spacing_standard_new, bottom: spacing_standard_new, right: spacing_standard_new),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: <Widget>[

                            Container(
                              constraints: const BoxConstraints(maxWidth: 450),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  getRowItem(sh_lbl_address_manager, callback: () => Get.toNamed(ScreenAddressManager.tag)),
                                  const SizedBox(height: spacing_standard_new),
                                  getRowItem(sh_lbl_my_order, callback: () => Get.toNamed(ScreenOrderList.tag)),
                                  const SizedBox(height: spacing_standard_new),
                                  getRowItem(sh_lbl_wish_list, callback: () => Get.toNamed(ScreenWishlist.tag)),
                                  const SizedBox(height: spacing_standard_new),
                                ],
                              ),
                            ),

                            Container(
                              constraints: const BoxConstraints(maxWidth: 450),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [

                                  getRowItem(sh_lbl_quick_pay_cards, callback: ()=> Get.toNamed(ScreenQuickPayCards.tag)),
                                  const SizedBox(height: spacing_standard_new),
                                  getRowItem(sh_lbl_help_center, callback: () => Fluttertoast.showToast(msg: "Under Development") ),
                                  const SizedBox(height: spacing_standard_new),
                                  getRowItem(sh_lbl_contact_us, callback: () => Get.toNamed(ScreenContactUs.tag) ),
                                  const SizedBox(height: spacing_standard_new),
                                ],
                              ),
                            ),



                            const SizedBox(height: 30),

                            Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(maxWidth: 500),
                              height: 45,
                              child: RoundedButton(
                                title: "Sign Out",
                                onPress: () => Get.toNamed(ScreenSignIn.tag))
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Footer()
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget getRowItem(String title, {VoidCallback? callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1)),
        padding: const EdgeInsets.fromLTRB(spacing_standard, 0, spacing_control_half, 0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(title, style: primaryTextStyle())),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_right, color: appStore.isDarkModeOn ? white : sh_textColorPrimary, size: 24),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
