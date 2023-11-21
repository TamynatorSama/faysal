import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/app_navigator.dart';
import 'package:faysal/pages/transfer/widget/transfer_confirmation_btn.dart';
import 'package:faysal/provider/trasfer_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ConfirmTransfer extends StatelessWidget {
  const ConfirmTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      height: 390,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: IconButton(
                    onPressed: ()=>Navigator.of(context).pop(false),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white.withOpacity(0.4),
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6),
              child: AutoSizeText(
                "Confirm Transfer",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: 20),
              )),
          ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.58),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: AutoSizeText.rich(
                  TextSpan(children: [
                    const TextSpan(text: "You are about to send "),
                    TextSpan(
                        text: getCurrency(),
                        style: const TextStyle(fontFamily: "Poppins")),
                      TextSpan(text: NumberFormat().format(Provider.of<TransferProvider>(context,listen: false).amount), style: MyFaysalTheme.of(context).text1.override(
                      fontSize: 15, color: Colors.white.withOpacity(0.5),fontWeight: FontWeight.w700)),
                    const TextSpan(text: " to "),
                    TextSpan(text: Provider.of<TransferProvider>(context,listen: false).transferFaysal == null ?Provider.of<TransferProvider>(context,listen: false).userBankName :Provider.of<TransferProvider>(context,listen: false).transferFaysal!.name, style: MyFaysalTheme.of(context).text1.override(
                      fontSize: 15, color: Colors.white.withOpacity(0.5),fontWeight: FontWeight.w700)),
                  ]),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: MyFaysalTheme.of(context).text1.override(
                      fontSize: 15, color: Colors.white.withOpacity(0.5)),
                ),
              )),
          Container(
            width: size.width * 0.16,
            height: size.width * 0.16,
            margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
            padding: EdgeInsets.all(size.width * 0.04),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyFaysalTheme.of(context).primaryColor),
            child: SvgPicture.asset(
              'assets/svg/confrimTransfer.svg',
            ),
          ),
          Column(
            children: [
              TransferConfirmationButton(call: () {
                Navigator.of(context).pop(true);
              }, text: "Proceed"),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.026),
                child: TransferConfirmationButton(call: () {
                  Navigator.pushAndRemoveUntil(context, PageTransition(child:const AppNavigator(),type: PageTransitionType.rightToLeftPop ), (route) => false);
                }, text: "Cancel"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
