import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/auth/forgot_password/forget_password_email_verification.dart';
import 'package:faysal/pages/auth/signupflow/widget/next_button.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';

class ForgotPasswordMain extends StatefulWidget {
  const ForgotPasswordMain({super.key});

  @override
  State<ForgotPasswordMain> createState() => _ForgotPasswordMainState();
}

class _ForgotPasswordMainState extends State<ForgotPasswordMain> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool hidePassword = true;
  bool errorMesage = false;

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
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomNavBar(header: "Forgot Password"),
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
                                    AutoSizeText("Reset Password",
                                        maxLines: 1,
                                        style: MyFaysalTheme.of(context)
                                            .promtHeaderText),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: size.width * 0.6),
                                      child: AutoSizeText(
                                        "Enter your email to initiate password reset",
                                        textAlign: TextAlign.center,
                                          style: MyFaysalTheme.of(context)
                                              .text1
                                              .override(
                                                color: MyFaysalTheme.of(context)
                                                    .primaryText
                                                    .withOpacity(0.4),
                                              )),
                                    ),
                                    
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
                                                  labelText: "Email",

                                                  // labelText: "${MediaQuery.of(context).viewInsets.bottom}",
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
                                text: "Verify Email",
                                isLoading: isLoading ? true : null,
                                call: () async {
                                  if (_formKey.currentState == null ||
                                      !_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordEmailVerification(email: emailController.text )));
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                rightPlacement: false),
                          ),
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
}
