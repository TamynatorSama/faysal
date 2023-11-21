import 'package:cached_network_image/cached_network_image.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/utils/constants.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationCard extends StatelessWidget {
  final String title;
  final String value;
  final bool verified;
  const VerificationCard({super.key, required this.title, required this.value, required this.verified});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: size.width < 327 ? 15 : 25),
      decoration: BoxDecoration(
        color:
            MyFaysalTheme.of(context).scaffolbackgeroundColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: size.longestSide * 0.08,
                height: size.longestSide * 0.08,
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                    maxHeight: 70, maxWidth: 70, minHeight: 40, minWidth: 40),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: Provider.of<ProfileProvider>(context).userProfile.avatar.isEmpty? DecorationImage(
                                  image: AssetImage("assets/avatar/avatar${generateAvatar(Provider.of<ProfileProvider>(context).userProfile.id.toString())}.png")):DecorationImage(
                                  image: CachedNetworkImageProvider("$imageUrl/${Provider.of<ProfileProvider>(context).userProfile.avatar}",cacheKey: Provider.of<ProfileProvider>(context).cacheKey,),fit: BoxFit.cover )),
              ),
              Padding(
                  padding: EdgeInsets.only(left: size.width < 284 ? 7:15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,style: MyFaysalTheme.of(context).promtHeaderText.override(fontSize: size.width * 0.039,color: MyFaysalTheme.of(context).primaryText),),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: size.width * 0.28),
                        child: Text(value,
                        overflow: TextOverflow.ellipsis,
                        style: MyFaysalTheme.of(context).text1.override(fontSize: size.width * 0.034,lineHeight: 2,color: Colors.white.withOpacity(0.5)),))
                    ],
                  ),
                )
            ],
          ),

          Container(
            height: 20,
            alignment: Alignment.center,
            width: size.width * 0.2,
            margin: const EdgeInsets.only(top: 11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: verified ? MyFaysalTheme.of(context).primaryColor:const Color(0xffFFDF6C)
            ),
            child: Text(verified ? "Verified":"Pending",style: MyFaysalTheme.of(context).promtHeaderText.override(color: MyFaysalTheme.of(context).secondaryColor,fontSize: size.width * 0.03),),
          )
        ],
      ),
    );
  }
}
