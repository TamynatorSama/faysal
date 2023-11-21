

import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class LoginBtn extends StatelessWidget {
  final String text;
  final VoidCallback call;
  final bool outline;
  const LoginBtn({super.key,required this.text,required this.call,required this.outline});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),

      child: GestureDetector(
        onTap: call,
        child: Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height < 510 ? 45 : 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: outline? null:MyFaysalTheme.of(context).secondaryColor,
            borderRadius: BorderRadius.circular(8),
            border: !outline? null:Border.all(color: MyFaysalTheme.of(context).primaryColor,width: 1)
          ),
          child: Text(
            text,
            style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: 16,color: outline ? MyFaysalTheme.of(context).primaryColor:null ),
          ),
        ),
      ),
    );
  }
}