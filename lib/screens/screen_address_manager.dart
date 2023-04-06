import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart'hide ContextExtensionss ;
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_address.dart';
import 'package:ecommerce_responsive/screens/screen_add_new_address.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/root_bundle.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/main.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';

class ScreenAddressManager extends StatefulWidget {
  static const String tag = '/addressManager';

  const ScreenAddressManager({super.key});

  @override
  ScreenAddressManagerState createState() => ScreenAddressManagerState();
}

class ScreenAddressManagerState extends State<ScreenAddressManager> {
  List<ModelAddress> addressList = [];
  int? selectedAddressIndex = 0;
  Color? primaryColor;
  var mIsLoading = true;
  var isLoaded = false;
  List<TrackSize> rowSizes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    setState(() {
      mIsLoading = true;
    });
    var addresses = await loadAddresses();
    setState(() {
      addressList.clear();
      addressList.addAll(addresses);
      isLoaded = true;
      mIsLoading = false;
      rowSizes = List.filled(addressList.length, auto);
    });
  }

  deleteAddress(ModelAddress model) async {
    setState(() {
      addressList.remove(model);
    });
  }

  editAddress(ModelAddress model) async {
    var bool = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ScreenAddNewAddress(
                      addressModel: model,
                    ))) ??
        false;
    if (bool) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget addressListWidget =  addressList.isNotEmpty?
    SingleChildScrollView(
      child: LayoutGrid(
        columnSizes: context.isPhone() ? [1.fr]: [1.fr,1.fr] ,
        rowSizes: rowSizes,
        rowGap: 15,
        columnGap: 15,
        children: [
          for (var index = 0; index < addressList.length; index++)
            Slidable(
              actionPane: const SlidableDrawerActionPane(),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.green,
                  icon: Icons.edit,
                  onTap: () => editAddress(addressList[index]),
                )
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.redAccent,
                  icon: Icons.delete_outline,
                  onTap: () => deleteAddress(addressList[index]),
                ),
              ],
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedAddressIndex = index;
                  });
                },
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(spacing_standard_new),
                    margin: const EdgeInsets.only(right: spacing_standard_new, left: spacing_standard_new,),
                    //color: context.cardColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                            value: index,
                            groupValue: selectedAddressIndex,
                            onChanged: (dynamic value) {
                              setState(() {
                                selectedAddressIndex = value;
                              });
                            },
                            activeColor: primaryColor),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${addressList[index].first_name!} ${addressList[index].last_name!}", style: boldTextStyle()),
                              Text(addressList[index].address.toString(), style: primaryTextStyle()),
                              Text("${addressList[index].city!},${addressList[index].state!}", style: secondaryTextStyle()),
                              Text("${addressList[index].country!},${addressList[index].pinCode!}", style: secondaryTextStyle()),
                              16.height,
                              Text(addressList[index].phone_number.toString(), style: primaryTextStyle()),
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            Card(
                              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
                              elevation: 5,
                              child: const Icon(Icons.edit, color: black, size: 12).paddingAll(5),
                            ).onTap(()=> editAddress(addressList[index])),
                            10.height,
                            Card(
                              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
                              elevation: 5,
                              child: const Icon(Icons.delete, color: black, size: 12).paddingAll(5),
                            ).onTap(()=> deleteAddress(addressList[index])),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ).paddingOnly(top: 20,left: context.width()*0.05, right: context.width()*0.05),
    ):const SizedBox.shrink();


    return Scaffold(
      appBar: AppBar(
        elevation:  0,
        centerTitle: false,
        automaticallyImplyLeading: !kIsWeb,
        actions: <Widget>[
          IconButton(
              color: appStore.isDarkModeOn ? white : blackColor,
              icon: const Icon(Icons.add),
              onPressed: () async {
                var bool = await Get.toNamed(ScreenAddNewAddress.tag) ?? false;
                if (bool) {
                  fetchData();
                }
              })
        ],
        actionsIconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
        iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
        title: Text(sh_lbl_address_manager, style: boldTextStyle(size: 18)),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            addressListWidget,
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                color: sh_colorPrimary,
                elevation: 0,
                padding: const EdgeInsets.all(spacing_standard_new),
                child: text("Save", textColor: sh_white, fontFamily: fontMedium, fontSize: textSizeLargeMedium),
                onPressed: () {
                  Get.back(result: selectedAddressIndex);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
