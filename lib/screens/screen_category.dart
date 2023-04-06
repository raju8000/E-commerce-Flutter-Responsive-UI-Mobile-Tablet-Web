import 'dart:async';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_responsive/models/model_category.dart';
import 'package:ecommerce_responsive/models/model_product.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/root_bundle.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/common_widget.dart';
import '../utils/widgets/appbar.dart';
import 'screen_view_all_products.dart';

class ScreenCategory extends StatefulWidget {
  static const String tag = '/subCategory';
  final ModelCategory? category;

  const ScreenCategory({super.key, this.category});

  @override
  ScreenCategoryState createState() => ScreenCategoryState();
}

class ScreenCategoryState extends State<ScreenCategory> {
  List<String> images = [];
  var currentIndex = 0;
  List<ModelProduct> newestProducts = [];
  List<ModelProduct> featuredProducts = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  void startTimer() {
    if (timer != null) {
      return;
    }
    timer = Timer.periodic(const Duration(seconds: 5), (time) {
      setState(() {
        if (currentIndex == images.length - 1) {
          currentIndex = 0;
        } else {
          currentIndex = currentIndex + 1;
        }
      });
    });
  }

  fetchData() async {
    List<ModelProduct> products = await loadProducts();
    List<ModelProduct> categoryProducts = [];
    for (var product in products) {
      for (var category in product.categories!) {
        if (category.name == widget.category!.name) {
          categoryProducts.add(product);
        }
      }
    }
    List<ModelProduct> featured = [];
    List<String> banner = [];

    for (var product in categoryProducts) {
      if (product.featured!) {
        featured.add(product);
      }
      if (product.images!.isNotEmpty) {
        banner.add("${base}img/products${product.images![0].src!}");
      }
    }

    setState(() {
      newestProducts.clear();
      featuredProducts.clear();
      images.clear();
      if (banner.isNotEmpty) {
        images.addAll(banner);
        currentIndex = 0;
        startTimer();
      }
      newestProducts.addAll(categoryProducts);
      featuredProducts.addAll(featured);
    });
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: DefaultAppBar(title: widget.category!.name!),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            images.isNotEmpty
                ? Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 0.5)),
                    margin: const EdgeInsets.all(spacing_standard_new),
                    child: Image.asset(images[currentIndex], width: double.infinity, height: height * 0.3, fit: BoxFit.cover),
                  )
                : Container(),
            horizontalHeading(sh_lbl_newest_product, callback: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenViewAllProduct(products: newestProducts, title: sh_lbl_newest_product)));
            }),
            ProductHorizontalList(newestProducts),
            const SizedBox(height: spacing_standard_new),
            horizontalHeading(sh_lbl_Featured, callback: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenViewAllProduct(products: featuredProducts, title: sh_lbl_Featured)));
            }),
            ProductHorizontalList(featuredProducts),
            const SizedBox(height: spacing_large),
          ],
        ),
      ),
    );
  }
}
