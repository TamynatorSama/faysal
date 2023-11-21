import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/app_navigator.dart';
import 'package:faysal/pages/auth/signupflow/widget/next_button.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/join_savings/single_join_view.dart';
import 'package:faysal/provider/sign_up_provider.dart';
import 'package:faysal/utils/dynamic_links.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SucesssSignUp extends StatelessWidget {
  const SucesssSignUp({super.key});



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
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
                  children: [CustomNavBar(header: "Welcome to Faysal")],
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
                                  AutoSizeText("Hi ${Provider.of<SignUpProvider>(context,listen:false).userInfo["name"]}",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: MyFaysalTheme.of(context)
                                          .promtHeaderText),
                                  Padding(
                                    padding: const EdgeInsets.only(top:5.0),
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 200),
                                      child: AutoSizeText(
                                        "Welcome to Faysal, you have successfully created an account.",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: MyFaysalTheme.of(context).text1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                                child: Image.asset("assets/images/success.png",width: MediaQuery.of(context).size.width * 0.4,),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: Column(
                  children: [
                    NextButton(text: "Let’s Get Started", call: () {
                      if (DynamicLinkHandler.ajoCode.isNotEmpty) {
            DynamicLinkHandler().startedFromLogin = true;
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    childCurrent: const SucesssSignUp(),
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
                                        childCurrent: const SucesssSignUp(),
                                        duration: const Duration(milliseconds: 100),
                                        child: const AppNavigator()),(route)=>false);
                    }, rightPlacement: false)
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
