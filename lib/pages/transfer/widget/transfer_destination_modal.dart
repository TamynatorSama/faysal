

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/transfer/transfer_bank.dart';
import 'package:faysal/pages/transfer/transfer_faysal.dart';
import 'package:faysal/pages/transfer/widget/destination_btn.dart';
// import 'package:faysal/provider/trasfer_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

class TransferDestinationmodal extends StatelessWidget {
  final double amount;
  const TransferDestinationmodal({super.key,required this.amount});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      alignment: Alignment.center,
      height: 250,
      decoration: BoxDecoration(
          color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.3,
                height: 3,
                margin: const EdgeInsets.symmetric(vertical: 22),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white.withOpacity(0.5)),
              )
            ],
          ),
          Text("Transfer Destination",
              style: MyFaysalTheme.of(context)
                  .splashHeaderText
                  .override(fontSize: 22)),
          AutoSizeText.rich(
                          TextSpan(children: [
                            const TextSpan(text: "Send "),
                            TextSpan(
                                text: getCurrency(),
                                style: const TextStyle(fontFamily: "Poppins")),
                            TextSpan(text: "${NumberFormat().format(amount)} to?")
                          ]),
                          style: MyFaysalTheme.of(context).text1.override(
              lineHeight: 1.4,
                color: MyFaysalTheme.of(context).primaryText.withOpacity(0.5)),),
                      
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DestinationButton(title: "MyFaysal",icon: "assets/svg/faysalSmall.svg",call:
                 ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const TransferFaysal()))
            ),
              Padding(
                padding: const EdgeInsets.only(left:13.0),
                child: DestinationButton(title: "Other Bank ",icon: "assets/svg/moneyBag.svg",call: (){ 
                  // if(!Provider.of<TransferProvider>(context, listen: false).ableToDoExternalTransfer){
                  //     showToast(context, "External Transfer is unavailable at the moment");
                  //     return;
                  // }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const TransferBank()));}),
              ),
            ],
          )
        ],
      ),
    );
  }
}

