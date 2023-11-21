// ignore_for_file: use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:faysal/pages/account/account.dart';
import 'package:faysal/pages/auth/signupflow/security_question.dart';
import 'package:faysal/pages/chart/chart.dart';
import 'package:faysal/pages/home/home.dart';
import 'package:faysal/pages/notification/notification.dart';
import 'package:faysal/pages/scan/scan.dart';
// import 'package:faysal/provider/bills_provider.dart';
import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/provider/history_provider.dart';
import 'package:faysal/provider/profile_provider.dart';
// import 'package:faysal/provider/recharge_provider.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/dynamic_links.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator>{

  late ButtomNavBarProvider bottomNavProvider;
  late FToast ftoast;

  @override
  void initState() {
    ftoast = FToast();

    AwesomeNotifications().isNotificationAllowed().then((value) => {
      if(!value){
        AwesomeNotifications().requestPermissionToSendNotifications()
      }
    });
    DynamicLinkHandler().dynamicCode ="";
    DynamicLinkHandler().startedFromLogin = false;



    ftoast.init(context);
    bottomNavProvider = Provider.of(context,listen: false);
    getData();
    super.initState();
  }

  getData()async{
    
    Provider.of<ProfileProvider>(context, listen: false).initializeProfile();
    await Provider.of<ProfileProvider>(context, listen: false).populateProfile(ftoast, ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SetSequrityQuestion())));
    
    setState(() {
      
    });
    getAdditional();
  }

  getAdditional(){
    Provider.of<ProfileProvider>(context, listen: false).getSystemSettings();
    Provider.of<HistoryProvider>(context, listen: false)
        .getNotification();
    Provider.of<HistoryProvider>(context, listen: false)
        .populateNotifications();
        Provider.of<HistoryProvider>(context, listen: false)
        .populateHistory();
    Provider.of<SavingsProvider>(context, listen: false).getFrequency();
    Provider.of<SavingsProvider>(context, listen: false).getDisbursement();
  }


  List<Widget> pages = const[
    Home(),
    Chart(),
    ScanToPay(),
    NotificationWidget(),
    Account()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
      body: RefreshIndicator(
        color: MyFaysalTheme.of(context).accentColor,
        backgroundColor: MyFaysalTheme.of(context).secondaryColor,
        onRefresh: ()async{
          await Provider.of<ProfileProvider>(context, listen: false).populateProfile(ftoast, ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SetSequrityQuestion())));
          
          await Provider.of<HistoryProvider>(context, listen: false)
        .populateNotifications();
        },
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
          child: WidgetBackgorund(
            home: true,
            child: Stack(
              children: [
                pages[Provider.of<ButtomNavBarProvider>(context).pageIndex],
                ButtomNavBar(page: bottomNavProvider.pageIndex, )
              ],
            ),
          ),
        ),
      ),
    );
  }
}