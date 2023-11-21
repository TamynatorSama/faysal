import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:faysal/pages/account/edit_profile.dart';
import 'package:faysal/pages/account/security/security.dart';
import 'package:faysal/pages/account/widget/information_column.dart';
import 'package:faysal/pages/auth/login/login.dart';
import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/provider/history_provider.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/constants.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/two_items_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ProfileProvider>(
      builder: (context, provider,child) {
        return Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top < 30
                  ? size.height * 0.1 > 70
                      ? 70
                      : size.height * 0.1
                  : MediaQuery.of(context).padding.top + 20,
              left: 24,
              right: 24),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    "Profile",
                    style: MyFaysalTheme.of(context)
                        .splashHeaderText
                        .override(fontSize: 20),
                  ),
                  Column(
                    children: [
                      Container(
                        width: size.width * 0.26 < 76
                            ? 76
                            : size.width * 0.26 > 99
                                ? 99
                                : size.width * 0.26,
                        height: size.width * 0.26,
                        margin: EdgeInsets.only(top: size.height * 0.03),
                        decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            image: provider.userProfile.avatar.isEmpty? DecorationImage(
                                  image: AssetImage("assets/avatar/avatar${generateAvatar(provider.userProfile.id.toString())}.png")):DecorationImage(
                                  image: CachedNetworkImageProvider("$imageUrl/${provider.userProfile.avatar}",cacheKey: provider.cacheKey,),fit: BoxFit.cover )),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: size.width * 0.7),
                        child: AutoSizeText(
                          provider.userProfile.name.capitalize(" "),
                          maxLines: 1,
                          style: MyFaysalTheme.of(context)
                              .splashHeaderText
                              .override(fontSize: 22, lineHeight: 2),
                        ),
                      )
                    ],
                  ),
                  TwoInfoDisplay(firstVal: provider.userProfile.accountNumber.toString(),secondVal: provider.userProfile.phone, ),
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
                        InformationColumn(title: "Profile", value: "Manage your profile",call: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditProfile())),icon: "assets/svg/cog.svg"),
                        InformationColumn(title: "Security", value: "Password, Pin & Others",call: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProfileSecurity())),icon: "assets/svg/shield.svg"),
                        InformationColumn(title: "Get Help", value: "Support & Feedback",call: (){},icon: "assets/svg/confrimTransfer.svg",),
                        GestureDetector(
                          onTap: ()async{
                            setState(() {
                              isLoading = true;
                            });
                            await Login().logoutUser(
                              () async {
                                provider.clearProvider();
                                Provider.of<HistoryProvider>(context,listen: false).resetAll();
                                await Login.removeRecord();
                              },
                              context,
                              () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageTransition(
                                        child: const LoginWidget(),
                                        type: PageTransitionType.fade),
                                    (route) => false);
                                Provider.of<ButtomNavBarProvider>(context,
                                        listen: false)
                                    .changePage(0);
                              });
                              setState(() {
                                isLoading = false;
                              });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            height: 50,
                            margin: const EdgeInsets.only(top: 30,bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1,color: MyFaysalTheme.of(context).primaryColor)
                            ),
                            child: isLoading? ConstrainedBox(constraints: const BoxConstraints(maxHeight: 20,maxWidth: 20),child: CircularProgressIndicator(color: MyFaysalTheme.of(context).primaryColor,)) :Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:8.0),
                                  child: SvgPicture.asset("assets/svg/logout.svg"),
                                ),
                                AutoSizeText("Logout",style: MyFaysalTheme.of(context).text1.override(color: MyFaysalTheme.of(context).primaryColor,fontSize: 18),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
