// import 'dart:async';

// import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class BoxPinWidget extends StatefulWidget {
  final int pinLength;
  final TextEditingController controller;
  final double? parentWidth;
  final TextInputType? inputType;
  final bool? obscureText;
  final double? constrainedWidth;
  const BoxPinWidget({
    super.key,
    required this.pinLength,
    required this.controller,
    this.parentWidth,
    this.inputType,
    this.obscureText,
    this.constrainedWidth
  });

  @override
  State<BoxPinWidget> createState() => _BoxPinWidgetState();
}

class _BoxPinWidgetState extends State<BoxPinWidget>
    with WidgetsBindingObserver {
  // List<String> pin = [];

  // late FocusScopeNode focusText;
  // bool coolClick = false;

  @override
  void initState() {
    // focusText = FocusScopeNode();
    // focusText.requestFocus();
    // populatePin("");
    // widget.controller.addListener(() {
    //   populatePin(widget.controller.text);
    // });
    super.initState();
  }


  // populatePin(String text) {
    
  //   if (widget.pinLength - text.length < 0) return;
  //   if(widget.obscureText != null && widget.obscureText == true){
  //     pin = text.split("").map((e) => "#").toList();
  //   }
  //   else{
  //     pin = text.split("");
  //   }
    
  //   for (var i = 0; i < (widget.pinLength - text.length); i++) {
  //     pin.add("");
  //   }
  //   setState(() {});
  //   // widget.controller.text =  pin.reduce((value, element) => value+element);
  // }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.constrainedWidth ?? 220),
      child: Pinput(
        controller: widget.controller,
        length: widget.pinLength,
        obscureText: widget.obscureText ?? true,
        autofocus: true,
        keyboardType: widget.inputType?? TextInputType.number,
        obscuringCharacter: "#",
        defaultPinTheme: PinTheme(
          width: !(size.height < 590)? widget.parentWidth == null
                  ? (size.width / widget.pinLength)
                  : widget.parentWidth! / widget.pinLength
               :size.shortestSide * 0.12,
                height: !(size.height < 590)? 50 :size.shortestSide * 0.13,
          decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey.withOpacity(0.4)),
          textStyle:
                      MyFaysalTheme.of(context).text1.override(fontSize: 24),),
      ),
    );
    // return FittedBox(
    //   child: Wrap(
    //     spacing: 7,
    //     children: List.generate(widget.pinLength, (index) {
    //       return
          // if(size.height < 590){
            // return Container(
            //   alignment: Alignment.center,
            //   constraints: const BoxConstraints(maxWidth: 45,maxHeight: 45),
            //   width: size.shortestSide * 0.13,
            //   height: size.shortestSide * 0.13,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(7),
              //     color: Colors.grey.withOpacity(0.4)),
            //   child: AutoSizeText(
            //     pin[index].toString(),
            //     maxLines: 1,
                // style:
                //     MyFaysalTheme.of(context).text1.override(fontSize: 24),
            //   ),
            // );
          // }
          // else{
          // return Container(
          //   alignment: Alignment.center,
          //   constraints: const BoxConstraints(maxWidth: 45),
          //   width: widget.parentWidth == null
          //       ? (size.width / widget.pinLength)
          //       : widget.parentWidth! / widget.pinLength,
          //   height: 50,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(7),
          //       color: Colors.grey.withOpacity(0.4)),
          //   child: AutoSizeText(
          //     pin[index].toString(),
          //     maxLines: 1,
          //     style:
          //         MyFaysalTheme.of(context).text1.override(fontSize: 24),
          //   ),
          // );
          // }
    //     }),
    //   ),
    // );
  }
}
