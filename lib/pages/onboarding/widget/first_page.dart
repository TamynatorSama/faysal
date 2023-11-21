import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/auth/login/login.dart';
import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/widgets/custom_btn.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class FirstOnboarding extends StatefulWidget {
  final String header;
  final String subtitle;
  final int page;
  const FirstOnboarding({super.key,required this.header,required this.subtitle,required this.page});

  @override
  State<FirstOnboarding> createState() => _FirstOnboardingState();
}

class _FirstOnboardingState extends State<FirstOnboarding> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 24,right: 24,bottom: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/combined-logo.svg",width: MediaQuery.of(context).size.width * 0.3,),
                Padding(
                  padding: const EdgeInsets.only(top:40.0,bottom: 15),
                  child: AutoSizeText(
                    widget.header,
                  maxLines: 1,
                  style: MyFaysalTheme.of(context).splashHeaderText,),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: AutoSizeText(widget.subtitle,textAlign: TextAlign.center,style: MyFaysalTheme.of(context).text1.override(fontSize: MediaQuery.of(context).size.width > 600?MediaQuery.of(context).size.width * 0.025:null),)),
                Padding(
                  padding: EdgeInsets.only(top:MediaQuery.of(context).size.shortestSide * 0.1 > 40 ? 33:MediaQuery.of(context).size.shortestSide * 0.1 < 15 ? 15:MediaQuery.of(context).size.shortestSide * 0.1 ),
                  child: Wrap(
                    spacing: 5,
                    children: List.generate(3, (index) => Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: widget.page != index? MyFaysalTheme.of(context).accentColor.withOpacity(0.6) :MyFaysalTheme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(2)
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom:30.0,left: 24,right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(text:"Get Started",call: (){
                  Login().hasUsedApp = true;
                  Navigator.pushReplacement(context,PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const LoginWidget()
                  ));
                },)
              ],
            ),
          ),
        )
      ],
    );
  }
}