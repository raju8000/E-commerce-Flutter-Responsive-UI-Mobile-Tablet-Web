import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/footer.dart';
import 'package:ecommerce_responsive/utils/widgets/image_holder.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_order.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/root_bundle.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'package:ecommerce_responsive/utils/extension/currency_extension.dart';

class ScreenOrderList extends StatefulWidget {
  static const String tag = '/orderList';

  const ScreenOrderList({super.key});

  @override
  ScreenOrderListState createState() => ScreenOrderListState();
}

class ScreenOrderListState extends State<ScreenOrderList> {
  List<ModelOrder> orderList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var orders = await loadOrders();
    setState(() {
      orderList.clear();
      orderList.addAll(orders);
    });
  }

  @override
  Widget build(BuildContext context) {

    var listView = Expanded(
      child: ListView.builder(
        itemCount: orderList.length+1,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return index == orderList.length?
              const Footer():
            Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                  children: <Widget>[
                    ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 180),
                        child: ImageHolder(imagePath: "${base}img/products${orderList[index].item!.image!}")),
                    const SizedBox(width: 10),

                    SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Text(orderList[index].item!.name!, style: boldTextStyle()),
                          4.height,
                          text(
                            orderList[index].item!.price.toString().toCurrencyFormat(),
                            textColor: sh_colorPrimary,
                            fontFamily: fontMedium,
                            fontSize: textSizeNormal,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 15,),
                    Column(
                      children: [
                        Text("M", style: boldTextStyle()),
                        text("Total item- 1").paddingOnly(left: 16.0, top: 4.0, bottom: 4.0),
                      ],
                    ),

                    const SizedBox(width: 20,),

                    Column(
                      children: <Widget>[
                        8.height,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DotStepper(
                              activeStep: 1,
                              direction: Axis.vertical,
                              spacing: 21,
                              dotRadius: 7,
                              shape: Shape.stadium,
                              dotCount: 3,lineConnectorsEnabled: true,
                              lineConnectorDecoration: const LineConnectorDecoration(
                                color: Colors.green,
                                strokeWidth: 0,
                              ),

                              indicatorDecoration: const IndicatorDecoration(
                                color: Colors.green,
                              ),
                            ),


                            const SizedBox(width: 5,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( "${orderList[index].order_date!} Order Placed", maxLines: 2, style: primaryTextStyle(size: 14),overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 18,),
                                Text( "Processing", maxLines: 2, style: primaryTextStyle(size: 14),),
                                const SizedBox(height: 18,),
                                Text( "Order Delivered", maxLines: 2, style: primaryTextStyle(size: 14),),
                              ],
                            )
                          ],
                        )
                      ],
                    ),

                  ],
                ),
              )
            ),
          );
        },
      ),
    );
    return Scaffold(
      appBar: const DefaultAppBar(title: sh_lbl_my_orders,),
      body: SafeArea(child: SizedBox(
        height: MediaQuery.of(context).size.height,
          child: listView)),
    );
  }
}
