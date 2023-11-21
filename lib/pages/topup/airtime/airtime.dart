// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/topup/widgets/custom_text_fields.dart';
import 'package:faysal/pages/topup/widgets/provider_display.dart';
import 'package:faysal/pages/topup/widgets/topup_button.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/recharge_provider.dart';
import 'package:faysal/utils/formatter.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Airtime extends StatefulWidget {
  const Airtime({super.key});

  @override
  State<Airtime> createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {


  List<Map<String,dynamic>> networks = [
    {
      "image": "assets/images/mtn.png",
      "provider": "MTN",
    },
    {
      "image": "assets/images/airtel.png",
      "provider": "AIRTEL",
    },
    {
      "image": "assets/images/etisalat.png",
      "provider": "9MOBILE",
    },
    {
      "image": "assets/images/glo.png",
      "provider": "GLO",
    },
  ];

  TextEditingController amountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int selectedProvider = 0;
  bool isLoading = false;
  late RechargeProvider recharge;

  @override
  void initState() {
    recharge = Provider.of<RechargeProvider>(context,listen: false);
    super.initState();
  }


  @override
void dispose(){
  amountController.dispose();
  phoneController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body: Consumer<RechargeProvider>(
            builder: (context, provider,child) {
              return WidgetBackgorund(
                home: true,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0,24.0,24.0,0),
                  child: Column(
                    children: [
                      const CustomNavBar(header: "Buy Airtime"),
                      Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              AutoSizeText.rich(
                                  TextSpan(children: [
                                    const TextSpan(text: "MyFaysal Balance - "),
                                    TextSpan(
                                        text: getCurrency(),
                                        style: const TextStyle(fontFamily: "Poppins")),
                                    TextSpan(text: NumberFormat().format(Provider.of<ProfileProvider>(context).userProfile.balance))
                                  ]),
                                  style: MyFaysalTheme.of(context)
                                      .text1
                                      .override(color: Colors.white.withOpacity(0.5))),
              
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                    vertical: 23,
                                    horizontal: size.width < 327 ? 15 : 25),
                                margin: EdgeInsets.only(top: size.height * 0.03),
                                decoration: BoxDecoration(
                                  color: MyFaysalTheme.of(context).secondaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Select Network",
                                        style: MyFaysalTheme.of(context)
                                            .splashHeaderText
                                            .override(fontSize: 14)),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: List.generate(4, (index) => GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              selectedProvider = index;
                                            });
                                             provider.setProivder(networks[index]["provider"].toString().toLowerCase());
                                             },
                                          child: ProviderDisplay(
                                            isSelected: selectedProvider == index,
                                            image: networks[index]["image"],network: networks[index]["provider"], )))
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              CustomTextField(
                                controller: phoneController,
                                label: "Phone Number",suffix: true, format: [ FilteringTextInputFormatter.digitsOnly,
                                            LengthLimitingTextInputFormatter(11)],),
                              CustomTextField(
                                controller: amountController,
                                label: "Amount",suffix: false,
                                format: [
                                  CurrencyFormatter()
                                ],
                                ),
              
                              // Text("MyFaysal Balance - ₦3,520,100 ",style: MyFaysalTheme.of(context).text1.override(color:Colors.white.withOpacity(0.5)),)
                            ],
                          ))),
                      TopUpButton(
                        reuse: false,
                        isLoading: isLoading ? true : null,
                        call: () async{
                          if(amountController.text.isEmpty || phoneController.text.isEmpty || provider.provider.isEmpty)return;
                                provider.amount = amountController.text;
                                String check = phoneController.text.startsWith("0")
                              ?phoneController.text
                              : "0${phoneController.text}";
                                provider.number = check;
                        var pin = await showPinConfirmationModal();
                        
                      if (pin == null) {
                        setState(() {
                          FocusScope.of(context).unfocus();
                        });
                        return;
                      }
                      FocusScope.of(context).unfocus();
                      provider.pin = pin;
                        FocusScope.of(context).unfocus();
                        
                        setState(() {
                          isLoading = true;
                          FocusScope.of(context).unfocus();
                        });
                        
                        await recharge.buyAirtime(context);
                        setState(() {
                          isLoading = false;
                        });
                      },text: "Buy Airtime",)
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
