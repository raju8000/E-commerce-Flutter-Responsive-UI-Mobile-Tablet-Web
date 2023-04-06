import 'package:ecommerce_responsive/main.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/extension/currency_extension.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/widgets/image_holder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/model_product.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.item}) : super(key: key);
  final ModelProduct item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: context.isDesktop() || kIsWeb?145: context.height() * 0.25,
        margin: const EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageHolder(imagePath: "${base}img/products${item.images![0].src!}",),

            15.width,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.height,
                  Text(item.name.toString(), style: boldTextStyle(size: 14)),
                  4.height,
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                        padding: const EdgeInsets.all(spacing_control_half),
                        child: const Icon(Icons.done, color: sh_white, size: 12),
                      ),
                      8.width,
                      Text("M", style: boldTextStyle(size: 14)),
                      8.width,
                      Text("Qty: 1", style: secondaryTextStyle()).paddingOnly(left: 8),
                      const Spacer(),
                      Card(
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
                        elevation: 5,
                        child: const Icon(Icons.close, color: black, size: 12).paddingAll(5),
                      ),
                    ],
                  ).paddingOnly(top: spacing_control),
                  6.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.on_sale! ? item.sale_price.toString().toCurrencyFormat().toString() : item.price.toString().toCurrencyFormat().toString(),
                        style: primaryTextStyle(size: 14),
                      ),
                      4.width,
                      Text(item.regular_price.toString().toCurrencyFormat()!,
                        style: const TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSMedium, decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),

                  const Spacer(),
                  const Divider(height: 1,),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmark_border, color: appStore.isDarkModeOn ? gray : sh_textColorPrimary, size: 16,),
                          4.width,
                          (context.width()> 716 && context.width()<780)?
                          const SizedBox.shrink():
                          Text("Buy Later", style: secondaryTextStyle(), overflow: TextOverflow.ellipsis, maxLines: 1,).expand()
                        ],
                      ).expand(),
                      Container(width: 1, color: sh_view_color, height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outline, color: appStore.isDarkModeOn ? gray : sh_textColorPrimary, size: 16,),
                          4.width,
                          (context.width()> 716 && context.width()<780)?
                          const SizedBox.shrink():
                          Text(sh_lbl_remove, style: secondaryTextStyle()),
                        ],
                      ).expand()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
