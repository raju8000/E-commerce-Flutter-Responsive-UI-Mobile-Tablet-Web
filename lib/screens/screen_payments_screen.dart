import 'package:ecommerce_responsive/screens/screen_cart.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/material_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_payment.dart';
import 'package:ecommerce_responsive/screens/screen_add_card.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/common_widget.dart';
import 'package:ecommerce_responsive/utils/widgets/slider_widget.dart';
import 'package:ecommerce_responsive/main.dart';

class ScreenPayments extends StatefulWidget {
  static const String tag = '/payments';

  const ScreenPayments({super.key});

  @override
  ScreenPaymentsState createState() => ScreenPaymentsState();
}

class ScreenPaymentsState extends State<ScreenPayments> {
  List<ModelPaymentCard> mPaymentCards = [];

  @override
  void initState() {
    super.initState();
    mPaymentCards.add(ModelPaymentCard());
    mPaymentCards.add(ModelPaymentCard());
    mPaymentCards.add(ModelPaymentCard());
    mPaymentCards.add(ModelPaymentCard());
    mPaymentCards.add(ModelPaymentCard());
    mPaymentCards.add(ModelPaymentCard());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const DefaultAppBar(title: sh_title_payment,showActionIcon: false,),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(spacing_standard_new),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(sh_lbl_quick_pay, style: boldTextStyle()),
                  RoundedButton(
                      title: sh_lbl_add_card,
                      onPress: ()=>  Get.toNamed(ScreenAddCard.tag)),
                ],
              ),
            ),
            PaymentCards(mPaymentCards),
            Padding(
              padding: const EdgeInsets.all(spacing_standard_new),
              child: Column(
                children: <Widget>[
                  divider(),
                  InkWell(
                    onTap: ()=>Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: spacing_standard_new, bottom: spacing_standard_new),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.credit_card, color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
                          16.width,
                          Text(sh_lbl_pay_with_debit_credit_card, style: primaryTextStyle(size: textSizeSMedium.toInt())),
                        ],
                      ),
                    ),
                  ),
                  divider(),
                  InkWell(
                    onTap: ()=>Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: spacing_standard_new, bottom: spacing_standard_new),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.credit_card, color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
                          16.width,
                          Text(sh_lbl_cash_on_delivery, style: primaryTextStyle(size: textSizeSMedium.toInt())),
                        ],
                      ),
                    ),
                  ),
                  divider(),
                  ScreenCartState.paymentDetail,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class PaymentCards extends StatelessWidget {
  final List<ModelPaymentCard> mSliderList;

  const PaymentCards(this.mSliderList, {super.key});

  @override
  Widget build(BuildContext context) {

    return MyCarouselSlider(
      viewportFraction: 0.9,
      height: 210,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      items: mSliderList.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                children: [
                  Image.asset(card, fit: BoxFit.fill, width: MediaQuery.of(context).size.width, height: 210),
                  Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              text("Debit card", textColor: sh_white, fontSize: textSizeMedium, fontFamily: fontBold),
                              Flexible(child: text("MVK Bank", textColor: sh_white, fontSize: textSizeMedium, fontFamily: fontBold,))
                            ],
                          ),
                          const SizedBox(height: spacing_middle,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(chip, width: 50, height: 30, fit: BoxFit.fill,),
                                const SizedBox(height: spacing_standard_new,),
                                text("3434 3434 3434", textColor: sh_white, fontFamily: fontMedium, fontSize: textSizeMedium),
                                text("valid 12/12", textColor: sh_white, fontSize: textSizeSmall),
                                const Spacer(),
                                Expanded(child: text("JOHN", textColor: sh_white, fontFamily: fontMedium, fontSize: textSizeMedium)),
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
