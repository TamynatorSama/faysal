import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class TransferConfirmationButton extends StatelessWidget {
  final String text;
  final VoidCallback call;
  const TransferConfirmationButton({super.key, required this.call,required this.text });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: call,
      child: Container(
        height: 50,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: MyFaysalTheme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Text(text,style: MyFaysalTheme.of(context).text1.override(color: MyFaysalTheme.of(context).primaryColor,fontSize: 16),),
      ),
    );
  }
}