import 'dart:convert';

import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/footer.dart';
import 'package:ecommerce_responsive/utils/widgets/image_holder.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_product.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/root_bundle.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/main.dart';
import 'package:ecommerce_responsive/utils/extension/currency_extension.dart';

class ScreenWishlist extends StatefulWidget {
  static const String tag = '/wishList';

  const ScreenWishlist({super.key});

  @override
  ScreenWishlistState createState() => ScreenWishlistState();
}

class ScreenWishlistState extends State<ScreenWishlist> {
  List<ModelProduct> list = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var products = await loadProducts();
    setState(() {
      list.clear();
      list.addAll(products);
    });
  }

  Future<List<ModelProduct>> loadProducts() async {
    String jsonString = await loadContentAsset('assets/shophop_data/wishlist_products.json');
    final jsonResponse = json.decode(jsonString);
    return (jsonResponse as List).map((i) => ModelProduct.fromJson(i)).toList();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const DefaultAppBar(title: "Wishlist"),
      body: Column(
        children: [
          Expanded(child: context.isDesktop()?
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:context.width()>1035? 4.5:3),
              itemCount: list.length,
              itemBuilder:(context, index) {
                return wishListItem(list[index]);
              })
              :ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 70),
            itemBuilder: (context, index) {
              return wishListItem(list[index]);
            },
          ),),

          15.height,
          const Footer(),
        ],
      ),
    );
  }

  Widget wishListItem(ModelProduct item){
    return Card(
      child: Container(
        color: appStore.isDarkModeOn ? scaffoldDarkColor : white,
        constraints: const BoxConstraints(maxHeight: 400),
        height: context.height() * 0.25,
        margin: const EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new,),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ImageHolder(imagePath: "${base}img/products${item.images![0].src!}",),

            10.width,

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //8.height,
                Text(item.name!, style: boldTextStyle()).paddingOnly(left: 16.0),
                Text(item.regular_price.toString().toCurrencyFormat().toString(), style: boldTextStyle(color: sh_colorPrimary)).paddingOnly(left: 16),
                const Spacer(),
                Wrap(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                         Icon(Icons.add_shopping_cart, color: sh_textColorPrimary, size: context.width()*0.03),
                        (context.width() > 715 && context.width()<775)?
                        const SizedBox.shrink():
                        Text(sh_lbl_move_to_cart, style: primaryTextStyle(size: context.isPhone()? (context.width()*0.03).toInt() :null )),
                      ],
                    ),
                    15.width,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         Icon(Icons.delete_outline, color: sh_textColorPrimary, size: context.width()*0.03),
                        (context.width() > 710 && context.width()<910)?
                            const SizedBox.shrink():
                        Text(sh_lbl_remove, style: primaryTextStyle(size: context.isPhone()? (context.width()*0.03).toInt() :null )),
                      ],
                    )
                  ],
                ).expand()
              ],
            ).expand()
          ],
        ),
      ),
    );
  }
}
