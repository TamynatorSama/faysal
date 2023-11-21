import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_success_background.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
class SuccessfulSavingsCreation extends StatelessWidget {
  final String header;
  final String message; 
  final VoidCallback? call;
  const SuccessfulSavingsCreation({super.key, required this.header,required this.message, this.call });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  WillPopScope(
      onWillPop: ()async{
        call ?? Navigator.popUntil(context, ModalRoute.withName("/ajo"));
        return true;
      },
      child: Scaffold(
        backgroundColor: MyFaysalTheme.of(context).secondaryColor,
        body: SavingsBackground(
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
              AutoSizeText(header,maxLines: 1,style: MyFaysalTheme.of(context).promtHeaderText,),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width * 0.6),
                  child: AutoSizeText(message,textAlign: TextAlign.center, maxLines: 4,style: MyFaysalTheme.of(context).text1,)),
              ),
              Padding(
                padding: const EdgeInsets.all(30), 
                child: IconButton(
                  onPressed:call ??()=>  Navigator.popUntil(context, ModalRoute.withName("/ajo")),                    
                    icon: const Icon(Icons.close,color: Colors.white,size: 18,),
                ),
              )
              ],
            ),
          )
          ),
      ),
    );
  }
}