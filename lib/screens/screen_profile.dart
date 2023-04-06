import 'package:ecommerce_responsive/utils/widgets/appbar.dart';
import 'package:ecommerce_responsive/utils/widgets/footer.dart';
import 'package:ecommerce_responsive/utils/widgets/material_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ecommerce_responsive/utils/colors_constant.dart';
import 'package:ecommerce_responsive/utils/size_constant.dart';
import 'package:ecommerce_responsive/utils/images_constant.dart';
import 'package:ecommerce_responsive/utils/strings_constant.dart';

class ScreenProfile extends StatefulWidget {
  static const String tag = '/profile';

  const ScreenProfile({super.key});

  @override
  ScreenProfileState createState() => ScreenProfileState();
}

class ScreenProfileState extends State<ScreenProfile> {
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var confirmPasswordCont = TextEditingController();
  var firstNameCont = TextEditingController();
  var lastNameCont = TextEditingController();
  String? selectedValue = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Profile",),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(spacing_standard_new),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10,),

                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        SizedBox(
                          width: context.isPhone()? double.maxFinite: 400,
                          child: Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(spacing_standard_new),
                                  child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: spacing_standard,
                                    margin: const EdgeInsets.all(spacing_control),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage(ic_user),
                                      radius: 55,
                                    ).paddingAll(4),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: ()async {
                                    await ImagePicker().pickMultiImage(
                                      imageQuality: 100,
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(spacing_control),
                                    margin: const EdgeInsets.only(bottom: 30, right: 20),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.cardColor,
                                      border: Border.all(color: sh_colorPrimary, width: 1),
                                    ),
                                    child: const Icon(Icons.camera_alt, color: sh_colorPrimary, size: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          width: context.isPhone() ? double.maxFinite : 600,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      autofocus: false,
                                      controller: firstNameCont,
                                      textCapitalization: TextCapitalization.words,
                                      style: primaryTextStyle(),
                                      decoration: InputDecoration(
                                        filled: false,
                                        hintText: sh_hint_first_name,
                                        hintStyle: primaryTextStyle(),
                                        contentPadding: const EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(32.0),
                                          borderSide: BorderSide(
                                              color: Colors.grey.withOpacity(0.5),
                                              width: 0.5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(32.0),
                                          borderSide: BorderSide(
                                              color: Colors.grey.withOpacity(0.5),
                                              width: 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: spacing_standard_new,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      autofocus: false,
                                      controller: lastNameCont,
                                      textCapitalization: TextCapitalization.words,
                                      style: primaryTextStyle(),
                                      decoration: InputDecoration(
                                        filled: false,
                                        hintText: sh_hint_last_name,
                                        hintStyle: primaryTextStyle(),
                                        contentPadding: const EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(32.0),
                                          borderSide: BorderSide(
                                              color: Colors.grey.withOpacity(0.5),
                                              width: 0.5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(32.0),
                                          borderSide: BorderSide(
                                              color: Colors.grey.withOpacity(0.5),
                                              width: 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: spacing_standard_new),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3), width: 1),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(32.0)),
                                ),
                                child: DropdownButton<String>(
                                  underline: const SizedBox(),
                                  isExpanded: true,
                                  items: <String>["Male", "Female", "Other"].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: primaryTextStyle()),
                                    );
                                  }).toList(),
                                  //hint:Text(selectedValue),
                                  value: selectedValue,
                                  onChanged: (newVal) {
                                    setState(() {
                                      selectedValue = newVal;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: spacing_standard_new),
                              TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  controller: emailCont,
                                  textCapitalization: TextCapitalization.words,
                                  style: primaryTextStyle(),
                                  decoration: InputDecoration(
                                    filled: false,
                                    hintText: sh_hint_Email,
                                    hintStyle: primaryTextStyle(),
                                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0),),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28,),
                    Wrap(
                      children: [
                        Container(
                            constraints: const BoxConstraints(maxWidth: 400),
                          width: context.isPhone()? double.infinity : context.width()*0.45,
                          height: 45,
                          child:RoundedButton(
                            title: sh_lbl_save_profile,
                              color:sh_colorPrimary,titleColor: sh_white,
                              onPress:() => {})
                        ).paddingSymmetric(horizontal: 16,vertical: 8),


                        Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                            width: context.isPhone()? double.infinity : context.width()*0.45,
                            height: 45,
                            child:RoundedButton(
                                title: sh_lbl_change_pswd,
                                onPress:() => {})
                        ).paddingSymmetric(horizontal: 16,vertical: 8),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),

          const Footer()
        ],
      ),
    );
  }
}
