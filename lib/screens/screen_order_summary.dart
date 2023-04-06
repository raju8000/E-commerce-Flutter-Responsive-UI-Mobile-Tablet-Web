
import 'package:ecommerce_responsive/screens/screen_cart.dart';
import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/cart_item.dart';
import 'package:ecommerce_responsive/utils/widgets/material_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_address.dart';
import 'package:ecommerce_responsive/models/model_product.dart';
import 'package:ecommerce_responsive/screens/screen_address_manager.dart';
import 'package:ecommerce_responsive/screens/screen_payments_screen.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/root_bundle.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';

class ScreenOrderSummary extends StatefulWidget {
  static const String tag = '/orderSummary';

  const ScreenOrderSummary({super.key});

  @override
  ScreenOrderSummaryState createState() => ScreenOrderSummaryState();
}

class ScreenOrderSummaryState extends State<ScreenOrderSummary> {
  List<ModelProduct> orderList = [];
  List<ModelAddress> addressList = [];
  var selectedPosition = 0;
  var currentIndex = 0;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var products = await loadCartProducts();
    var addresses = await loadAddresses();

    setState(() {
      orderList.clear();
      orderList.addAll(products);
      addressList.clear();
      addressList.addAll(addresses);
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    var cartList = isLoaded
        ? ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: orderList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: spacing_standard_new),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CartItem(item:orderList[index]);
              }),
        )
        : Container();

    var address = addressList.isNotEmpty?
    Card(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 480),
        padding: const EdgeInsets.all(spacing_standard_new),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("${addressList[selectedPosition].first_name!} ${addressList[selectedPosition].last_name!}", style: boldTextStyle(size: 18),),
            4.height,
            Text(addressList[selectedPosition].address.toString(), style: primaryTextStyle()),
            Text("${addressList[selectedPosition].city!},${addressList[selectedPosition].state!}", style: secondaryTextStyle()),
            Text("${addressList[selectedPosition].country!},${addressList[selectedPosition].pinCode!}", style: secondaryTextStyle()),
            16.height,
            Text(addressList[selectedPosition].phone_number.toString(), style: secondaryTextStyle()),
            16.height,
            SizedBox(
              width: double.infinity,
              height: 45,
              child: RoundedButton(
                title: sh_lbl_change_address,
                  color: sh_colorPrimary,
                  titleColor: sh_white,
                  onPress:() async {
                    var pos = await Get.toNamed(ScreenAddressManager.tag) ?? selectedPosition;
                    setState(() {
                      selectedPosition = pos;
                    });
                  },
              )
            )
          ],
        ),
      ),
    ): const SizedBox.shrink();
    var bottomButtons = Container(
      height: 60,
      decoration: const BoxDecoration(boxShadow: [BoxShadow(color: sh_shadow_color, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 3))], color: sh_white),
      child: Row(
        children: <Widget>[
          Container(
            color: context.cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("\$70", style: boldTextStyle()),
                4.height,
                Text(sh_lbl_see_price_detail, style: secondaryTextStyle()),
              ],
            ),
          ).expand(),
          Container(
            color: sh_colorPrimary,
            alignment: Alignment.center,
            height: double.infinity,
            child: text(sh_lbl_continue, textColor: sh_white, fontSize: textSizeLargeMedium, fontFamily: fontMedium),
          ).onTap(() {
            Get.toNamed(ScreenPayments.tag);
          }).expand()
        ],
      ),
    );
    return Scaffold(
      appBar: const DefaultAppBar(title: sh_order_summary),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Column(
                  children: <Widget>[
                    isLoaded && !context.isDesktop()? address : const SizedBox.shrink(),
                    Wrap(
                      children: [
                        cartList,
                        isLoaded && context.isDesktop()? address : const SizedBox.shrink(),
                      ],
                    ),
                    ScreenCartState.paymentDetail,
                  ],
                ),
              ),
            ),
            Container(color: sh_white, child: bottomButtons)
          ],
        ),
      ),
    );
  }
}
