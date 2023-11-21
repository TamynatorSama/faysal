

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final String header;
  final bool? hide;
  final VoidCallback? customCall;
  final EdgeInsetsGeometry? customPadding;
  const CustomNavBar({super.key,required this.header,this.customPadding, this.hide,this.customCall});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: Padding(
        padding: customPadding ?? EdgeInsets.only(top:  MediaQuery.of(context).padding.top < 30 ? MediaQuery.of(context).size.height < 600 ? 10: MediaQuery.of(context).size.height * 0.05 :MediaQuery.of(context).padding.top),
        child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    hide != null? const Offstage():Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: IconButton(
                        splashColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
                        hoverColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
                        highlightColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
                        // splashColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
                        onPressed: customCall ?? ()=>Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: MediaQuery.of(context).size.width * 0.045,)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                          child: AutoSizeText(header,style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: MediaQuery.of(context).size.width * 0.058),))
                      ],
                    ),
                  ],
                ),
      ),
    );
  
  }
}