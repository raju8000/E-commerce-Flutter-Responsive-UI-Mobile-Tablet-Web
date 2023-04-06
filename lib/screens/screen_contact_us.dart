import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/footer.dart';
import 'package:ecommerce_responsive/utils/widgets/material_button.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/common_widget.dart';
import 'package:ecommerce_responsive/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenContactUs extends StatefulWidget {
  static const String tag = '/contactUs';

  const ScreenContactUs({super.key});

  @override
  ScreenContactUsState createState() => ScreenContactUsState();
}

class ScreenContactUsState extends State<ScreenContactUs> {

  bool showContactUsForm = false;
  var emailCont = TextEditingController();
  var descriptionCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: sh_lbl_contact_us,),

      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Column(
                          children: [

                            InkWell(
                              onTap: () {
                                launch("tel:$sh_contact_phone");
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(sh_lbl_call_request, style: primaryTextStyle()),
                                      Icon(Icons.keyboard_arrow_right, color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
                                    ],
                                  ),
                                  Text(sh_contact_phone, style: secondaryTextStyle()),
                                  const SizedBox(height: spacing_standard_new),
                                  divider()
                                ],
                              ),
                            ),

                            const SizedBox(height: spacing_standard_new),

                          ],
                        ),
                      ),
                    ),


                    20.height,


                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: emailCont,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  textCapitalization: TextCapitalization.words,
                                  style: primaryTextStyle(),
                                  autofocus: false,
                                  decoration: formFieldDecoration(sh_lbl_your_email),
                                ),
                                16.height,
                                TextFormField(
                                  controller: descriptionCont,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.next,
                                  textCapitalization: TextCapitalization.words,
                                  style: primaryTextStyle(),
                                  autofocus: false,
                                  decoration: formFieldDecoration(sh_lbl_description),
                                ),
                                50.height,

                                SizedBox(
                                  height: 45,
                                  child: RoundedButton(
                                    title: sh_lbl_send_mail,
                                    width: double.infinity,
                                    color: sh_colorPrimary,
                                      titleColor: sh_white,
                                      onPress: () {},
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),

            const Footer()
          ],
        ),

      ),
    );
  }
}
