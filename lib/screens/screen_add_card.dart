import 'package:ecommerce_responsive/utils/card_formater.dart';
import 'package:ecommerce_responsive/utils/extension/url_extension.dart';
import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/models/model_payment.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';
import 'package:ecommerce_responsive/utils/common_widget.dart';

class ScreenAddCard extends StatefulWidget {
  static const String tag = '/addCard';

  const ScreenAddCard({super.key});

  @override
  ScreenAddCardState createState() => ScreenAddCardState();
}

class ScreenAddCardState extends State<ScreenAddCard> {
  ModelPaymentCard? paymentCard = Get.parameters.isNotEmpty? ModelPaymentCard.fromJson(Get.parameters.decode):null;
  var cvvCont = TextEditingController();
  var nameCont = TextEditingController();
  var cardNumberCont = TextEditingController();
  var months = ["", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
  var years = ["", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031"];
  String? selectedMonth = "";
  String? selectedYear = "";

  @override
  void initState() {
    super.initState();
    if (paymentCard != null) {
      setState(() {
        cvvCont.text = paymentCard!.cvv!;
        nameCont.text = paymentCard!.holderName!;
        cardNumberCont.text = paymentCard!.cardNo!;
        selectedMonth = paymentCard!.month;
        selectedYear = paymentCard!.year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: sh_lbl_add_card,showActionIcon: false,),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(spacing_standard_new),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                headingText(sh_hint_card_number),
                16.height,
                TextFormField(
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  controller: cardNumberCont,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CardNumberInputFormatter()
                  ],
                  textCapitalization: TextCapitalization.words,
                  style: primaryTextStyle(),
                  decoration: const InputDecoration(
                      filled: false,
                      counterText: "",
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(spacing_control)), borderSide: BorderSide(color: Colors.grey, width: 1)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(spacing_control)), borderSide: BorderSide(color: Colors.grey, width: 0))),
                ),
                16.height,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          headingText("Month"),
                          16.height,
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(20.0, 4.0, 8.0, 4.0),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1), borderRadius: const BorderRadius.all(Radius.circular(spacing_control))),
                            child: DropdownButton<String>(
                              underline: const SizedBox(),
                              value: selectedMonth,
                              isExpanded: true,
                              items: months.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: primaryTextStyle()),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedMonth = newValue;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: spacing_standard_new,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          headingText("Year"),
                          const SizedBox(height: spacing_standard_new,),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(20.0, 4.0, 8.0, 4.0),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1), borderRadius: const BorderRadius.all(Radius.circular(spacing_control))),
                            child: DropdownButton<String>(
                              underline: const SizedBox(),
                              value: selectedYear,
                              isExpanded: true,
                              items: years.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: primaryTextStyle()),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedYear = newValue;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                16.height,
                headingText(sh_lbl_cvv),
                16.height,
                TextFormField(
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  controller: cvvCont,
                  maxLength: 3,
                  obscureText: true,
                  textCapitalization: TextCapitalization.words,
                  style: primaryTextStyle(),
                  decoration: const InputDecoration(
                      filled: false,
                      counterText: "",
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(spacing_control)), borderSide: BorderSide(color: Colors.grey, width: 1)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(spacing_control)), borderSide: BorderSide(color: Colors.grey, width: 0))),
                ),
                16.height,
                headingText(sh_hint_card_holder_name),
                16.height,
                TextFormField(
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  controller: nameCont,
                  textCapitalization: TextCapitalization.words,
                  style: primaryTextStyle(),
                  decoration: const InputDecoration(
                      filled: false,
                      counterText: "",
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(spacing_control)), borderSide: BorderSide(color: Colors.grey, width: 1)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(spacing_control)), borderSide: BorderSide(color: Colors.grey, width: 0))),
                ),

                const SizedBox(height: 50,),

                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: RoundedButton(
                    title: sh_lbl_add_card,
                    color: sh_colorPrimary,
                    titleColor: sh_white,
                    onPress:() => {},
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
