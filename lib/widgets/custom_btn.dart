import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback call;
  const CustomButton({super.key,required this.text,required this.call});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: call,
      child: Container(
        width: double.maxFinite,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: 19),
            ),
            Container(
              width: 15,
              height: 15,
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
        ),
      ),
    );
  }
}