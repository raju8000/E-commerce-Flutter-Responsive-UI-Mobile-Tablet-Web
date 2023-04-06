import 'package:ecommerce_responsive/utils/extension/url_extension.dart';
import 'package:ecommerce_responsive/utils/widgets/app_widget.dart';
import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_payment.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'screen_add_card.dart';

class ScreenQuickPayCards extends StatefulWidget {
  static const String tag = '/quickPayCards';

  const ScreenQuickPayCards({super.key});

  @override
  ScreenQuickPayCardsState createState() => ScreenQuickPayCardsState();
}

class ScreenQuickPayCardsState extends State<ScreenQuickPayCards> {
  List<ModelPaymentCard> cardList = [];
  int? selectedCard = 0;
  List<TrackSize> rowSizes = [];

  editCard(ModelPaymentCard card) {
    Get.toNamed(ScreenAddCard.tag,parameters: card.toJson().encode);
  }

  deleteCard(ModelPaymentCard card) {
    setState(() {
      cardList.remove(card);
    });
  }

  @override
  void initState() {
    super.initState();
    ///Set up dummy list
    cardList.add(ModelPaymentCard());
    cardList.add(ModelPaymentCard());
    cardList.add(ModelPaymentCard());
    cardList.add(ModelPaymentCard());
    cardList.add(ModelPaymentCard());
    cardList.add(ModelPaymentCard());
    rowSizes = List.filled(cardList.length, auto);
  }

  @override
  Widget build(BuildContext context) {
    final cardLayoutGrid =
    LayoutGrid(
      columnSizes: context.isPhone() ? [1.fr]: [1.fr,1.fr] ,
      rowSizes: rowSizes,
      rowGap: 15,
      columnGap: 15,
      children: [
        for (var index = 0; index < cardList.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: spacing_standard_new),
            child: Slidable(
              actionPane: const SlidableDrawerActionPane(),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.green,
                  icon: Icons.edit,
                  onTap: () => editCard(cardList[index]),
                )
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.redAccent,
                  icon: Icons.delete_outline,
                  onTap: () => deleteCard(cardList[index]),
                ),
              ],
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedCard = index;
                  });
                },
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    margin: const EdgeInsets.only(right: spacing_standard_new, left: spacing_standard_new,),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 210,
                          child: Stack(
                            children: <Widget>[
                              Image.asset(
                                card,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                                height: 210,
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          text("Debit card", textColor: sh_white, fontSize: textSizeLargeMedium, fontFamily: fontBold),
                                          text("MVK Bank", textColor: sh_white, fontSize: textSizeLargeMedium, fontFamily: fontBold)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: spacing_middle,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Image.asset(chip, width: 50, height: 30, fit: BoxFit.fill),
                                            16.height,
                                            text(
                                              "3434 3434 3434",
                                              textColor: sh_white,
                                              fontFamily: fontMedium,
                                              fontSize: textSizeLargeMedium,
                                            ),
                                            text("valid 12/12", textColor: sh_white, fontSize: textSizeSMedium),
                                            8.height,
                                            text("JOHN", textColor: sh_white, fontFamily: fontMedium, fontSize: textSizeMedium),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Radio(
                            value: index,
                            groupValue: selectedCard,
                            onChanged: (dynamic value) {
                              setState(() {
                                selectedCard = value;
                              });
                            },
                            activeColor: sh_white)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
      ],
    ).paddingOnly(top: 20,left: context.width()*0.05, right: context.width()*0.05);

    return Scaffold(
      appBar: const DefaultAppBar(title: sh_title_payment),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(spacing_standard_new),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(sh_lbl_quick_pay, style: boldTextStyle()),
                  RoundedButton(
                    title: sh_lbl_add_card,
                      onPress:() =>Get.toNamed(ScreenAddCard.tag))
                ],
              ),
            ),
            cardLayoutGrid,
          ],
        ),
      ),
    );
  }
}
