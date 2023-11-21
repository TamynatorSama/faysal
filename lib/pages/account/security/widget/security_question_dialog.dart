import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_btn.dart';
import 'package:faysal/pages/topup/widgets/custom_text_fields.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecurityQuestionDialog extends StatelessWidget {
  const SecurityQuestionDialog({super.key});

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
            "${Provider.of<ProfileProvider>(context).userProfile.question!}?",
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
                  label: "Answer",
                  inputType: TextInputType.text,
                  suffix: false,
                  format: const [],
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
