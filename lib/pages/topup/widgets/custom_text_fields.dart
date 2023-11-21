import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/provider/trasfer_provider.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool suffix;
  final TextEditingController controller;
  final List<TextInputFormatter>? format;
  final TextInputType? inputType;
  final bool? functionChange;
  const CustomTextField(
      {super.key,
      required this.label,
      required this.suffix,
      this.format,
      required this.controller,
      this.inputType,
      this.functionChange});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: Colors.white,
          controller: widget.controller,
          keyboardType: widget.inputType ?? TextInputType.number,
          style: MyFaysalTheme.of(context).textFieldText,
          inputFormatters: widget.format ??
              [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
          validator: (value) {
            if (value!.isEmpty) {
              return "Field is required";
            }

            return null;
          },
          onChanged: (value) {
            if (widget.functionChange != null && !widget.functionChange!) {
              Provider.of<TransferProvider>(context, listen: false)
                  .userBankName = null;
            }
            if (Provider.of<TransferProvider>(context, listen: false)
                        .transferFaysal !=
                    null &&
                widget.functionChange != null) {
              if (widget.functionChange!) {
                Provider.of<TransferProvider>(context, listen: false)
                    .transferFaysal = null;
              }
            }
          },
          decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: MyFaysalTheme.of(context).promtHeaderText.override(
                  color:
                      MyFaysalTheme.of(context).primaryColor.withOpacity(0.2),
                  fontSize: 15),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: InkWell(
                  onTap: () async {
                    if (!widget.suffix) return;
                    ButtomNavBarProvider().setTimeout = true;
                    if (!await FlutterContactPicker.hasPermission()) {
                      final granted =
                          await FlutterContactPicker.requestPermission();
                      await Future.delayed(const Duration(seconds: 1), () {
                        ButtomNavBarProvider().setTimeout = false;
                      });
                      if (!granted) return;
                    }
                    try{
                      final PhoneContact contact =
                        await FlutterContactPicker.pickPhoneContact();
                    if (contact.phoneNumber!.number == null) {
                      
                      await Future.delayed(const Duration(seconds: 1), () {
                        ButtomNavBarProvider().setTimeout = false;
                      });
                      return;
                    }
                    widget.controller.text = contact.phoneNumber!.number!;
                    await Future.delayed(const Duration(seconds: 1), () {
                      ButtomNavBarProvider().setTimeout = false;
                    });
                    }
                    catch(e){
                      await Future.delayed(const Duration(seconds: 1), () {
                        ButtomNavBarProvider().setTimeout = false;
                      });
                    }
                    
                  },
                  child: Opacity(
                      opacity: widget.suffix ? 1 : 0,
                      child: SvgPicture.asset(
                        "assets/svg/contact.svg",
                        color: Colors.white,
                        width: 16,
                      )),
                ),
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: const Color(0xff123F33)),
        ),
      ),
    );
  }
}
