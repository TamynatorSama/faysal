import 'package:faysal/pages/topup/airtime/airtime.dart';
import 'package:faysal/pages/topup/data/data.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class TopupDialog extends StatelessWidget {
  const TopupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
          color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Topup",
            style: MyFaysalTheme.of(context).splashHeaderText,
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0,bottom: 25),
            child: Divider(
              
              color: MyFaysalTheme.of(context).primaryColor,
            ),
          ),
          FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const Airtime())),
                  child: Row(
                    children: [
                      Container(
                          width: size.longestSide * 0.062,
                          height: size.longestSide * 0.062,
                          constraints: const BoxConstraints(
                              maxHeight: 46,
                              maxWidth: 46,
                              minHeight: 30,
                              minWidth: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: MyFaysalTheme.of(context).primaryColor),
                          child: Icon(Icons.phone_iphone,
                              color: MyFaysalTheme.of(context).secondaryColor,
                              size: size.longestSide * 0.04 > 32
                                  ? 26
                                  : size.longestSide * 0.04 < 24
                                      ? 23
                                      : size.longestSide * 0.04)),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Text(
                          "Airtime",
                          style: MyFaysalTheme.of(context)
                              .splashHeaderText
                              .override(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const Data())),
                  child: Row(
                      children: [
                        Container(
                            width: size.longestSide * 0.062,
                            height: size.longestSide * 0.062,
                            constraints: const BoxConstraints(
                                maxHeight: 46,
                                maxWidth: 46,
                                minHeight: 30,
                                minWidth: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: MyFaysalTheme.of(context).primaryColor),
                            child: Icon(Icons.wifi_tethering ,
                                color: MyFaysalTheme.of(context).secondaryColor,
                                size: size.longestSide * 0.04 > 32
                                    ? 26
                                    : size.longestSide * 0.04 < 24
                                        ? 23
                                        : size.longestSide * 0.04)),
                        Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: Text(
                            "Data Bundle",
                            style: MyFaysalTheme.of(context)
                                .splashHeaderText
                                .override(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                ),
              ),
              
              ],
            ),
          )
        ],
      ),
    );
  }
}
