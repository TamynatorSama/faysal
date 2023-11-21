import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/app_navigator.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class TopUpSuccessful extends StatelessWidget {
  final String number;
  const TopUpSuccessful({super.key, required this.number });

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
              child: AutoSizeText(
                "You’ve successfully purchased data for $number",
                maxLines: 3,
                textAlign: TextAlign.center,
                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: 19),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(
              "assets/images/success.png",
              width: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          GestureDetector(
            onTap: () =>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AppNavigator()), (route) => false),
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
