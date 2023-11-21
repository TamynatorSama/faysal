import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/auth/signupflow/confirm_email.dart';
import 'package:faysal/pages/auth/signupflow/widget/next_button.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/sign_up_provider.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool hidePassword = false;
  bool isSelected = false;
  final _formKey = GlobalKey<FormState>();
  late SignUpProvider provider;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body:  MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
            child: WidgetBackgorund(
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
                                      height: size.height < 659 ? size.height * 0.65 :null,
                                      margin: EdgeInsets.only(
                                          top: size.height < 512 ? 10 : 0,
                                          bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom >
                                                  0
                                              ? size.height < 512
                                                  ? 0
                                                  : size.height * 0.2
                                              : 0),
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.05,
                                          horizontal:
                                              size.width < 300 ? 15 : 30),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: MyFaysalTheme.of(context)
                                              .secondaryColor),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                AutoSizeText(
                                                    "Welcome to Faysal",
                                                    maxLines: 1,
                                                    style: MyFaysalTheme.of(
                                                            context)
                                                        .promtHeaderText),
                                                AutoSizeText(
                                                  "Complete your sign up to get started",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      MyFaysalTheme.of(context)
                                                          .text1,
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
                                                        BorderRadius.circular(
                                                            7),
                                                    child: TextFormField(
                                                      controller:
                                                          nameController,
                                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      cursorColor: Colors.white,
                                                      style: MyFaysalTheme.of(
                                                              context)
                                                          .textFieldText,
                                                      decoration:
                                                          InputDecoration(
                                                              labelText: "Name",
                                                              // labelText: "${size.height}",
                                                              labelStyle: MyFaysalTheme
                                                                      .of(
                                                                          context)
                                                                  .promtHeaderText
                                                                  .override(
                                                                      color: MyFaysalTheme.of(
                                                                              context)
                                                                          .primaryColor
                                                                          .withOpacity(
                                                                              0.2),
                                                                      fontSize:
                                                                          15),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              filled: true,
                                                              fillColor: MyFaysalTheme
                                                                      .of(context)
                                                                  .scaffolbackgeroundColor),
                                                      validator: (value) {
                                                        var reg = RegExp(
                                                            r"^[A-Za-z\s]*$");
                                                        if (!reg.hasMatch(
                                                            value!.trim())) {
                                                          return "Enter a valid name";
                                                        }
                                                        if (value.isEmpty) {
                                                          return "Name field is required";
                                                        }
                                                        return null;
                                                        //
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      child: TextFormField(
                                                        controller:
                                                            emailController,
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        cursorColor:
                                                            Colors.white,
                                                        style: MyFaysalTheme.of(
                                                                context)
                                                            .textFieldText,
                                                        decoration:
                                                            InputDecoration(
                                                                labelText:
                                                                    "Email",
                                                                // labelText: "${size.height}",
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
                                                                filled: true,
                                                                fillColor: MyFaysalTheme.of(
                                                                        context)
                                                                    .scaffolbackgeroundColor),
                                                        validator: (value) {
                                                          var reg = RegExp(
                                                              r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$");
                                                          if (!reg.hasMatch(
                                                              value!.trim())) {
                                                            return "Enter a valid email address";
                                                          }
                                                          if (value.isEmpty) {
                                                            return "Email is required";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                          child: TextFormField(
                                                            controller:
                                                                passwordController,
                                                                // autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            keyboardType:
                                                                TextInputType
                                                                    .visiblePassword,
                                                            cursorColor:
                                                                Colors.white,
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .textFieldText,
                                                            obscureText:
                                                                hidePassword,
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        "Password",
                                                                    labelStyle: MyFaysalTheme.of(context).promtHeaderText.override(
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
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          hidePassword =
                                                                              !hidePassword;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        !hidePassword
                                                                            ? Icons.visibility_off_outlined
                                                                            : Icons.visibility_outlined,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    fillColor: MyFaysalTheme.of(
                                                                            context)
                                                                        .scaffolbackgeroundColor),
                                                            validator: (value) {
                                                              RegExp valid = RegExp(
                                                                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&_])[A-Za-z\d@$!%*?&]{8,}$');
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Password field is required";
                                                              }
                                                              if (!valid
                                                                  .hasMatch(
                                                                      value)) {
                                                                return "Password must contain at least one capital letter, number, and special characters ";
                                                              }
                                                              if (value.length <
                                                                  8) {
                                                                return "Password length should be more that 8 characters";
                                                              }
                                                                                              
                                                              return null;
                                                              //
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: AutoSizeText(
                                                            "*Password must contain at least one capital letter, number and special character",
                                                            maxLines: 2,
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .text1
                                                                .override(
                                                                  fontSize: size.width * 0.02,
                                                                  color: MyFaysalTheme.of(
                                                                          context)
                                                                      .accentColor,
                                                                ),
                                                          ),
                                                        )
                                                      
                                                      ],
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
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: NextButton(
                                            isLoading: isLoading ? true : null,
                                            text: "Create Account",
                                            call: () async {
                                              if (_formKey.currentState == null ||
                                                  !_formKey.currentState!
                                                      .validate()) {
                                                return;
                                              }
                                              Provider.of<ProfileProvider>(
                                                      context,
                                                      listen: false)
                                                  .getQuestions();
                                              setState(() {
                                                isLoading = true;
                                              });
                                              provider.populateUserInfo("email",
                                                  emailController.text.trim());
                                              provider.populateUserInfo("name",
                                                  nameController.text.trim());
                                              provider.populateUserInfo(
                                                  "password",
                                                  passwordController.text.trim());
          
                                              await provider.getVerificationToken(
                                                  fToast,
                                                  (() => Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type: PageTransitionType
                                                              .rightToLeft,
                                                          child:
                                                              const VerifyEmail()))),
                                                  provider.userInfo["email"],
                                                  context);
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
                                      NextButton(
                                          text: "Existing User",
                                          call: () {
                                            Navigator.pop(context);
                                          },
                                          rightPlacement: true),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    )),
          )
        ));
  }
}
