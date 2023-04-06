import 'package:ecommerce_responsive/screens/screen_home.dart';
import 'package:ecommerce_responsive/screens/screen_sign_in.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/material_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';

class ScreenSignUp extends StatefulWidget {
  static const String tag = '/signUp';

  const ScreenSignUp({super.key});

  @override
  ScreenSignUpState createState() => ScreenSignUpState();
}

class ScreenSignUpState extends State<ScreenSignUp> {
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var confirmPasswordCont = TextEditingController();
  var firstNameCont = TextEditingController();
  var lastNameCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const DefaultAppBar(title: "Sign Up",showActionIcon: false),
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.isPhone()? null: height,
          child: Center(
            child: Card(
              elevation: 4,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 550),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Image.asset(ic_app_icon, width: width * 0.22)),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text("Sign Up", textColor: sh_textColorPrimary, fontSize: spacing_xlarge, fontFamily: fontBold),
                        ],
                      ),
                      32.height,
                      SizedBox(
                        width: double.infinity,
                        child: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints) {
                            return Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  width: context.isPhone()? constraints.maxWidth: constraints.maxWidth * 0.49,
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: false,
                                    textInputAction: TextInputAction.next,
                                    controller: firstNameCont,
                                    textCapitalization: TextCapitalization.words,
                                    style: primaryTextStyle(),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: context.cardColor,
                                        focusColor: sh_editText_background_active,
                                        hintText: sh_hint_first_name,
                                        hintStyle: primaryTextStyle(),
                                        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: sh_colorPrimary, width: 0.5)),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                  ),
                                ),

                                Container(
                                  width: context.isPhone()? constraints.maxWidth: constraints.maxWidth * 0.49,
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: false,
                                    controller: lastNameCont,
                                    textInputAction: TextInputAction.next,
                                    textCapitalization: TextCapitalization.words,
                                    style: primaryTextStyle(),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: context.cardColor,
                                        focusColor: sh_editText_background_active,
                                        hintText: sh_hint_last_name,
                                        hintStyle: primaryTextStyle(),
                                        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: sh_colorPrimary, width: 0.5)),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                      //16.height,
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
                        textInputAction: TextInputAction.next,
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
                      16.height,
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        obscureText: true,
                        style: primaryTextStyle(),
                        controller: confirmPasswordCont,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: context.cardColor,
                            focusColor: sh_editText_background_active,
                            hintStyle: primaryTextStyle(),
                            hintText: sh_hint_confirm_password,
                            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: sh_colorPrimary, width: 0.5)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                      ),
                      32.height,
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child:
                        RoundedButton(
                          title: sh_lbl_sign_up,
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
                          const Text("Joined us before"),
                          TextButton(
                            onPressed: ()=> Get.toNamed(ScreenSignIn.tag),
                            child: const Text("Sign-In", style: TextStyle(color: Colors.blue),),)
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
    );
  }
}
