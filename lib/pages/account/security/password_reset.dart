

import 'package:faysal/pages/account/security/widget/successful_modification.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_btn.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_success_background.dart';
import 'package:faysal/services/http_class.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool showpassword = true;
  bool showOldpassword = true;
  bool showConfirmationPassword = true;

  @override
  void dispose() {
    newPassword.dispose();
    oldPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
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
          backgroundColor: MyFaysalTheme.of(context).secondaryColor,
          body: Form(
            key: _formKey,
            child: SavingsBackground(
                child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(children: [
                      const CustomNavBar(header: "Security"),
                      Expanded(
                        child: ScrollConfiguration(
                            behavior: const ScrollBehavior()
                                .copyWith(overscroll: false),
                            child: SingleChildScrollView(
                                child: Column(children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.047,
                                    bottom: size.height * 0.04),
                                child: Text("Update Password",
                                    style: MyFaysalTheme.of(context)
                                        .splashHeaderText
                                        .override(fontSize: size.width * 0.05)),
                              ),
                              Wrap(
                                runSpacing: size.height * 0.04,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: TextFormField(
                                      controller: oldPassword,
                                      obscureText: showOldpassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      cursorColor: Colors.white,
                                      style:
                                          MyFaysalTheme.of(context).textFieldText,
                                      decoration: InputDecoration(
                                          labelText: " Current Password",
                                          labelStyle: MyFaysalTheme.of(context)
                                              .promtHeaderText
                                              .override(
                                                  color: MyFaysalTheme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.2),
                                                  fontSize: 15),
                                          border: InputBorder.none,
                                          hintText: "********",
                                          suffixIcon: InkWell(
                                              onTap: () => setState(() {
                                                    showOldpassword =
                                                        !showOldpassword;
                                                  }),
                                              child: Icon(
                                                showOldpassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.white,
                                              )),
                                          hintStyle: MyFaysalTheme.of(context)
                                              .textFieldText
                                              .override(
                                                  color: Colors.white
                                                      .withOpacity(0.2)),
                                          filled: true,
                                          fillColor: const Color(0xff0B2B23)),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Confirm field is required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: TextFormField(
                                      controller: newPassword,
                                      cursorColor: Colors.white,
                                      obscureText: showpassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style:
                                          MyFaysalTheme.of(context).textFieldText,
                                      decoration: InputDecoration(
                                          labelText: "New Password",
                                          // labelText: "${MediaQuery.of(context).viewInsets.bottom}",
                                          labelStyle: MyFaysalTheme.of(context)
                                              .promtHeaderText
                                              .override(
                                                  color: MyFaysalTheme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.2),
                                                  fontSize: 15),
                                          border: InputBorder.none,
                                          hintText: "********",
                                          suffixIcon: InkWell(
                                              onTap: () => setState(() {
                                                    showpassword = !showpassword;
                                                  }),
                                              child: Icon(
                                                showpassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.white,
                                              )),
                                          hintStyle: MyFaysalTheme.of(context)
                                              .textFieldText
                                              .override(
                                                  color: Colors.white
                                                      .withOpacity(0.2)),
                                          filled: true,
                                          fillColor: const Color(0xff0B2B23)),
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
                                    padding: const EdgeInsets.only(bottom: 25.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: TextFormField(
                                        controller: confirmPassword,
                                        cursorColor: Colors.white,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        obscureText: showConfirmationPassword,
                                        style: MyFaysalTheme.of(context)
                                            .textFieldText,
                                        decoration: InputDecoration(
                                            labelText: "Confirm New Password",
                                            labelStyle: MyFaysalTheme.of(context)
                                                .promtHeaderText
                                                .override(
                                                    color:
                                                        MyFaysalTheme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.2),
                                                    fontSize: 15),
                                            border: InputBorder.none,
                                            hintText: "********",
                                            suffixIcon: InkWell(
                                                onTap: () => setState(() {
                                                      showConfirmationPassword =
                                                          !showConfirmationPassword;
                                                    }),
                                                child: Icon(
                                                  showConfirmationPassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.white,
                                                )),
                                            hintStyle: MyFaysalTheme.of(context)
                                                .textFieldText
                                                .override(
                                                    color: Colors.white
                                                        .withOpacity(0.2)),
                                            filled: true,
                                            fillColor: const Color(0xff0B2B23)),
                                        validator: (value) {
                                          RegExp valid = RegExp(
                                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&_])[A-Za-z\d@$!%*?&]{8,}$');
      
                                          if (!valid.hasMatch(value.toString())) {
                                            return "Password must contain at least one capital letter, number, and special characters ";
                                          }
                                          if (value!.isEmpty) {
                                            return "Confirm field is required";
                                          }
                                          if (newPassword.text.trim() !=
                                              value.trim()) {
                                            return "Password Mismatch";
                                          }
                                          if (value.length < 8) {
                                            return "Password length should be more that 8 characters";
                                          }
                                          return null;
                                          //
                                        },
                                      ),
                                    ),
                                  ),
                                
                                ],
                              )
                            ]))),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: size.height * 0.05),
                            child: SavingsButton(
                              isLoading: isLoading ? true: null,
                                text: "Next",
                                call: () async {
                                  if (_formKey.currentState == null ||
                                      !_formKey.currentState!.validate()) {
                                    return;
                                  }
      
                                  if (isLoading) return;
                                  setState(() {
                                    isLoading = true;
                                  });
                                  FToast toast = FToast();
                                  toast.init(context);
                                  var response = await HttpResponse()
                                      .changePassword(
                                          confirmPassword.text, oldPassword.text);
                                  if (response["status"] != 200) {
                                    toast.showToast(
                                      gravity: ToastGravity.TOP,
                                      child: Container(
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 26, 26, 26),
                                            borderRadius:
                                                BorderRadius.circular(3)),
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
      
                                    setState(() {
                                      isLoading = false;
                                    });
                                    return;
                                  }
      
                                  setState(() {
                                      isLoading = false;
                                    });
                                    navigate();
      
      
                                }),
                          )
                        ],
                      )
                    ]))),
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
                  message: "Password successfully updated",
                )));
  }
}
