// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/auth/signupflow/transaction_pin_creation.dart';
import 'package:faysal/pages/auth/signupflow/widget/next_button.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/provider/sign_up_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/box_pin_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ForgotPasswordEmail extends StatefulWidget {
  const ForgotPasswordEmail({super.key});

  @override
  State<ForgotPasswordEmail> createState() => _ForgotPasswordEmailState();
}

class _ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  late SignUpProvider provider;
  late FToast fToast;
  int resendTime = 20;
  Timer? time; 
  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    provider = Provider.of<SignUpProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
          child: WidgetBackgorund(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Expanded(
                    child: Column(
                  children: [CustomNavBar(header: "Verify your Email")],
                )),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(
                              vertical: size.height < 512 ? 10 : 0),
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.05,
                              horizontal: size.width < 300 ? 15 : 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: MyFaysalTheme.of(context).secondaryColor),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  AutoSizeText(
                                      "We sent you a verification code to your email",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: MyFaysalTheme.of(context)
                                          .promtHeaderText),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: AutoSizeText(
                                      "Enter the code sent to your  email ",
                                      style: MyFaysalTheme.of(context).text1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40.0),
                                    child: BoxPinWidget(
                                      pinLength: 6,
                                      controller: controller,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if(time !=null && time!.isActive)return;
                                     time = Timer.periodic(const Duration(seconds: 1), (timer) { 
                                          setState(() {
                                            resendTime -=1;
                                          });
                                          if(resendTime <=0){
                                            timer.cancel();
                                            resendTime=20;
                                          }
                                      });
                                      // Timer
        
                                      provider.userInfo['email_token'];
                                      provider.getVerificationToken(
                                          fToast,
                                          () => {},
                                          provider.userInfo["email"],
                                          context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom >
                                                  0
                                              ? MediaQuery.of(context)
                                                          .size
                                                          .height <
                                                      548
                                                  ? 5
                                                  : 20
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05),
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            AutoSizeText(
                                              "Didn’t receive any code? ",
                                              style:
                                                  MyFaysalTheme.of(context).text1,
                                            ),
                                            InkWell(
                                                child: AutoSizeText(
                                              resendTime == 20 ? "Resend Code" : "0:${resendTime < 10 ? '0$resendTime': resendTime.toString()}",
                                              style: MyFaysalTheme.of(context)
                                                  .text1
                                                  .override(
                                                      color: MyFaysalTheme.of(
                                                              context)
                                                          .primaryColor),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: Column(
                  children: [
                    NextButton(
                        text: "Continue",
                        isLoading: isLoading ? true : null,
                        call: () async {
                          if (controller.text.length < 6) return;
                          if (!await checkNetworkConnection(false)) {
                            showToast(context, "No Internet Connection");
                            return;
                          }
        
                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(const Duration(seconds: 2), () {});
        
                          if (provider.userInfo['email_token'] !=
                              int.parse(controller.text)) {
                            fToast.showToast(
                              gravity: ToastGravity.TOP,
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 26, 26, 26),
                                    borderRadius: BorderRadius.circular(3)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 5),
                                child: const Text(
                                  "Invalid OTP, try again.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Popppins",
                                      color: Colors.white),
                                ),
                              ),
                              toastDuration: const Duration(seconds: 3),
                            );
                            setState(() {
                              isLoading = false;
                            });
                            return;
                          }
        
                          await Future.delayed(const Duration(seconds: 2), () {});
                          setState(() {
                              isLoading = false;
                            });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PasswordAndPinCeation()));
                        },
                        rightPlacement: false)
                  ],
                )),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
