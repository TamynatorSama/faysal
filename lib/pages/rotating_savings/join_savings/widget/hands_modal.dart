import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_btn.dart';
import 'package:faysal/pages/topup/widgets/custom_text_fields.dart';
import 'package:faysal/utils/formatter.dart';

import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NumberOfHandsDialog extends StatelessWidget {
  final int maxHands;
  const NumberOfHandsDialog({super.key, required this.maxHands});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.maxFinite,
      height: 250,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Number of Hands",
            maxLines: 2,
            style: MyFaysalTheme.of(context)
                .promtHeaderText
                .override(fontSize: size.width * 0.05, color: Colors.white),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CustomTextField(
                  label: "Maximum number of hands: $maxHands",
                  inputType: TextInputType.text,
                  suffix: false,
                  format: [
                     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              HandsFormatter(maxNumber: int.parse(maxHands.toString()))
                  ],
                  controller: controller),
            ),
          ),
          SavingsButton(
              text: "Confirm",
              call: () {
                if (formKey.currentState == null ||
                    !formKey.currentState!.validate()) {
                  return;
                }
                Navigator.pop(context,controller.text);
              }),
        ],
      ),
    );
  }
}
