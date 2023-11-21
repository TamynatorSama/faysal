import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_success_background.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
class SuccessfulModification extends StatelessWidget {
  final String message;
  const SuccessfulModification({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: MyFaysalTheme.of(context).secondaryColor,
      body: SavingsBackground(
        // isSavings: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(),
              Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                "assets/images/success.png",
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width * 0.6),
              child: AutoSizeText(message,textAlign: TextAlign.center,maxLines: 3,style: MyFaysalTheme.of(context).promtHeaderText,)),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(30), 
                child: IconButton(
                  onPressed: ()=> Navigator.pop(context),
                  icon: const Icon(Icons.close,color: Colors.white,size: 18,)),
                ),
            )
            ],
          ),
        )
        ),
    );
  }
}