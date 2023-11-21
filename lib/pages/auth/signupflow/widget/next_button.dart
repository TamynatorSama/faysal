import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final String text;
  final VoidCallback call;
  final bool rightPlacement;
  final bool? isLoading;
  const NextButton({super.key,required this.text,required this.call,required this.rightPlacement,this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: call,
      child: Container(
        width: double.maxFinite,
        alignment: Alignment.center,
        height: 45,
        constraints: const BoxConstraints(maxWidth: 200),
        decoration: BoxDecoration(
          color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(8)
        ),
        child: isLoading == null ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !rightPlacement? const Offstage():Container(
              width: 13,
              height: 13,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: MyFaysalTheme.of(context).primaryColor,
               shape: BoxShape.circle
              ),
              child: const FittedBox(
                child: Icon(Icons.keyboard_arrow_left_rounded),
              ),
            )
            ,
            Text(
              text,
              style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: 14),
            ),
            rightPlacement? const Offstage():Container(
              width: 13,
              height: 13,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: MyFaysalTheme.of(context).primaryColor,
               shape: BoxShape.circle
              ),
              child: const FittedBox(
                child: Icon(Icons.keyboard_arrow_right_rounded),
              ),
            )
          ],
        ) : ConstrainedBox(constraints: const BoxConstraints(maxHeight: 20,maxWidth: 20),child: CircularProgressIndicator(color: MyFaysalTheme.of(context).primaryColor,),),
      ),
    );
  }
}