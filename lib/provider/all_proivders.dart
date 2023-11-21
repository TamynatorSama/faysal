import 'package:faysal/provider/bills_provider.dart';
import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/provider/chart_provider.dart';
import 'package:faysal/provider/history_provider.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/qr_scan_provider.dart';
import 'package:faysal/provider/recharge_provider.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/provider/sign_up_provider.dart';
import 'package:faysal/provider/trasfer_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context)=> ButtomNavBarProvider()),
  ChangeNotifierProvider(create: (context)=> StatisticProvider()),
  ChangeNotifierProvider(create: (context)=> SavingsProvider()),
  ChangeNotifierProvider(create: (context)=> ProfileProvider()),
  ChangeNotifierProvider(create: (context)=> SignUpProvider()),
  ChangeNotifierProvider(create: (context)=> RechargeProvider()),
  ChangeNotifierProvider(create: (context)=> HistoryProvider()),
  ChangeNotifierProvider(create: (context)=> TransferProvider()),
  ChangeNotifierProvider(create: (context)=> BillProivder()),
  ChangeNotifierProvider(create: (context)=> QrScanProvider()),
];