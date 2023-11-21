import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/account/security/widget/verification_card.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_success_background.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountVerification extends StatefulWidget {
  const AccountVerification({super.key});

  @override
  State<AccountVerification> createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: Scaffold(
          backgroundColor: MyFaysalTheme.of(context).secondaryColor,
          body: Consumer<ProfileProvider>(
            builder: (context,provider,child) {
              return SavingsBackground(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24),
                  child:Column(
                    children: [
                      const CustomNavBar(header: "Security"),
                      Expanded(child: ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(overscroll: false),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: size.height * 0.038),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: AutoSizeText("Account Verification",
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: 20),),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: size.width * 0.68),
                                      child: AutoSizeText("To enjoy all the features of your Faysal, we need to verify your details",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: MyFaysalTheme.of(context).text1.override(color: Colors.white.withOpacity(0.4)),),
                                    ),
                                  ],
                                ),
                              ),
                              Wrap(
                                runSpacing: 20,
                                children: List.generate(
                                  3,
                                 (index) => VerificationCard(title: index == 0? "BVN":index == 1?"Phone Number":"Email", value: index == 0? provider.userProfile.bvn.toString():index == 1? provider.userProfile.phone:provider.userProfile.email, verified: index == 0? false  :index == 1?provider.userProfile.hasVerifiedPhone == null || provider.userProfile.hasVerifiedPhone!.isEmpty  ?false:true :   provider.userProfile.hasVerifiedEmail == null || provider.userProfile.hasVerifiedEmail!.isEmpty?  false:true,)),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  )
                ),
              
              );
            }
          ),
        ),
      ),
    );
  }
}