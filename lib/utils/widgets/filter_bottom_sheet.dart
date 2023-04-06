// ignore: must_be_immutable
import 'package:ecommerce_responsive/main.dart';
import 'package:ecommerce_responsive/models/model_attribute.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FilterBottomSheetLayout extends StatefulWidget {
  ModelAttributes? mProductAttributeModel;
  var onSave;

  FilterBottomSheetLayout({Key? key, this.mProductAttributeModel, this.onSave}) : super(key: key);

  @override
  FilterBottomSheetLayoutState createState() {
    return FilterBottomSheetLayoutState();
  }
}

class FilterBottomSheetLayoutState extends State<FilterBottomSheetLayout> {
  List<int> selectedCategories = [];
  List<String> selectedColors = [];
  List<String> selectedSizes = [];
  List<String> selectedBrands = [];

  @override
  Widget build(BuildContext context) {
    var categoryList = widget.mProductAttributeModel!.categories;
    var colorsList = widget.mProductAttributeModel!.color;
    var sizesList = widget.mProductAttributeModel!.size;
    var brandsList = widget.mProductAttributeModel!.brand;
    final productCategoryListView = ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categoryList?.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChoiceChip(
              label: text(categoryList![index].name, textColor: categoryList[index].isSelected! ? Colors.red : blackColor),
              selected: categoryList[index].isSelected!,
              onSelected: (selected) {
                setState(() {
                  categoryList[index].isSelected! ? categoryList[index].isSelected = false : categoryList[index].isSelected = true;
                });
              },
              elevation: 2,
              backgroundColor: Colors.white10,
              selectedColor: sh_colorPrimary.withOpacity(0.5),
            ),
          );
        });

    final productColorsListView = ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: colorsList?.length,
        padding: const EdgeInsets.only(left: spacing_standard_new),
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  colorsList[index].isSelected ? colorsList[index].isSelected = false : colorsList[index].isSelected = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                margin: const EdgeInsets.only(right: spacing_standard_new),
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: sh_textColorPrimary, width: 0.5), color: getColorFromHex(colorsList![index].name!)),
                child: colorsList[index].isSelected
                    ? const Icon(
                  Icons.done,
                  color: sh_white,
                  size: 12,
                )
                    : Container(),
              ),
            ),
          );
        });

    final productSizeListView = ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: sizesList?.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChoiceChip(
              label: text(sizesList![index].name, textColor: categoryList![index].isSelected! ? Colors.red : blackColor),
              selected: sizesList[index].isSelected,
              onSelected: (selected) {
                setState(() {
                  sizesList[index].isSelected ? sizesList[index].isSelected = false : sizesList[index].isSelected = true;
                });
              },
              elevation: 2,
              backgroundColor: Colors.white10,
              selectedColor: sh_colorPrimary.withOpacity(0.5),
            ),
          );
        });

    final productBrandsListView = ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: brandsList?.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChoiceChip(
              label: text(brandsList![index].name, textColor: brandsList[index].isSelected ? Colors.red : blackColor),
              selected: brandsList[index].isSelected,
              onSelected: (selected) {
                setState(() {
                  brandsList[index].isSelected ? brandsList[index].isSelected = false : brandsList[index].isSelected = true;
                });
              },
              elevation: 2,
              backgroundColor: Colors.white10,
              selectedColor: sh_colorPrimary.withOpacity(0.5),
            ),
          );
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: sh_colorPrimary,
        title: text(sh_lbl_filter, textColor: sh_white, fontSize: textSizeNormal, fontFamily: fontMedium),
        iconTheme: const IconThemeData(color: sh_white),
        actions: <Widget>[
          InkWell(
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: spacing_middle),
                  child: text(sh_lbl_apply, textColor: sh_white, fontFamily: fontMedium, fontSize: textSizeLargeMedium)),
              onTap: () {
                finish(context);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: spacing_standard_new, top: spacing_standard_new),
              child: text(sh_lbl_categories, textColor: appStore.isDarkModeOn ? white : sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeLargeMedium),
            ),
            8.height,
            SizedBox(height: 50, child: productCategoryListView),
            Padding(
              padding: const EdgeInsets.only(left: spacing_standard_new, top: spacing_standard_new),
              child: text(sh_lbl_colors, textColor: appStore.isDarkModeOn ? white : sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeLargeMedium),
            ),
            8.height,
            SizedBox(height: 50, child: productColorsListView),
            Padding(
              padding: const EdgeInsets.only(left: spacing_standard_new, top: spacing_standard_new),
              child: text(sh_lbl_size, textColor: appStore.isDarkModeOn ? white : sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeLargeMedium),
            ),
            8.height,
            SizedBox(height: 50, child: productSizeListView),
            Padding(
              padding: const EdgeInsets.only(left: spacing_standard_new, top: spacing_standard_new),
              child: text(sh_lbl_brands, textColor: appStore.isDarkModeOn ? white : sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeLargeMedium),
            ),
            8.height,
            SizedBox(height: 50, child: productBrandsListView)
          ],
        ),
      ),
    );
  }
}