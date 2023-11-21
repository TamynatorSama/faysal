

import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SavingsBackground extends StatelessWidget {
  final Widget child;
  const SavingsBackground({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          IntrinsicWidth(
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  SvgPicture.asset("assets/svg/background-left.svg",color: Colors.grey,width: MediaQuery.of(context).size.width * 0.6,),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [MyFaysalTheme.of(context).secondaryColor.withOpacity(0.93),MyFaysalTheme.of(context).secondaryColor.withOpacity(0.4)],
                        // colors: [Colors.red,Colors.black],
                        stops: const [0.1,0.6],
                        begin: Alignment.topCenter,
                      )
                    ),
                    ),
                    
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: IntrinsicWidth(
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  SvgPicture.asset("assets/svg/background-right.svg",color: Colors.grey,width: MediaQuery.of(context).size.width * 0.6,),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [MyFaysalTheme.of(context).secondaryColor.withOpacity(0.9),MyFaysalTheme.of(context).secondaryColor.withOpacity(0.4)],
                        // colors: [Colors.red,Colors.black],
                        stops: const [0.7,1],
                        begin: Alignment.topRight,
                      )
                    ),
                    ),
                    
                ],
              ),
            ),
          ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: IntrinsicWidth(
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  SvgPicture.asset("assets/svg/background-left.svg",color: Colors.grey,width: MediaQuery.of(context).size.width * 0.6,),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [MyFaysalTheme.of(context).secondaryColor.withOpacity(0.9),MyFaysalTheme.of(context).secondaryColor.withOpacity(0.4)],
                        // colors: [Colors.red,Colors.black],
                        stops: const [0.7,1],
                        begin: Alignment.topRight,
                      )
                    ),
                    ),
                    
                ],
              ),
            ),
          ),
          ),
          
          child
        ]
    );
  }
}