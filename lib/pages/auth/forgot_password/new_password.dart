import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/auth/login/login.dart';
import 'package:faysal/pages/auth/signupflow/widget/next_button.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class NewPassword extends StatefulWidget {
  final String email;
  final String token;
  const NewPassword({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool hidePassword = true;
  bool errorMesage = false;
  TextEditingController confirmPassword = TextEditingController();
  bool showConfirmationPassword = true;

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
                                    AutoSizeText("Create New Password",
                                        maxLines: 1,
                                        style: MyFaysalTheme.of(context)
                                            .promtHeaderText),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: size.width * 0.7),
                                      child: AutoSizeText(
                                          "Please ensure you use an easy to remember and secure password",
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
                                              controller: passwordController,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              cursorColor: Colors.white,
                                              style: MyFaysalTheme.of(context)
                                                  .textFieldText,
                                              obscureText: hidePassword,
                                              decoration: InputDecoration(
                                                  labelText: "Password",
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
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
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
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  filled: true,
                                                  fillColor: MyFaysalTheme.of(
                                                          context)
                                                      .scaffolbackgeroundColor),
                                              validator: (value) {
                                                RegExp valid = RegExp(
                                                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&_])[A-Za-z\d@$!%*?&]{8,}$');
                                                if (value!.isEmpty) {
                                                  return "Password field is required";
                                                }
                                                if (!valid.hasMatch(value)) {
                                                  return "Password must contain at least one capital letter, number, and special characters ";
                                                }
                                                if (value.length < 8) {
                                                  return "Password length should be more that 8 characters";
                                                }

                                                return null;
                                                //
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 25.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: TextFormField(
                                                controller: confirmPassword,
                                                cursorColor: Colors.white,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                obscureText:
                                                    showConfirmationPassword,
                                                style: MyFaysalTheme.of(context)
                                                    .textFieldText,
                                                decoration: InputDecoration(
                                                    labelText:
                                                        "Confirm New Password",
                                                    labelStyle: MyFaysalTheme.of(
                                                            context)
                                                        .promtHeaderText
                                                        .override(
                                                            color: MyFaysalTheme.of(
                                                                    context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.2),
                                                            fontSize: 15),
                                                    border: InputBorder.none,
                                                    hintText: "********",
                                                    suffixIcon: InkWell(
                                                        onTap: () =>
                                                            setState(() {
                                                              showConfirmationPassword =
                                                                  !showConfirmationPassword;
                                                            }),
                                                        child: Icon(
                                                          showConfirmationPassword
                                                              ? Icons
                                                                  .visibility_off_outlined
                                                              : Icons
                                                                  .visibility_outlined,
                                                          color: Colors.white,
                                                        )),
                                                    hintStyle:
                                                        MyFaysalTheme.of(context)
                                                            .textFieldText
                                                            .override(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.2)),
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0xff0B2B23)),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Confirm field is required";
                                                  }
                                                  if (passwordController.text
                                                          .trim() !=
                                                      value.trim()) {
                                                    return "Password Mismatch";
                                                  }
                                                  return null;
                                                  //
                                                },
                                              ),
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
                                text: "Reset Password",
                                isLoading: isLoading ? true : null,
                                call: () async {
                                  if (_formKey.currentState == null ||
                                      !_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Login().forgotPassword(widget.email,
                                      passwordController.text.trim(), () {
                                        FToast().showToast(
                              gravity: ToastGravity.TOP,
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 26, 26, 26),
                                    borderRadius: BorderRadius.circular(3)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 5),
                                child: Text(
                                  "Password reset successful, proceed to login",
                                  textAlign: TextAlign.center,
                                  style: MyFaysalTheme.of(context).text1
                                ),
                              ),
                              toastDuration: const Duration(seconds: 3),
                            );
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        PageTransition(
                                            child: const LoginWidget(),
                                            type: PageTransitionType.fade),
                                        (route) => false);
                                        if(mounted){
                                          setState(() {
                                    isLoading = true;
                                  });
                                        }
                                  }, context, confirmPassword.text.trim(),
                                      widget.token);
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
