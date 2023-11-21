import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/app_navigator.dart';
import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransferSucess extends StatelessWidget {
  final String amount;
  final String name;
  final bool? isBill;
  final bool? isReciever;
  const TransferSucess({super.key, required this.name, required this.amount,this.isBill,this.isReciever });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 360,
      decoration: BoxDecoration(
          color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AppNavigator()), (route) => false);
                },
                icon: Icon(Icons.close,color: Colors.white.withOpacity(0.4),size: 18,))
            ],
          ),
          ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6),
              child: isBill == null ? isReciever == null ? AutoSizeText.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: getCurrency(),
                                      style: const TextStyle(fontFamily: "Poppins")),
                                  TextSpan(text: "${NumberFormat().format(double.parse(amount))} is on its way to ${name.capitalize(" ")}")
                                ]),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: 19)): AutoSizeText.rich(
                                TextSpan(children: [
                                  TextSpan(text: "${name.contains(" ")? name.capitalize(" "):name.capitalize("")} just sent you "),
                                  TextSpan(
                                      text: getCurrency(),
                                      style: const TextStyle(fontFamily: "Poppins")),
                                  TextSpan(text: "${NumberFormat().format(double.parse(amount))} through QrPayment")
                                ]),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: 19)): isBill == false? AutoSizeText.rich(
                                TextSpan(children: [
                                  const TextSpan(
                                      text: "Your Payment of ",),
                                  TextSpan(
                                      text: getCurrency(),
                                      style: const TextStyle(fontFamily: "Poppins")),
                                  TextSpan(text: "$amount to $name was successful")
                                ]),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: 19)):AutoSizeText.rich(
                                TextSpan(children: [
                                  TextSpan(text: "Your subscription of $name for $amount was successful")
                                ]),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: 19)),
              // AutoSizeText(
              //   "${NumberFormat().format(double.parse(amount))} is on its way to ${name.capitalize(" ")}",
              //   maxLines: 3,
              //   textAlign: TextAlign.center,
              //   style: MyFaysalTheme.of(context)
              //       .splashHeaderText
              //       .override(fontSize: 19),
              // )
              ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(
              "assets/images/success.png",
              width: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          GestureDetector(
            onTap: (){

              Provider.of<ButtomNavBarProvider>(context,listen: false).changePage(0);

               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AppNavigator()), (route) => false);
               },
            child: Container(
              width: double.maxFinite,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: MyFaysalTheme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                "Good to go",
                style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: 17,color: MyFaysalTheme.of(context).secondaryColor),
              ),Container(
                width: 15,
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: MyFaysalTheme.of(context).secondaryColor,
                 shape: BoxShape.circle
                ),
                child: FittedBox(
                  child: Icon(Icons.keyboard_arrow_right_rounded,color: MyFaysalTheme.of(context).primaryColor,),
                ),
              )
                ],
              ),
            ),
          )
        ],
      ),
    );
    // return Scaffold(
    //   body: Container(
    //     child: ,
    //   ),
    // );
  }
}
