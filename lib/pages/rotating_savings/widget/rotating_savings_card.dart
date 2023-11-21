import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class RotatingSavingsCard extends StatelessWidget {
  final Color bgColor;
  final String name;
  final DateTime start;
  final DateTime createdAt;
  final int ajoTypeId;
  const RotatingSavingsCard({super.key, required this.bgColor, required this.name, required this.start, required this.createdAt,required this.ajoTypeId });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Opacity(
                  opacity: 0.5,
                  child: SvgPicture.asset("assets/svg/smallbg.svg"))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: size.width * 0.45),
                              child: Text(name,
                              overflow: TextOverflow.ellipsis,
                              style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: size.width * 0.06, color: MyFaysalTheme.of(context).secondaryColor ),)),
                            Text("${ajoTypeId ==1 ?'Community':'Solo'} Ajo",style: MyFaysalTheme.of(context).text1.override(fontSize: size.width * 0.03, color: MyFaysalTheme.of(context).secondaryColor ),)
                          ],
                        ),
                        Container(
                                  width: size.width * 0.19,
                                  height: size.width * 0.19,
                                  padding: EdgeInsets.all(size.width * 0.05),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MyFaysalTheme.of(context).scaffolbackgeroundColor),
                                  child: SvgPicture.asset("assets/svg/${ajoTypeId ==1 ? 'multiuser':'user'}.svg"),
                                  
                                ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Column(
                        children: [
                          LinearProgressIndicator(
                            value: start.difference(DateTime.now()).inDays<0 ? 1 : (start.difference(DateTime.now()).inDays/start.difference(createdAt).inDays).isNaN? (start.difference(DateTime.now()).inHours/start.difference(createdAt).inHours).isNaN? 1: (1- (start.difference(DateTime.now()).inHours/start.difference(createdAt).inHours)) < 0.1 ? 1 : 1- (start.difference(DateTime.now()).inHours/start.difference(createdAt).inHours): 1 - (start.difference(DateTime.now()).inDays/start.difference(createdAt).inDays),
                            minHeight: 7.5,
                            color: MyFaysalTheme.of(context).scaffolbackgeroundColor,
                            backgroundColor: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat.yMMMMd().format(createdAt),style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: 12,color: MyFaysalTheme.of(context).secondaryColor),),
                                Text(DateFormat.yMMMMd().format(start) ,style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: 12,color: MyFaysalTheme.of(context).secondaryColor),)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  
                  ],
                ),
              ),
            ],
          ),
    );
  }

  
}
