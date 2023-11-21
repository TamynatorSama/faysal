import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/account/security/widget/successful_modification.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_btn.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_success_background.dart';
import 'package:faysal/services/http_class.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/box_pin_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransactionPinReset extends StatefulWidget {
  const TransactionPinReset({super.key});

  @override
  State<TransactionPinReset> createState() => _TransactionPinResetState();
}

class _TransactionPinResetState extends State<TransactionPinReset> {
  TextEditingController pin = TextEditingController();
  bool isLoading = false;
  String answer = "";


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyFaysalTheme.of(context).secondaryColor,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 1)),
        child: SavingsBackground(
          child: Column(
            children: [
              CustomNavBar(
                  customPadding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top < 30
                          ? MediaQuery.of(context).size.height < 700
                              ? 20
                              : MediaQuery.of(context).size.height * 0.07
                          : MediaQuery.of(context).padding.top + 15),
                  header: "Security"),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: AutoSizeText(
                                "Transaction Pin",
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: MyFaysalTheme.of(context)
                                    .splashHeaderText
                                    .override(fontSize: 20),
                              ),
                            ),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.68),
                              child: AutoSizeText(
                                "Set your transaction pin to be used  to confirm transactions on your Faysal account",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: MyFaysalTheme.of(context).text1.override(
                                    color: Colors.white.withOpacity(0.4)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BoxPinWidget(
                        pinLength: 4,
                        controller: pin,
                        inputType: TextInputType.none,
                      )
                    ],
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Color(0xff061E18),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.3,
                              height: 3,
                              margin: EdgeInsets.only(top: size.height * 0.03),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white.withOpacity(0.5)),
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: size.height * 0.04),
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: size.width * 0.6),
                            child: Wrap(
                              runSpacing: MediaQuery.of(context).size.height < 625
                                  ? size.height * 0.025
                                  : size.height * 0.04,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomBlockButton(
                                      text: "1",
                                      pinController: pin,
                                    ),
                                    CustomBlockButton(
                                      text: "2",
                                      pinController: pin,
                                    ),
                                    CustomBlockButton(
                                      text: "3",
                                      pinController: pin,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomBlockButton(
                                      text: "4",
                                      pinController: pin,
                                    ),
                                    CustomBlockButton(
                                      text: "5",
                                      pinController: pin,
                                    ),
                                    CustomBlockButton(
                                      text: "6",
                                      pinController: pin,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomBlockButton(
                                      text: "7",
                                      pinController: pin,
                                    ),
                                    CustomBlockButton(
                                      text: "8",
                                      pinController: pin,
                                    ),
                                    CustomBlockButton(
                                      text: "9",
                                      pinController: pin,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomBlockButton(
                                      text: ".",
                                      pinController: pin,
                                    ),
                                    CustomBlockButton(
                                      text: "0",
                                      pinController: pin,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        pin.text = pin.text.replaceRange(
                                            pin.text.length - 1, null, "");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.12,
                                        height: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.12,
                                        decoration: BoxDecoration(
                                            color: MyFaysalTheme.of(context)
                                                .overlayColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: MyFaysalTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(24, 0, 24, size.height * 0.03),
                          child: SavingsButton(
                              isLoading: isLoading ? true : null,
                              text: "Set Transaction Pin",
                              call: () async {
                                if (pin.text.length < 4 || isLoading) {
                                  return;
                                }
                                var answer = await showSecurityQuestionDialog();
                                if (answer == null) return;
      
                                setState(() {
                                  isLoading = true;
                                });
      
                                var response = await HttpResponse()
                                    .changeTransactionPin(
                                        answer.trim(), pin.text.trim());
                                setState(() {
                                  isLoading = false;
                                });
      
                                if (response["status"] != 200) {
                                  FToast().showToast(
                                    gravity: ToastGravity.TOP,
                                    child: Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 26, 26, 26),
                                          borderRadius: BorderRadius.circular(3)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 5),
                                      child: Text(
                                        response["data"],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: "Popppins",
                                            color: Colors.white),
                                      ),
                                    ),
                                    toastDuration: const Duration(seconds: 3),
                                  );
                                }
      
                                navigate();
      
      
                              }),
                        )
                      ],
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
  navigate() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const SuccessfulModification(
                  message: "Transaction pin successfully set",
                )));
                }
}

class CustomBlockButton extends StatelessWidget {
  final String text;
  final TextEditingController pinController;
  const CustomBlockButton(
      {super.key, required this.text, required this.pinController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (pinController.text.length >= 4) return;
        pinController.text = pinController.text + text;
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.shortestSide * 0.14,
        height: MediaQuery.of(context).size.shortestSide * 0.14,
        decoration: BoxDecoration(
            color: MyFaysalTheme.of(context).overlayColor,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: MyFaysalTheme.of(context).splashHeaderText,
        ),
      ),
    );
  }
}
