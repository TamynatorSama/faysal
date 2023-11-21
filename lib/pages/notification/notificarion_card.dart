import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String amount;
  final String narration;
  final String date;
  final bool credit;
  const TransactionCard({super.key,required this.amount,required this.date,required this.narration,required this.credit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:5.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
                  child: Text(
                    narration,
                    overflow: TextOverflow.ellipsis,
                    style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize:MediaQuery.of(context).size.width * 0.04),
                  ),
                ),
              ),
              Text("${DateFormat.MMMMd ().format(DateTime.parse(date))}, ${DateFormat.jm().format(DateTime.parse(date))}",
          style: MyFaysalTheme.of(context).text1.override(fontSize: 11, color: Colors.white.withOpacity(0.5)),),
            ],
          ),
          AutoSizeText("${credit? '+':'-'} ${getCurrency()}${NumberFormat().format(double.parse(amount))}",
          style: MyFaysalTheme.of(context).promtHeaderText.override(fontFamily: "Poppins", color: credit ? null:MyFaysalTheme.of(context).accentColor,fontSize:MediaQuery.of(context).size.width * 0.05 ),),
        ],
      ),
    );
  }
}
String getCurrency() {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  return format.currencySymbol;
}