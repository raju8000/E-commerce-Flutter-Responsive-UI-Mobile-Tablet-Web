import 'package:ecommerce_responsive/utils/extension/url_extension.dart';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/extension/currency_extension.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/image_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_product.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/root_bundle.dart';
import 'package:ecommerce_responsive/utils/common_widget.dart';
import 'package:ecommerce_responsive/main.dart';
import 'package:ecommerce_responsive/utils/widgets/flutter_rating_bar.dart';

import 'screen_product_detail.dart';

class ScreenSearchProduct extends StatefulWidget {
  static const String tag = '/search';

  const ScreenSearchProduct({super.key});

  @override
  ScreenSearchProductState createState() => ScreenSearchProductState();
}

class ScreenSearchProductState extends State<ScreenSearchProduct> {
  TextEditingController searchController = TextEditingController();
  List<ModelProduct> resultList = [];
  bool isLoadingMoreData = false;
  bool isEmpty = false;
  var searchText = "";
  List<ModelProduct> products = [];
  List<TrackSize> rowSizes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    products = await loadProducts();
  }

  searchData() async {
    List<ModelProduct> filteredList = [];
    for (var product in products) {
      if (product.name!.toLowerCase().contains(searchText)) {
        filteredList.add(product);
      }
    }
    setState(() {
      resultList.clear();
      resultList.addAll(filteredList);
      isEmpty = resultList.isEmpty;
      rowSizes = List.filled(resultList.length, auto);
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget searchList = resultList.isNotEmpty?
    LayoutGrid(
        columnSizes: context.isPhone() ? [1.fr] : [1.fr, 1.fr],
        rowSizes: rowSizes,
        rowGap: 15,
        columnGap: 15,
        children: [
            for (var index = 0; index < resultList.length; index++)
            InkWell(
              onTap: () {
                Get.toNamed(ScreenProductDetail.tag, parameters: resultList[index]
                    .toJson()
                    .encode);
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                constraints: const BoxConstraints(maxHeight: 200),
                child: Row(
                  children: <Widget>[
                    ImageHolder(
                        imagePath: "${base}img/products${resultList[index].images![0]
                            .src!}"),

                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          text(resultList[index].name, textColor: sh_textColorPrimary),
                          const SizedBox(height: 4),
                          Row(
                            children: <Widget>[
                              text(resultList[index].on_sale! ? resultList[index]
                                  .sale_price.toString()
                                  .toCurrencyFormat() : resultList[index].price
                                  .toString().toCurrencyFormat(),
                                  textColor: sh_colorPrimary,
                                  fontFamily: fontMedium,
                                  fontSize: textSizeNormal),

                              const SizedBox(width: spacing_control,),

                              Text(
                                resultList[index].regular_price.toString()
                                    .toCurrencyFormat()!,
                                style: const TextStyle(color: sh_textColorSecondary,
                                    fontFamily: fontRegular,
                                    fontSize: textSizeSmall,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),

                          const SizedBox(height: spacing_standard,),

                          Row(children: colorWidget(resultList[index].attributes!)),

                          const SizedBox(height: 4),

                          Flexible(child: Text(
                            resultList[index].description!, maxLines: 3,
                            overflow: TextOverflow.ellipsis,)),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RatingBar(
                                initialRating: double.parse(
                                    resultList[index].average_rating!),
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                tapOnlyMode: true,
                                itemCount: 5,
                                itemSize: 16,
                                itemBuilder: (context, _) =>
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              Container(
                                padding: const EdgeInsets.all(spacing_control),
                                margin: const EdgeInsets.only(right: spacing_standard),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: sh_white),
                                child: const Icon(
                                  Icons.favorite_border,
                                  color: sh_textColorPrimary,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ]
    ):
    const SizedBox.shrink();

    return Scaffold(
      appBar:const DefaultAppBar(title: "Search",),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppBar(
              iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
              actionsIconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
              title: TextFormField(
                onChanged: (value){
                  searchText = value;
                  isEmpty = false;
                  isLoadingMoreData = true;
                  searchData();
                },
                controller: searchController,
                textInputAction: TextInputAction.search,
                style: primaryTextStyle(),
                decoration: InputDecoration(border: InputBorder.none, hintText: "Search", hintStyle: primaryTextStyle()),
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
              ),
              actions: <Widget>[
                searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: appStore.isDarkModeOn ? white : sh_textColorPrimary,
                  ),
                  onPressed: () {
                    setState(() {
                        searchController.clear();
                        resultList.clear();
                        isEmpty = false;
                        isLoadingMoreData = false;
                      },
                    );
                  },
                )
                    : Container()
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: !isEmpty
                    ? isLoadingMoreData
                        ? Column(
                            children: [searchList, loadingWidgetMaker()],
                          )
                        : searchList
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            80.height,
                            Text("No results found for \"${searchController.text}\"", style: boldTextStyle(size: 22)),
                            8.height,
                            Text("Try a different keyword", style: secondaryTextStyle())
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
