import 'package:ecommerce_responsive/utils/extension/url_extension.dart';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/extension/currency_extension.dart';
import 'package:ecommerce_responsive/utils/widgets/filter_bottom_sheet.dart';
import 'package:ecommerce_responsive/utils/widgets/flutter_rating_bar.dart';
import 'package:ecommerce_responsive/utils/widgets/image_holder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_attribute.dart';
import 'package:ecommerce_responsive/models/model_product.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/root_bundle.dart';
import 'package:ecommerce_responsive/utils/common_widget.dart';
import 'package:ecommerce_responsive/main.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'screen_product_detail.dart';

class ScreenViewAllProduct extends StatefulWidget {
  static const String tag = '/viewAllProduct';

  final List<ModelProduct>? products;
  final String title;

  const ScreenViewAllProduct({super.key, this.products,required this.title});

  @override
  ScreenViewAllProductState createState() {
    return ScreenViewAllProductState();
  }
}

class ScreenViewAllProductState extends State<ScreenViewAllProduct> {
  var sortType = -1;
  List<ModelProduct> mProductList = [];
  ModelAttributes? mProductAttributeModel;

  var isListViewSelected = true;
  var errorMsg = '';
  var scrollController = ScrollController();
  bool isLoading = false;
  bool isLoadingMoreData = false;
  int page = 1;
  bool isLastPage = false;

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var model = await loadAttributes();
    setState(() {
      mProductAttributeModel = model;
      mProductList.addAll(widget.products!);
    });
  }

  void onListClick(which) {
    setState(() {
      if (which == 1) {
        isListViewSelected = true;
      } else if (which == 2) {
        isListViewSelected = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final listView = Expanded(
      child: ListView.builder(
        itemCount: mProductList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Card(
              elevation: 4,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 180),
                padding: const EdgeInsets.all(10.0),
                child:
                Row(
                  children: <Widget>[
                    ImageHolder(imagePath: "${base}img/products${mProductList[index].images![0].src!}"),

                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(mProductList[index].name!, style: boldTextStyle()),
                          const SizedBox(height: 4),
                          Row(
                            children: <Widget>[
                              text(mProductList[index].on_sale! ? mProductList[index].sale_price.toString().toCurrencyFormat() : mProductList[index].price.toString().toCurrencyFormat(),
                                  textColor: sh_colorPrimary, fontFamily: fontMedium, fontSize: textSizeNormal),
                              const SizedBox(width: spacing_control,),
                              Text(
                                mProductList[index].regular_price.toString().toCurrencyFormat()!,
                                style: const TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall, decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                          Flexible(
                            child: Text(mProductList[index].description!,overflow: TextOverflow.ellipsis,maxLines: 2,),
                          ),
                          const SizedBox(height: spacing_standard,),
                          Row(children: colorWidget(mProductList[index].attributes!)),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RatingBar(
                                initialRating: double.parse(mProductList[index].average_rating!),
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                tapOnlyMode: true,
                                itemCount: 5,
                                itemSize: 16,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              Container(
                                padding: const EdgeInsets.all(spacing_control),
                                margin: const EdgeInsets.only(right: spacing_standard),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: context.cardColor),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: appStore.isDarkModeOn ? white : sh_textColorPrimary,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                          4.height,
                        ],
                      ),
                    )
                  ],
                ),
              ).onTap(() {
                Get.toNamed(ScreenProductDetail.tag,parameters: mProductList[index].toJson().encode);
                },
              ),
            ),
          );
        },
      ),
    );

    final gridView = Wrap(
      children: [
        for(int index=0;index<mProductList.length;index++)
          Card(
            elevation: 2,
            child: Container(
              width: 200,
              constraints: const BoxConstraints(maxWidth: 150),
              child: InkWell(
                onTap: () {
                  Get.toNamed(ScreenProductDetail.tag,parameters: mProductList[index].toJson().encode );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/shopx/img/products${mProductList[index].images![0].src!}", height: 200, fit: BoxFit.cover),
                    const SizedBox(height: spacing_standard),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(mProductList[index].name!, maxLines: 2, style: boldTextStyle()).expand(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              mProductList[index].regular_price.toString().toCurrencyFormat()!,
                              style: secondaryTextStyle(decoration: TextDecoration. lineThrough),
                            ),
                            const SizedBox(width: spacing_control_half),
                            text(
                              mProductList[index].on_sale! ? mProductList[index].sale_price.toString().toCurrencyFormat() : mProductList[index].price.toString().toCurrencyFormat(),
                              textColor: sh_colorPrimary,
                              fontFamily: fontMedium,
                              fontSize: textSizeMedium,
                            ),
                            const SizedBox(width: spacing_control_half),
                          ],
                        ).expand()
                      ],
                    ).paddingOnly(left: spacing_standard_new)
                  ],
                ),
              ),
            ),
          ),
      ]
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
        actionsIconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => showMyBottomSheet(context),
          ),
          IconButton(
            icon: Icon(isListViewSelected ? Icons.view_list : Icons.border_all, size: 24),
            onPressed: () {
              setState(
                () {
                  isListViewSelected = !isListViewSelected;
                },
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          errorMsg.isEmpty
              ? Expanded(
                child: Center(
                    child: mProductList.isNotEmpty
                        ? Column(
                        children: [
                          isListViewSelected ? listView : gridView,
                          const CircularProgressIndicator().visible(isLoadingMoreData)
                        ])
                        : const CircularProgressIndicator().paddingAll(8),
                  ),
              )
              : Center(child: Text(errorMsg)),
        ],
      ),
    );
  }

  void showMyBottomSheet(context) {
    if (mProductList.isEmpty) return;
    void onSave(List<int> category, List<String> size, List<String> color, List<String> brand) {
      Map request = {
        'category': category.toSet().toList(),
        'size': size.toSet().toList(),
        'color': color.toSet().toList(),
        'brand': brand.toSet().toList(),
      };
      if (category.isEmpty) request.remove('category');
      if (size.isEmpty) request.remove('size');
      if (color.isEmpty) request.remove('color');
      if (brand.isEmpty) request.remove('brand');
    }

    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return FilterBottomSheetLayout(mProductAttributeModel: mProductAttributeModel, onSave: onSave);
        },
        fullscreenDialog: true));
  }

  List<Widget> sizeWidget(List<String> size) {
    var maxWidget = 5;
    var currentIndex = 0;
    List<Widget> list = [];
    var totalSize = size.length;
    var flag = false;

    size.forEach((size) {
      if (currentIndex < maxWidget) {
        list.add(Container(
          margin: const EdgeInsets.only(right: spacing_middle),
          child: Center(child: text(size.trim(), fontSize: textSizeMedium, textColor: sh_textColorPrimary, fontFamily: fontMedium)),
        ));
        currentIndex++;
      } else {
        if (!flag) list.add(Text('+ ${totalSize - maxWidget} more'));
        flag = true;
        return;
      }
    });
    return list;
  }
}


