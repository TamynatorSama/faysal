// ignore_for_file: use_build_context_synchronously


import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/topup/widgets/topup_button.dart';
import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/services/http_class.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/box_pin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

class EntryPinConfirmationScreen extends StatefulWidget {
  const EntryPinConfirmationScreen({super.key});

  @override
  State<EntryPinConfirmationScreen> createState() => _EntryPinConfirmationScreenState();
}

class _EntryPinConfirmationScreenState extends State<EntryPinConfirmationScreen> {

  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    ButtomNavBarProvider().hasNavigatedToPage = true;

    var keyboardVisibilityController = KeyboardVisibilityController();

  // Subscribe
  keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
    if(!visible){
      FocusScope.of(context).unfocus();
    }
  });
    super.initState();
  }


   
  

  @override
  void dispose(){
    keyboardSubscription.cancel();
    // controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1, 1.05)),
        child: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(minHeight: 300),
          height: size.height * 0.4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
              color: MyFaysalTheme.of(context).secondaryColor,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              AutoSizeText("Welcome Back ${Provider.of<ProfileProvider>(context).userProfile.name.split(" ").first.capitalize()}",maxLines: 1,style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: size.width * 0.05),),
              AutoSizeText("Please enter your 4 digit transaction pin to continue",textAlign: TextAlign.center,maxLines: 2,style: MyFaysalTheme.of(context).promtHeaderText.override(fontSize: size.width * 0.03,color: Colors.white.withOpacity(0.5)),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:20.0),
                child: BoxPinWidget(controller: controller,pinLength: 4,obscureText: true,),
              ),
          
              TopUpButton(
                isLoading: isLoading ? true:null,
                call: () async{
                if(controller.text.length < 4 || isLoading) return;
                          setState(() {
                            isLoading = true;
                          });
                          var response = await HttpResponse.verifyPin(controller.text.trim());
                          setState(() {
                            isLoading = false;
                          });
                          if(response["status"]){
                            ButtomNavBarProvider().hasNavigatedToPage = false;
                            
                            Navigator.pop(context);
                            return;
                          }
                          controller.clear();
                          showToast(context,response["data"]);
              }, text: "Confirm Pin", reuse: true,color: MyFaysalTheme.of(context).primaryColor,)
            ])
        ),
      ),
    );
  }
}