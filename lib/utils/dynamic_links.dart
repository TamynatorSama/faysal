import 'package:faysal/main.dart';
import 'package:faysal/pages/rotating_savings/join_savings/single_join_view.dart';
import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkHandler {
  static String ajoCode = "";
  static bool fromInit =false;

  get dynamicLinkCode => ajoCode;
  get fromLogin => fromInit;

  set dynamicCode(String code) {
    ajoCode = code;
  }
  set startedFromLogin(bool code) {
    fromInit = code;
  }

  Future<String> createLinkAjo(String ajoCode) async {
    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
        uriPrefix: "https://myfaysal.page.link",
        link: Uri.parse("https://com.sprintcoy.myfaysal?ajoId=$ajoCode"),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: "Faysal Rotaional Savings",
            description:
                "Journey the road to financial freedom by joining this rotaional savings community on faysal",
            imageUrl: Uri.parse(
                "https://firebasestorage.googleapis.com/v0/b/sprint-financials-ltd.appspot.com/o/try.png?alt=media&token=50464363-61f4-4419-911f-bcd0804c7e26")),
        androidParameters:
            const AndroidParameters(packageName: "com.sprintcoy.myfaysal"),
        iosParameters: const IOSParameters(bundleId: "com.sprintcoy.myfaysal"));
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    // print();
    return dynamicLink.shortUrl.toString();

    //     final dynamicLink =
    // await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    // return dynamicLink.shortUrl.toString();
  }

  void initializeDynamicLink() async {
    await Future.delayed(const Duration(seconds: 3));
    final instanceOfDynamic =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (instanceOfDynamic != null) {
      final Uri uri = instanceOfDynamic.link;

      // print(uri.queryParameters);
      dynamicCode = uri.queryParameters["ajoId"].toString();
      navigatorToJoinScreen();
    }

    FirebaseDynamicLinks.instance.onLink.listen((event) {
      if (event.link.queryParameters.isNotEmpty &&
          event.link.queryParameters.keys.contains("ajoId")) {
        // print(event.link.queryParameters);
        dynamicCode = event.link.queryParameters["ajoId"].toString();
        navigatorToJoinScreen();
      }
    });
  }

  navigatorToJoinScreen() {
    if(Login().loggedIn){
      Navigator.push(
        MyApp.navigationKey.currentContext!,
        MaterialPageRoute(
            builder: (context) => SingleJoinView(
                  ajoCode: ajoCode,
                )));
    }
  }
}
