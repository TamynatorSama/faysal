import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/auth/signupflow/success.dart';
import 'package:faysal/pages/auth/signupflow/widget/next_button.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/sign_up_provider.dart';
import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PasswordAndPinCeation extends StatefulWidget {
  const PasswordAndPinCeation({super.key});

  @override
  State<PasswordAndPinCeation> createState() => _PasswordAndPinCeationState();
}

class _PasswordAndPinCeationState extends State<PasswordAndPinCeation> {
  bool hidePassword = false;
  bool isSelected = false;
  final _formKey = GlobalKey<FormState>();
  late SignUpProvider provider;

  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  late FToast fToast;
  bool isLoading = false;

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
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
              body: WidgetBackgorund(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const CustomNavBar(header: "Create an Account"),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.maxFinite,
                                height:
                                    size.height < 659 ? size.height * 0.65 : null,
                                margin: EdgeInsets.only(
                                    top: size.height < 512 ? 10 : 0,
                                    bottom:
                                        MediaQuery.of(context).viewInsets.bottom >
                                                0
                                            ? size.height < 512
                                                ? 0
                                                : size.height * 0.2
                                            : 0),
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.05,
                                    horizontal: size.width < 300 ? 15 : 30),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color:
                                        MyFaysalTheme.of(context).secondaryColor),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          AutoSizeText("Almost Done",
                                              maxLines: 1,
                                              style: MyFaysalTheme.of(context)
                                                  .promtHeaderText),
                                          AutoSizeText(
                                            "Input your phone number and a transaction pin to complete registration",
                                            textAlign: TextAlign.center,
                                            style:
                                                MyFaysalTheme.of(context).text1,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.04),
                                        child: Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  child: TextFormField(
                                                    controller: phoneController,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor: Colors.white,
                                                    style:
                                                        MyFaysalTheme.of(context)
                                                            .textFieldText,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      LengthLimitingTextInputFormatter(
                                                          11)
                                                    ],
                                                    decoration: InputDecoration(
                                                        labelText: "Phone Number",
                                                        // labelText: "${size.height}",
                                                        labelStyle: MyFaysalTheme
                                                                .of(context)
                                                            .promtHeaderText
                                                            .override(
                                                                color: MyFaysalTheme
                                                                        .of(
                                                                            context)
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.2),
                                                                fontSize: 15),
                                                        border: InputBorder.none,
                                                        filled: true,
                                                        fillColor: MyFaysalTheme
                                                                .of(context)
                                                            .scaffolbackgeroundColor),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Field is required";
                                                      }
                                                      return null;
                                                      //
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 13.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(7),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              pinController,
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          cursorColor:
                                                              Colors.white,
                                                          style: MyFaysalTheme.of(
                                                                  context)
                                                              .textFieldText,
                                                          obscureText:
                                                              hidePassword,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly,
                                                            LengthLimitingTextInputFormatter(
                                                                4)
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "Transaction Pin",
                                                                  labelStyle: MyFaysalTheme.of(
                                                                          context)
                                                                      .promtHeaderText
                                                                      .override(
                                                                          color: MyFaysalTheme.of(context)
                                                                              .primaryColor
                                                                              .withOpacity(
                                                                                  0.2),
                                                                          fontSize:
                                                                              15),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  suffixIcon:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        hidePassword =
                                                                            !hidePassword;
                                                                      });
                                                                    },
                                                                    child: Icon(
                                                                      !hidePassword
                                                                          ? Icons
                                                                              .visibility_off_outlined
                                                                          : Icons
                                                                              .visibility_outlined,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  filled: true,
                                                                  fillColor: MyFaysalTheme.of(
                                                                          context)
                                                                      .scaffolbackgeroundColor),
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return "Field is required";
                                                            }
                                                            if (value.length <
                                                                4) {
                                                              return "Enter a 4 digit pin";
                                                            }
        
                                                            return null;
                                                            //
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: NextButton(
                                      isLoading: isLoading ? true : null,
                                      text: "Create Account",
                                      call: () async {
                                        if (_formKey.currentState == null ||
                                            !_formKey.currentState!.validate()) {
                                          return;
                                        }
                                        Provider.of<ProfileProvider>(context,
                                                listen: false)
                                            .getQuestions();
                                        String check =
                                            phoneController.text.startsWith("0")
                                                ? phoneController.text
                                                : "0${phoneController.text}";
                                        provider.populateUserInfo("phone", check);
                                        provider.populateUserInfo(
                                            "pin", pinController.text);
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await SignUpProvider().registerUser(
                                            provider.userInfo,
                                            () => Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: const SucesssSignUp(),
                                                    type:
                                                        PageTransitionType.fade)),
                                            context, (() {
                                          // Navigator.of(context).pop(false);
                                        }), (() async {
                                          await Login().loginUser(
                                            provider.userInfo["email"],
                                            provider.userInfo["password"],
                                            () {},
                                            context,
                                          );
                                        }));
        
                                        
                                        setState(() {
                                          isLoading = false;
                                        });
        
                                        // Navigator.push(
                                        //     context,
                                        //     PageTransition(
                                        //         type: PageTransitionType
                                        //             .rightToLeft,
                                        //         child:
                                        //             const VerifyEmail()));
                                      },
                                      rightPlacement: false),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ))),
        ));
  }
}
