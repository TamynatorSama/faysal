import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ButtomNavBar extends StatefulWidget {
  final int page;
  const ButtomNavBar({super.key,required this.page});

  @override
  State<ButtomNavBar> createState() => _ButtomNavBarState();
}

class _ButtomNavBarState extends State<ButtomNavBar> {

  late ButtomNavBarProvider bottomNavProvider;

  @override
  void initState() {
    bottomNavProvider = Provider.of(context,listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        width: double.maxFinite,
        height: 70,
        margin: const EdgeInsets.only(bottom: 10),
        color: MyFaysalTheme.of(context).scaffolbackgeroundColor,
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          runAlignment: WrapAlignment.center,
          children: [
             InkWell(
              onTap: ()=> bottomNavProvider.changePage(0),
              child: SizedBox(
                height: 70,
                child: SvgPicture.asset("assets/svg/bottom_home.svg",width: 20,
                color: widget.page == 0? MyFaysalTheme.of(context).primaryColor:null,
                ))),
             InkWell(
              onTap: ()=> bottomNavProvider.changePage(1),
              child: SizedBox(
                height: 70,
                child: SvgPicture.asset("assets/svg/chart.svg",width: 20,color: widget.page == 1? MyFaysalTheme.of(context).primaryColor:null,))),
              InkWell(
              onTap: ()=> bottomNavProvider.changePage(2),
              child: Container(
                height: 70,
                width: 50,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03>10 ? 10 :MediaQuery.of(context).size.width * 0.03 ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyFaysalTheme.of(context).secondaryColor
                ),
                
                child: SvgPicture.asset("assets/svg/Scan.svg",width: 20,color: widget.page == 2? MyFaysalTheme.of(context).primaryColor:null,))),
             InkWell(
              onTap: ()=> bottomNavProvider.changePage(3),
              child: SizedBox(
                height: 70,
                child: SvgPicture.asset("assets/svg/notification.svg",width: 20,color: widget.page == 3? MyFaysalTheme.of(context).primaryColor:null,))),
             InkWell(
              onTap: ()=> bottomNavProvider.changePage(4),
              child: SizedBox(
                height: 70,
                child: SvgPicture.asset("assets/svg/user.svg",width: 20,height: 23,color: widget.page == 4? MyFaysalTheme.of(context).primaryColor:null,))),
            
          ],
        ),
      ),
    );
  }
}