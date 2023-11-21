// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/scan/qr_page.dart';
import 'package:faysal/pages/topup/widgets/topup_button.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/qr_scan_provider.dart';
import 'package:faysal/utils/formatter.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QrAmount extends StatefulWidget {
  const QrAmount({super.key});

  @override
  State<QrAmount> createState() => _QrAmountState();
}

class _QrAmountState extends State<QrAmount> {
  late FocusNode watcher;
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  late QrScanProvider provider;

  @override
  void initState() {
    provider = Provider.of<QrScanProvider>(context,listen: false);
    watcher = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    watcher.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: WidgetBackgorund(
          home: true,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                24.0,
                size.height < 750
                    ? size.height < 600
                        ? size.height * 0.02
                        : 0
                    : size.height * 0.02,
                24.0,
                0),
            child: Column(
              children: [
                const CustomNavBar(header: "Transfers"),
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText.rich(
                            TextSpan(children: [
                              const TextSpan(text: "MyFaysal Balance - "),
                              TextSpan(
                                  text: getCurrency(),
                                  style: const TextStyle(fontFamily: "Poppins")),
                              TextSpan(text: NumberFormat().format(Provider.of<ProfileProvider>(context,listen: false).userProfile.balance))
                            ]),
                            style: MyFaysalTheme.of(context)
                                .text1
                                .override(color: Colors.white.withOpacity(0.5))),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: size.height * 0.03),
                          child: IntrinsicWidth(
                            child: TextFormField(
                              focusNode: watcher,
                              controller: controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.none,
                              cursorColor: MyFaysalTheme.of(context).primaryText,
                              style: MyFaysalTheme.of(context)
                                  .splashHeaderText
                                  .override(
                                      fontSize: size.width * 0.1,
                                      fontFamily: "Poppins"),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Amount",
                                hintStyle: MyFaysalTheme.of(context)
                                    .splashHeaderText
                                    .override(
                                        fontSize: size.width * 0.1,
                                        fontFamily: "Poppins",
                                        color: MyFaysalTheme.of(context)
                                            .primaryText
                                            .withOpacity(0.6)),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyFormatter()
                              ],
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: size.height * 0.47 > 350
                                  ? 350
                                  : size.height * 0.47,
                              maxWidth: size.width * 0.7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  CustomBlockButton(text: "1",controller: controller),
                                  CustomBlockButton(text: "2",controller: controller),
                                  CustomBlockButton(text: "3",controller: controller),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomBlockButton(text: "4",controller: controller),
                                  CustomBlockButton(text: "5",controller: controller),
                                  CustomBlockButton(text: "6",controller: controller),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomBlockButton(text: "7",controller: controller),
                                  CustomBlockButton(text: "8",controller: controller),
                                  CustomBlockButton(text: "9",controller: controller),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomBlockButton(text: ".",controller: controller),
                                  CustomBlockButton(text: "0",controller: controller),
                                  InkWell(
                                    onTap: (){
                                      if (controller.text.isEmpty) return;
                                  var pointer = controller.selection.extentOffset == -1
                                      ? 0
                                      : controller.selection.extentOffset;
                            
                                  if (pointer == 0) return;
                            
                                  String prevText = controller.text
                                      .replaceRange(pointer - 1, null, "");
                                  String nxtText =
                                      controller.text.replaceRange(0, pointer, "");
                                  
                            
                                  controller.text = prevText + nxtText;
                                  
                            
                                  if (pointer < controller.text.length - 1 || pointer == controller.text.length) {
                                    controller.selection =
                                        TextSelection.collapsed(offset: pointer - 1);
                                  }
                                  else {
                                    controller.selection = TextSelection.collapsed(
                                        offset: controller.text.length);
                                  }
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.15,
                                        height: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.15,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff123F33),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color:
                                              MyFaysalTheme.of(context).primaryText,
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                TopUpButton(
                  reuse: true,
                  isLoading: isLoading ? true : null,
                  call: () async{
                    if(controller.text.isEmpty) return;
                    setState(() {
                                        isLoading = true;
                                      });
                                      provider.amount = controller.text;
                                      provider.description = "Qr payment of ${controller.text}";
                                      provider.generateUniqueTransactionRef();
                                      bool truth = await provider.initiateTransaction(context);
                                      setState(() {
                                        isLoading = false;
                                      });
      
                                      if(truth){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> QrPage(amount: controller.text,description:"Qr payment of ${controller.text}")));
                                      }
                    
      
                  },
                  text: "Next",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBlockButton extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const CustomBlockButton({super.key, required this.text, required this.controller });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        var pointer = controller.selection.extentOffset == -1
              ? 0
              : controller.selection.extentOffset;

          String prevText =
              controller.text.replaceRange(pointer, null, "");
          String nxtText =
              controller.text.replaceRange(0, pointer, "");

          controller.text = prevText + text + nxtText;

          if (pointer < controller.text.length - 1) {
            controller.selection =
                TextSelection.collapsed(offset: pointer + 1);
          } else {
            controller.selection = TextSelection.collapsed(
                offset: controller.text.length);
          }
          // setState(() {});
        
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.shortestSide * 0.15,
        height: MediaQuery.of(context).size.shortestSide * 0.15,
        decoration: BoxDecoration(
            color: const Color(0xff123F33),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: MyFaysalTheme.of(context).splashHeaderText,
        ),
      ),
    );
  }
}
