import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/cart_item.dart';
import 'package:ecommerce_responsive/utils/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_product.dart';
import 'package:ecommerce_responsive/screens/screen_order_summary.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/root_bundle.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';

class ScreenCart extends StatefulWidget {
  static const String tag = '/cart';

  const ScreenCart({super.key});

  @override
  ScreenCartState createState() => ScreenCartState();
}

class ScreenCartState extends State<ScreenCart> {
  List<ModelProduct> cartList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var products = await loadCartProducts();
    setState(() {
      cartList.clear();
      cartList.addAll(products);
    });
  }

  static Widget paymentDetail =
  Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle, spacing_standard_new, spacing_middle),
            child: Text(sh_lbl_payment_details, style: boldTextStyle(size: 14)),
          ),
          const Divider(height: 1, color: sh_view_color),
          Padding(
            padding: const EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle, spacing_standard_new, spacing_middle),
            child: Column(
              children: [
                Row(
                  children: [
                    text(sh_lbl_offer,fontSize: 14),
                    4.width,
                    Text(sh_text_offer_not_available, style: primaryTextStyle(size: 14)),
                  ],
                ),
                8.height,
                Row(
                  children: [
                    text(sh_lbl_shipping_charge,fontSize: 14),
                    text(sh_lbl_free, textColor: Colors.green, fontFamily: fontMedium,fontSize: 14),
                  ],
                ),
                8.height,
                Row(
                  children: [
                    text(sh_lbl_total_amount,fontSize: 14),
                    text("\$70", textColor: sh_colorPrimary, fontFamily: fontBold, fontSize: 14),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var cartListWidget =  context.isDesktop()?
    GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: width<840? 2: 2.8),
            itemCount: cartList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return IntrinsicHeight(child: CartItem(item:cartList[index]));
            })
        : ListView.builder(
            itemCount: cartList.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: spacing_standard_new),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CartItem(item:cartList[index]);
            });


    var bottomButtons = Container(
      height: 65,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: sh_shadow_color, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 3)),
      ], color: sh_white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: context.cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("\$70", style: boldTextStyle()),
                Text(sh_lbl_see_price_detail, style: secondaryTextStyle()),
              ],
            ),
          ).expand(),
          Container(
            color: sh_colorPrimary,
            alignment: Alignment.center,
            height: double.infinity,
            child: text(sh_lbl_continue, textColor: sh_white, fontSize: textSizeLargeMedium, fontFamily: fontMedium),
          ).onTap(()=> Get.toNamed(ScreenOrderSummary.tag),
          ).expand()
        ],
      ),
    );
    return Scaffold(
      appBar: const DefaultAppBar(title:"Cart"),
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  cartListWidget,
                  paymentDetail,
                  50.height,
                  bottomButtons,
                  80.height,
                ],
              ),
            ),
            const Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                    child: Footer()
                )
            ),
          ],
        ),
      ),
    );
  }
}
