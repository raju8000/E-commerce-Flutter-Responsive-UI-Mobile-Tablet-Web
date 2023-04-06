import 'package:ecommerce_responsive/screens/screen_search_product.dart';
import 'package:ecommerce_responsive/screens/side_drawer.dart';
import 'package:ecommerce_responsive/utils/widgets/dots_indicator/src/dots_decorator.dart';
import 'package:ecommerce_responsive/utils/widgets/dots_indicator/src/dots_indicator.dart';
import 'package:ecommerce_responsive/utils/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_category.dart';
import 'package:ecommerce_responsive/models/model_product.dart';
import 'package:ecommerce_responsive/screens/screen_category.dart';
import 'package:ecommerce_responsive/screens/screen_view_all_products.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/root_bundle.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/common_widget.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';

import '../utils/widgets/appbar.dart';

class ScreenHome extends StatefulWidget {
  static const String tag = '/home';

  const ScreenHome({super.key});

  @override
  ScreenHomeState createState() => ScreenHomeState();
}

class ScreenHomeState extends State<ScreenHome> {
  List<ModelCategory> categoryList = [];
  List<String> banners = [];
  List<ModelProduct> newestProducts = [];
  List<ModelProduct> featuredProducts = [];
  var position = 0;
  var colors = [sh_cat_1, sh_cat_2, sh_cat_3, sh_cat_4, sh_cat_5];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    loadCategory().then((categories) {
      setState(() {
        categoryList.clear();
        categoryList.addAll(categories);
      });
    }).catchError((error) {
      toasty(context, error);
    });
    List<ModelProduct> products = await loadProducts();
    List<ModelProduct> featured = [];
    products.forEach((product) {
      if (product.featured!) {
        featured.add(product);
      }
    });
    List<String> banner = [];
    for (var i = 1; i < 7; i++) {
      banner.add("assets/images/shopx/img/products/banners/b$i.jpg");
    }
    setState(() {
      newestProducts.clear();
      featuredProducts.clear();
      banners.clear();
      banners.addAll(banner);
      newestProducts.addAll(products);
      featuredProducts.addAll(featured);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const DefaultAppBar(title: "ShopX",showLeading: true,),
      drawer: context.isPhone()? const SideDrawer():null,
      body: newestProducts.isNotEmpty
          ? SafeArea(
            child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: const Alignment(0.9,-0.9),
                      children: [
                        SizedBox(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 280, minWidth: 500),
                            child: StatefulBuilder(
                                builder: (context, setState) {
                                return Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    PageView.builder(
                                      itemCount: banners.length,
                                      itemBuilder: (context, index) {
                                        return Image.asset(banners[index], fit: BoxFit.contain);
                                      },
                                      onPageChanged: (index) {
                                        setState(() {
                                          position = index;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DotsIndicator(
                                        dotsCount: banners.length,
                                        position: position,
                                        decorator: const DotsDecorator(
                                          color: sh_view_color,
                                          activeColor: sh_colorPrimary,
                                          size: Size.square(7.0),
                                          activeSize: Size.square(10.0),
                                          spacing: EdgeInsets.all(3),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            ),
                          ),
                        ),

                        Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        )
                        ).onTap(()=> Get.toNamed(ScreenSearchProduct.tag))
                      ],
                    ),

                    ///Category list
                    if(!context.isPhone())
                    Center(
                      child: ListView.builder(
                        itemCount: categoryList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: spacing_standard, right: spacing_standard,top: spacing_standard_new),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(left: spacing_standard, right: spacing_standard),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(spacing_middle),
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: colors[index % colors.length]),
                                  child: Image.asset(categoryList[index].image!, width: 20, color: sh_white),
                                ),
                                const SizedBox(height: spacing_control),
                                text(categoryList[index].name, textColor: colors[index % colors.length], fontFamily: fontMedium,fontSize: 22)
                              ],
                            ),
                          ).onTap(() {
                            ScreenCategory(category: categoryList[index]).launch(context);
                          });
                        },
                      ),
                    ).withHeight(100),

                    ///Newest Product
                    horizontalHeading(sh_lbl_newest_product, callback: () {
                      ScreenViewAllProduct(products: newestProducts, title: sh_lbl_newest_product).launch(context);
                    }),
                    ProductHorizontalList(newestProducts),

                    const SizedBox(height: spacing_standard_new),
                    horizontalHeading(sh_lbl_Featured, callback: () {
                      ScreenViewAllProduct(products: featuredProducts, title: sh_lbl_Featured).launch(context);
                    }),
                    ProductHorizontalList(featuredProducts),
                    const SizedBox(height: 60),

                    const Footer()
                  ],
                ),
              ),
          )
          : Container(),
    );
  }
}
