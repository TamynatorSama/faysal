// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/app_navigator.dart';
import 'package:faysal/pages/auth/forgot_password/forgot_main.dart';
import 'package:faysal/pages/auth/signupflow/signup.dart';
import 'package:faysal/pages/auth/signupflow/widget/next_button.dart';
import 'package:faysal/pages/rotating_savings/join_savings/single_join_view.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/dynamic_links.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  final LocalAuthentication auth = LocalAuthentication();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool hidePassword = true;
  bool errorMesage = false;

  @override
  void initState() {
    Login().isLoggedIn = false;
    emailController =
        TextEditingController(text: Login().email.isEmpty ? "" : Login().email);
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
          data: MediaQuery.of(context).copyWith(
              textScaleFactor:
                  MediaQuery.of(context).textScaleFactor.clamp(1, 1.05)),
          child: WidgetBackgorund(
              child: Padding(
            padding: EdgeInsets.fromLTRB(
                24,
                MediaQuery.of(context).padding.top < 60
                    ? size.height * 0.06
                    : MediaQuery.of(context).padding.top + 15,
                24,
                0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/combined-logo.svg",
                  width: size.width * 0.3,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(
                                top: size.height < 512 ? 10 : 0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom > 0
                                        ? size.height < 512
                                            ? 0
                                            : size.height * 0.2
                                        : 0),
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.06,
                                horizontal: size.width < 300 ? 15 : 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:
                                    MyFaysalTheme.of(context).secondaryColor),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    AutoSizeText("Hi There!",
                                        style: MyFaysalTheme.of(context)
                                            .promtHeaderText
                                            .override(
                                              color: MyFaysalTheme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.2),
                                            )),
                                    AutoSizeText("Welcome Back",
                                        maxLines: 1,
                                        style: MyFaysalTheme.of(context)
                                            .promtHeaderText)
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.03),
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: TextFormField(
                                              controller: emailController,
                                              cursorColor: Colors.white,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              style: MyFaysalTheme.of(context)
                                                  .textFieldText,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.all(10),
                                                  labelText: "Email",
                                                  labelStyle: MyFaysalTheme.of(
                                                          context)
                                                      .promtHeaderText
                                                      .override(
                                                          color: MyFaysalTheme
                                                                  .of(context)
                                                              .primaryColor
                                                              .withOpacity(0.2),
                                                          fontSize: 15),
                                                  border: InputBorder.none,
                                                  filled: true,
                                                  fillColor: MyFaysalTheme.of(
                                                          context)
                                                      .scaffolbackgeroundColor),
                                              onChanged: (value) =>
                                                  setState(() {
                                                errorMesage = false;
                                              }),
                                              validator: (value) {
                                                var reg = RegExp(
                                                    r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$");
                                                if (value!.isEmpty) {
                                                  return "Email is required";
                                                }
                                                if (!reg
                                                    .hasMatch(value.trim())) {
                                                  return "Enter a valid email address";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        child: TextFormField(
                                                          controller:
                                                              passwordController,
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                          cursorColor:
                                                              Colors.white,
                                                              
                                                          keyboardType:
                                                              TextInputType
                                                                  .visiblePassword,
                                                          style: MyFaysalTheme
                                                                  .of(context)
                                                              .textFieldText,
                                                          obscureText:
                                                              hidePassword,
                                                          decoration:
                                                              InputDecoration(
                                                                contentPadding: const EdgeInsets.all(10),
                                                                  labelText:
                                                                      "Password",
                                                                  labelStyle: MyFaysalTheme
                                                                          .of(
                                                                              context)
                                                                      .promtHeaderText
                                                                      .override(
                                                                          color: MyFaysalTheme.of(context).primaryColor.withOpacity(
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
                                                                      hidePassword
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
                                                          onChanged: (value) =>
                                                              setState(() {
                                                            errorMesage = false;
                                                          }),
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "password is required";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Offstage(
                                                      offstage: Login()
                                                          .userToken
                                                          .isEmpty,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          authenticate();
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 7),
                                                          decoration: BoxDecoration(
                                                              color: MyFaysalTheme
                                                                      .of(
                                                                          context)
                                                                  .primaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: SvgPicture.string(
                                                              '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M2 12C2 6.5 6.5 2 12 2a10 10 0 0 1 8 4"></path><path d="M5 19.5C5.5 18 6 15 6 12c0-.7.12-1.37.34-2"></path><path d="M17.29 21.02c.12-.6.43-2.3.5-3.02"></path><path d="M12 10a2 2 0 0 0-2 2c0 1.02-.1 2.51-.26 4"></path><path d="M8.65 22c.21-.66.45-1.32.57-2"></path><path d="M14 13.12c0 2.38 0 6.38-1 8.88"></path><path d="M2 16h.01"></path><path d="M21.8 16c.2-2 .131-5.354 0-6"></path><path d="M9 6.8a6 6 0 0 1 9 5.2c0 .47 0 1.17-.02 2"></path></svg>',
                                                              color: MyFaysalTheme
                                                                      .of(context)
                                                                  .secondaryColor),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                !errorMesage
                                                    ? const Offstage()
                                                    : Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerStart,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: AutoSizeText(
                                                            "Email or password does not match records",
                                                            maxLines: 2,
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .text1
                                                                .override(
                                                                  color: MyFaysalTheme.of(
                                                                          context)
                                                                      .accentColor,fontSize: 12,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                              
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              child:
                                                                  const ForgotPasswordMain()));
                                                    },
                                                    child: Text(
                                                      "Forgot Password?",
                                                      textAlign: TextAlign.end,
                                                      style:
                                                          MyFaysalTheme.of(
                                                                  context)
                                                              .text1
                                                              .override(
                                                                color: MyFaysalTheme.of(
                                                                        context)
                                                                    .primaryText
                                                                    .withOpacity(
                                                                        0.4),
                                                              ),
                                                    )),
                                                
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: NextButton(
                                text: "Login",
                                isLoading: isLoading ? true : null,
                                call: () async {
                                  if (_formKey.currentState == null ||
                                      !_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  if (isLoading) return;
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (Login().userToken.isNotEmpty) {
                                    await Login().logoutUser(() async {
                                      Provider.of<ProfileProvider>(context,
                                              listen: false)
                                          .clearProvider();
                                      await Login.removeRecord();
                                    }, context, () {});
                                  }

                                  FocusManager.instance.primaryFocus?.unfocus();
                                  errorMesage = await Login().loginUser(
                                    emailController.text,
                                    passwordController.text,
                                    () {
                                      if (DynamicLinkHandler
                                          .ajoCode.isNotEmpty) {
                                            DynamicLinkHandler().startedFromLogin = true;
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .bottomToTop,
                                                childCurrent:
                                                    const LoginWidget(),
                                                duration: const Duration(
                                                    milliseconds: 100),
                                                child: SingleJoinView(
                                                  ajoCode: DynamicLinkHandler
                                                      .ajoCode,
                                                )),
                                            (route) => false);
                                        return;
                                      }
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              childCurrent: const LoginWidget(),
                                              duration: const Duration(
                                                  milliseconds: 100),
                                              child: const AppNavigator()),
                                          (route) => false);
                                    },
                                    context,
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                rightPlacement: false),
                          ),
                          NextButton(
                              text: "Create Account",
                              call: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const SignUpWidget()));
                              },
                              rightPlacement: false),
                              const SizedBox(height: 10)
                        ],
                      ),
                      //   child: Column(
                      //     children: [
                      //       LoginBtn(
                      //         text: "Login",
                      //         call: () {},
                      //         outline: false,
                      //       ),
                      //       LoginBtn(
                      //         text: "Create a New Account",
                      //         call: () {
                      //           Navigator.push(context,PageTransition(
                      //   type: PageTransitionType.rightToLeft,
                      //   child: const SignUpWidget()
                      // ));
                      //         },
                      //         outline: true,
                      //       ),
                      //     ],
                      //   ),
                    )
                  ],
                )),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future authenticate() async {
    final bool isBiometricsAvailable = await auth.isDeviceSupported();

    if (!isBiometricsAvailable) {
      showToast(context,
          "Can't authenticate with biometrics, make use of your password");
      return false;
    }

    try {
      var response = await auth.authenticate(
        localizedReason: 'Scan to accces your fasyal account',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (response) {
        bool network = await checkNetworkConnection(true, context);
        if (!network) return;
        setState(() {
          isLoading = true;
        });
        await Future.delayed(const Duration(milliseconds: 1500), () {
          Login().isLoggedIn = true;
          if (DynamicLinkHandler.ajoCode.isNotEmpty) {
            DynamicLinkHandler().startedFromLogin = true;
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    childCurrent: const LoginWidget(),
                    duration: const Duration(milliseconds: 100),
                    child: SingleJoinView(
                      ajoCode: DynamicLinkHandler.ajoCode,
                    )),
                (route) => false);
            return;
          }
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  childCurrent: const LoginWidget(),
                  duration: const Duration(milliseconds: 100),
                  child: const AppNavigator()),
              (route) => false);
        });
        setState(() {
          isLoading = false;
        });
      }
    } on PlatformException {
      return;
    }
  }
}
