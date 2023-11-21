import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class TopUpButton extends StatelessWidget {
  final String text;
  final VoidCallback call;
  final bool reuse;
  final Color? color;
  final bool? isLoading;
  final double? bottom;
  const TopUpButton({super.key, required this.call,required this.text,required this.reuse,this.isLoading, this.color, this.bottom });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: call,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: EdgeInsets.only(top: 15,bottom:  MediaQuery.of(context).size.height < 500 ? MediaQuery.of(context).size.height * 0.01 : bottom ?? 40),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: color ?? MyFaysalTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: isLoading == null ?  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,style: MyFaysalTheme.of(context).promtHeaderText.override(fontSize: 16,color: color == null ?null: MyFaysalTheme.of(context).secondaryColor),),
            !reuse? const Offstage():Container(
              width: 13,
              height: 13,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: color == null ? MyFaysalTheme.of(context).primaryColor:MyFaysalTheme.of(context).secondaryColor,
               shape: BoxShape.circle
              ),
              child: FittedBox(
                child: Icon(Icons.keyboard_arrow_right_rounded,color: color == null ?null: MyFaysalTheme.of(context).primaryColor),
              ),
            )
          ],
        ) : ConstrainedBox(constraints: const BoxConstraints(maxHeight: 20,maxWidth: 20),child: CircularProgressIndicator(color: color == null ? MyFaysalTheme.of(context).primaryColor:MyFaysalTheme.of(context).secondaryColor,),),
      ),
    );
  }
}