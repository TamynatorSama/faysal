// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/bills/requests/model/verified_card_model.dart';
import 'package:faysal/pages/bills/widget/user_card.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/topup/widgets/custom_text_fields.dart';
import 'package:faysal/pages/topup/widgets/topup_button.dart';
import 'package:faysal/provider/bills_provider.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/utils/formatter.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PayUtilityBills extends StatefulWidget {
  final int imageIndex;
  const PayUtilityBills({super.key, required this.imageIndex});

  @override
  State<PayUtilityBills> createState() => _PayUtilityBillsState();
}

class _PayUtilityBillsState extends State<PayUtilityBills> {
  late TextEditingController planController;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController cardController;
  late TextEditingController amountController;

  @override
  void initState() {
    Provider.of<BillProivder>(context,listen: false).verifiedMeter = null;
    planController = TextEditingController(text: "Select Meter Type");
    cardController = TextEditingController();
    amountController = TextEditingController();
    super.initState();
  }

  bool isLoading = false;

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
          body: Consumer<BillProivder>(builder: (context, provider, child) {
            return WidgetBackgorund(
              home: true,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                child: Column(
                  children: [
                    CustomNavBar(header: provider.electricityProvider.replaceAll("-", " ").capitalize()),
                    Form(
                      key: _formKey,
                      child: Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                        children: [
                          AutoSizeText.rich(
                              TextSpan(children: [
                                const TextSpan(text: "MyFaysal Balance - "),
                                TextSpan(
                                    text: getCurrency(),
                                    style:
                                        const TextStyle(fontFamily: "Poppins")),
                                TextSpan(
                                    text: NumberFormat().format(
                                        Provider.of<ProfileProvider>(context,
                                                listen: false)
                                            .userProfile
                                            .balance))
                              ]),
                              style: MyFaysalTheme.of(context).text1.override(
                                  color: Colors.white.withOpacity(0.5))),
                          provider.verifiedMeter == null
                              ? const Offstage()
                              : UserDetailsCard(
                                isUtility: true,
                                  model: VerifieduserCardModel(currentBouquet: provider.verifiedMeter!.address, customerName:provider.verifiedMeter!.name, customerNumber: provider.verifiedMeter!.meterNumber),
                                ),
      
                          SizedBox(
                            height: size.height * 0.06,
                          ),
                          CustomTextField(
                            controller: amountController,
                            label: "Amount",
                            suffix: false,
                            format: [
                              CurrencyFormatter()
                            ],
                          ),
                          CustomTextField(
                            controller: cardController,
                            label: "Meter Number",
                            suffix: false,
                          ),

      
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => Container(
                                        width: double.maxFinite,
                                        height: 200,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: MyFaysalTheme.of(context)
                                                .secondaryColor,
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: List.generate(
                                                2,
                                                (index) {
                                             var useable = ["Prepaid","Postpaid"];
      
                                              // return Text(useCase[newIndex].name.trim());
                                              return InkWell(
                                                onTap: () {
                                                  planController.text = useable[index];
                                                  
                                                  Navigator.pop(context);
                                                  FocusScope.of(context).unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 15.0,
                                                          horizontal: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width:
                                                                size.width * 0.12,
                                                            height:
                                                                size.width * 0.12,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                         'assets/images/electricity${widget.imageIndex}.png'),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ConstrainedBox(
                                                                constraints:
                                                                    BoxConstraints(
                                                                        maxWidth:
                                                                            size.width *
                                                                                0.6),
                                                                child: Text(
                                                                    useable[index],
                                                                    maxLines: 2,
                                                                    style: MyFaysalTheme.of(
                                                                            context)
                                                                        .promtHeaderText
                                                                        .override(
                                                                            color: MyFaysalTheme.of(context)
                                                                                .primaryText,
                                                                            fontSize:
                                                                                size.width * 0.04)),
                                                              ),
                                                              // AutoSizeText.rich(
                                                              //     TextSpan(
                                                              //         children: [
                                                              //           TextSpan(
                                                              //               text:
                                                              //                   getCurrency(),
                                                              //               style:
                                                              //                   const TextStyle(fontFamily: "Poppins")),
                                                              //           TextSpan(
                                                              //             text: NumberFormat()
                                                              //                 .format(double.parse(useable[index].variationAmount)),
                                                              //           )
                                                              //         ]),
                                                              //     style: MyFaysalTheme.of(
                                                              //             context)
                                                              //         .text1
                                                              //         .override(
                                                              //             color: Colors
                                                              //                 .white
                                                              //                 .withOpacity(0.5))),
                                                            
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      // Text(useable[index].variationCode,
                                                      //     style: MyFaysalTheme.of(
                                                      //             context)
                                                      //         .promtHeaderText
                                                      //         .override(
                                                      //             color:
                                                      //                 Colors.white,
                                                      //             fontSize: 15)),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ));
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 25.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: TextFormField(
                                      controller: planController,
                                      readOnly: true,
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.number,
                                      style:
                                          MyFaysalTheme.of(context).textFieldText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'))
                                      ],
                                      decoration: InputDecoration(
                                          labelText: "Select Meter Type",
                                          labelStyle: MyFaysalTheme.of(context)
                                              .promtHeaderText
                                              .override(
                                                  color: MyFaysalTheme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.2),
                                                  fontSize: 15),
                                          suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Colors.white,
                                          ),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: const Color(0xff123F33)),
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.001,
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 50,
                                    color:
                                        MyFaysalTheme.of(context).secondaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
      
                          // Text("MyFaysal Balance - ₦3,520,100 ",style: MyFaysalTheme.of(context).text1.override(color:Colors.white.withOpacity(0.5)),)
                        ],
                      ))),
                    ),
                    TopUpButton(
                      reuse: false,
                      isLoading: isLoading ? true : null,
                      call: () async {
                        if (_formKey.currentState == null ||
                            !_formKey.currentState!.validate()) {
                          return;
                        }
                        if (planController.text
                            .toLowerCase()
                            .contains("select")) {
                          showToast(context, "Please select a meter type");
                          return;
                        }
                        FocusScope.of(context).unfocus();
                        setState(() {
                          isLoading = true;
                        });
                        if (provider.verifiedMeter == null) {
                          
                          await provider.getUserMeterDetails(
                              provider.electricityProvider, cardController.text,planController.text.toLowerCase(),context);
      
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }
      
                        
      
                        var pin = await showPinConfirmationModal();
                        if (pin == null) {
                          setState(() {
                            isLoading = false;
                            FocusScope.of(context).unfocus();
                          });
                          return;
                        }
                        provider.pin = pin;
                        setState(() {
                          FocusScope.of(context).unfocus();
                        });
      
                        await provider.buyElectricity(
                            Provider.of<ProfileProvider>(context, listen: false)
                                .userProfile
                                .phone,
                                RemoveSeparator(amountController.text).toString(),
                            context);
                        setState(() {
                            isLoading = false;
                            FocusScope.of(context).unfocus();
                          });
                      },
                      text: provider.verifiedMeter == null
                          ? "Verify Meter"
                          : "Pay Electricity bill",
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
