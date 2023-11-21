import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class SavingsButton extends StatelessWidget {
  final String text;
  final VoidCallback call;
  final bool? isLoading;
  const SavingsButton({super.key,required this.text, required this.call, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: call,
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          border: Border.all(width: 1,color: MyFaysalTheme.of(context).primaryColor)
        ),
        child: isLoading ==null ?Text(text,style: MyFaysalTheme.of(context).promtHeaderText.override(fontSize: 16) ,): ConstrainedBox(constraints: const BoxConstraints(maxHeight: 20,maxWidth: 20),child: CircularProgressIndicator(color: MyFaysalTheme.of(context).primaryColor,),)
      ),
    );
  }
}