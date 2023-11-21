
import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/utils/constants.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class FaysalTransaferUserCard extends StatelessWidget {
  final int id;
  final String name;
  final String acctNumber;
  final String? userProfilePics;
  const FaysalTransaferUserCard({super.key,required this.id,required this.acctNumber,required this.name,this.userProfilePics});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: size.width < 327 ? 5 : 15),
      decoration: BoxDecoration(
        color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: size.longestSide * 0.07,
                height: size.longestSide * 0.07,
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                    maxHeight: 70, maxWidth: 70, minHeight: 40, minWidth: 40),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: userProfilePics !=null? DecorationImage(
                        image: NetworkImage("$imageUrl/$userProfilePics"),
                        fit: BoxFit.cover): DecorationImage(
                        image: AssetImage("assets/avatar/avatar${generateAvatar(id.toString())}.png"),
                        fit: BoxFit.cover)),
              ),
              Padding(
                  padding: EdgeInsets.only(left: size.width < 284 ? 7:15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: size.width * 0.56),
                        child: AutoSizeText(name,maxLines: 2,style: MyFaysalTheme.of(context).promtHeaderText.override(fontSize: size.width * 0.038,color: MyFaysalTheme.of(context).primaryText),)),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: size.width * 0.28),
                        child: Text(acctNumber,
                        overflow: TextOverflow.ellipsis,
                        style: MyFaysalTheme.of(context).text1.override(fontSize: size.width * 0.034,lineHeight: 2,color: Colors.white.withOpacity(0.5)),))
                    ],
                  ),
                )
            ],
          ),

          // Container(
          //   height: 20,
          //   alignment: Alignment.center,
          //   width: size.width * 0.2,
          //   margin: const EdgeInsets.only(top: 11),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(5),
          //     color: verified ? MyFaysalTheme.of(context).primaryColor:const Color(0xffFFDF6C)
          //   ),
          //   child: Text(verified ? "Verified":"Pending",style: MyFaysalTheme.of(context).promtHeaderText.override(color: MyFaysalTheme.of(context).secondaryColor,fontSize: size.width * 0.03),),
          // )
        ],
      ),
    );
  }
}