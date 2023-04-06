import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';

class ScreenFAQ extends StatefulWidget {
  static const String tag = '/faq';

  const ScreenFAQ({super.key});

  @override
  ScreenFAQState createState() => ScreenFAQState();
}

class ScreenFAQState extends State<ScreenFAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: sh_lbl_faq,),
      body:LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      ExpansionTile(
                        title: getTitle(sh_lbl_account_deactivate),
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  getSubTitle(sh_lbl_account_deactivate),
                                  getSubTitle(sh_lbl_quick_pay),
                                  getSubTitle(sh_lbl_return_items),
                                  getSubTitle(sh_lbl_replace_items),
                                ],
                              )),
                        ],
                      ),
                      ExpansionTile(
                        title: getTitle(sh_lbl_quick_pay),
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                getSubTitle(sh_lbl_account_deactivate),
                                getSubTitle(sh_lbl_quick_pay),
                                getSubTitle(sh_lbl_return_items),
                                getSubTitle(sh_lbl_replace_items),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: getTitle(sh_lbl_return_items),
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                getSubTitle(sh_lbl_account_deactivate),
                                getSubTitle(sh_lbl_quick_pay),
                                getSubTitle(sh_lbl_return_items),
                                getSubTitle(sh_lbl_replace_items),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: getTitle(sh_lbl_replace_items),
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                getSubTitle(sh_lbl_account_deactivate),
                                getSubTitle(sh_lbl_quick_pay),
                                getSubTitle(sh_lbl_return_items),
                                getSubTitle(sh_lbl_replace_items),
                              ],
                            ),
                          ),
                        ],
                      ),
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
            );
          }
      )
    );
  }

  Widget getTitle(String content) {
    return Text(content, style: primaryTextStyle());
  }

  Widget getSubTitle(String content) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, spacing_standard, 16.0, spacing_standard),
      child: Text(content, style: secondaryTextStyle()),
    );
  }
}
