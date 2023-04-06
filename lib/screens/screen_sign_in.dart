import 'package:ecommerce_responsive/screens/screen_home.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/material_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/screens/screen_sign_up.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';

class ScreenSignIn extends StatefulWidget {
  static const String tag = '/login';

  const ScreenSignIn({super.key});

  @override
  ScreenSignInState createState() => ScreenSignInState();
}

class ScreenSignInState extends State<ScreenSignIn> {
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const DefaultAppBar(title: "Sign-In",showActionIcon: false,),
      body: SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: SizedBox(
            height: context.isPhone()? null: height,
            child: Center(
              child: Card(
                elevation: 4,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 100),
                            child: Image.asset(ic_app_icon, width: width * 0.22)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            text("Sign In", textColor: sh_textColorPrimary, fontSize: spacing_large, fontFamily: fontBold),
                          ],
                        ),

                        const SizedBox(height: spacing_xlarge,),

                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          controller: emailCont,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          style: primaryTextStyle(),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: context.cardColor,
                              focusColor: sh_editText_background_active,
                              hintText: sh_hint_Email,
                              hintStyle: primaryTextStyle(),
                              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: sh_colorPrimary, width: 0.5)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                        ),
                        16.height,
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          obscureText: true,
                          style: primaryTextStyle(),
                          controller: passwordCont,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: context.cardColor,
                              focusColor: sh_editText_background_active,
                              hintStyle: primaryTextStyle(),
                              hintText: sh_hint_password,
                              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: sh_colorPrimary, width: 0.5)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                        ),

                        50.height,

                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          // height: double.infinity,
                          child: RoundedButton(
                            title: sh_lbl_sign_in,
                              color: sh_colorPrimary,titleColor: sh_white,
                              onPress: (){
                                if(kIsWeb) {
                                  Get.until((route) => route.settings.name == "/");
                                  Get.toNamed(ScreenHome.tag);
                                }
                                else{
                                  Get.until((route) => route.settings.name == ScreenHome.tag);
                                }
                              },)
                        ),
                        8.height,
                        const Divider(),
                        8.height,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Text("New To ShopX"),
                            TextButton(
                                onPressed: ()=> Get.toNamed(ScreenSignUp.tag),
                                child: const Text("Register", style: TextStyle(color: Colors.blue),),)
                          ],
                        ),
                        16.height,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
