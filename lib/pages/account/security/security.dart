import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/account/security/password_reset.dart';
import 'package:faysal/pages/account/security/transaction_pin_reset.dart';
import 'package:faysal/pages/account/security/verification.dart';
import 'package:faysal/pages/account/widget/information_column.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';

class ProfileSecurity extends StatelessWidget {
  const ProfileSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: Scaffold(
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body: WidgetBackgorund(
            home: true,
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
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: size.width * 0.6),
                              child: AutoSizeText("Keep your Faysal account secure by setting your security details",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: MyFaysalTheme.of(context).text1.override(color: Colors.white.withOpacity(0.4)),),
                            ),
                          ),
      
                          Container(
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                      horizontal: size.width < 327 ? 15 : 25),
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    color: MyFaysalTheme.of(context).secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InformationColumn(title: "Password", value: "Update Password",call: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PasswordReset())),icon: "assets/svg/key.svg"),
                      InformationColumn(title: "Transaction Pin", value: "Update Transaction Pin",call: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TransactionPinReset())),icon: "assets/svg/cascade.svg"),
                      InformationColumn(title: "Account Verification", value: "BVN, Phone & Email",call: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AccountVerification())),icon: "assets/svg/mob.svg",),
                      
                    ],
                  ),
                ),
      
          
                        ],
                      ),
                    ),
                  ))
                ],
              )
            ),
          
          ),
        ),
      ),
    );
  }
}