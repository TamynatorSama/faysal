// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/bills/widget/user_card.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/topup/widgets/custom_text_fields.dart';
import 'package:faysal/pages/topup/widgets/topup_button.dart';
import 'package:faysal/provider/bills_provider.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PayTvBills extends StatefulWidget {
  const PayTvBills({super.key});

  @override
  State<PayTvBills> createState() => _PayTvBillsState();
}

class _PayTvBillsState extends State<PayTvBills> {
  late TextEditingController planController;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController cardController;
  bool isLoadingVariation = false;

  @override
  void initState() {
    Provider.of<BillProivder>(context, listen: false).verifiedUser = null;
    getData();
    planController = TextEditingController(text: "Select Plan");
    cardController = TextEditingController();
    super.initState();
  }

  getData() async {
    setState(() {
      isLoadingVariation = true;
    });
    switch (Provider.of<BillProivder>(context, listen: false)
        .provider
        .toLowerCase()) {
      case 'dstv':
        if (Provider.of<BillProivder>(context, listen: false).dstv.isEmpty) {
          await Provider.of<BillProivder>(context, listen: false)
              .getDstvserviceVariationsData(context, false);
        }
        break;
      case 'gotv':
        if (Provider.of<BillProivder>(context, listen: false).gotv.isEmpty) {
          await Provider.of<BillProivder>(context, listen: false)
              .getGotvserviceVariationsData(context, false);
        }
        break;
      default: 
      if (Provider.of<BillProivder>(context, listen: false).star.isEmpty) {
          await Provider.of<BillProivder>(context, listen: false)
              .getStartimesserviceVariationsData(context, false);
        }
        break;
    }
    if(mounted) {
      setState(() {
      isLoadingVariation = false;
    });
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
            textScaleFactor:
                MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body: Consumer<BillProivder>(builder: (context, provider, child) {
            return Stack(
              children: [
                WidgetBackgorund(
                  home: true,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                    child: Column(
                      children: [
                        CustomNavBar(header: provider.provider.capitalize()),
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
                              provider.verifiedUser == null
                                  ? const Offstage()
                                  : UserDetailsCard(
                                      model: provider.verifiedUser!,
                                    ),

                              SizedBox(
                                height: size.height * 0.06,
                              ),
                              CustomTextField(
                                controller: cardController,
                                label: "Card Number",
                                suffix: false,
                              ),

                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) => Container(
                                            width: double.maxFinite,
                                            height: 350,
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                color: MyFaysalTheme.of(context)
                                                    .secondaryColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10))),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: List.generate(
                                                    provider.provider
                                                                .toLowerCase() ==
                                                            "dstv"
                                                        ? provider.dstv.length
                                                        : provider.provider
                                                                    .toLowerCase() ==
                                                                "gotv"
                                                            ? provider.gotv.length
                                                            : provider.star.length,
                                                    (index) {
                                                  // print(provider.provider);

                                                  var useable = provider.provider
                                                              .toLowerCase() ==
                                                          "dstv"
                                                      ? provider.dstv
                                                      : provider.provider
                                                                  .toLowerCase() ==
                                                              "gotv"
                                                          ? provider.gotv
                                                          : provider.star;

                                                  // return Text(useCase[newIndex].name.trim());

                                                  return InkWell(
                                                    onTap: () {
                                                      planController.text =
                                                          useable[index].name;
                                                      provider.variationCode =
                                                          useable[index]
                                                              .variationCode;
                                                      Navigator.pop(context);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15.0,
                                                          horizontal: 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
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
                                                                width: size.width *
                                                                    0.12,
                                                                height: size.width *
                                                                    0.12,
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right: 10),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    image: DecorationImage(
                                                                        image: AssetImage(provider.provider.toLowerCase() == "dstv"
                                                                            ? 'assets/images/dstv.png'
                                                                            : provider.provider.toLowerCase() == "dstv"
                                                                                ? 'assets/images/gotv.png'
                                                                                : 'assets/images/start.png'),
                                                                        fit: BoxFit.cover)),
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ConstrainedBox(
                                                                    constraints: BoxConstraints(
                                                                        maxWidth:
                                                                            size.width *
                                                                                0.6),
                                                                    child: Text(
                                                                        useable[index]
                                                                            .name,
                                                                        maxLines: 2,
                                                                        style: MyFaysalTheme.of(
                                                                                context)
                                                                            .promtHeaderText
                                                                            .override(
                                                                                color:
                                                                                    MyFaysalTheme.of(context).primaryText,
                                                                                fontSize: size.width * 0.04)),
                                                                  ),
                                                                  AutoSizeText.rich(
                                                                      TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                                text:
                                                                                    getCurrency(),
                                                                                style:
                                                                                    const TextStyle(fontFamily: "Poppins")),
                                                                            TextSpan(
                                                                              text:
                                                                                  NumberFormat().format(double.parse(useable[index].variationAmount)),
                                                                            )
                                                                          ]),
                                                                      style: MyFaysalTheme.of(
                                                                              context)
                                                                          .text1
                                                                          .override(
                                                                              color: Colors
                                                                                  .white
                                                                                  .withOpacity(0.5))),
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
                                          style: MyFaysalTheme.of(context)
                                              .textFieldText,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]'))
                                          ],
                                          decoration: InputDecoration(
                                              labelText: "Select Plan",
                                              labelStyle: MyFaysalTheme.of(context)
                                                  .promtHeaderText
                                                  .override(
                                                      color:
                                                          MyFaysalTheme.of(context)
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
                                        color: MyFaysalTheme.of(context)
                                            .secondaryColor,
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
                              showToast(context, "Please select a plan");
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            if (provider.verifiedUser == null) {
                              await provider.getUserCardDetails(
                                  provider.provider, cardController.text, context);

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

                            await provider.buySubscription(
                                Provider.of<ProfileProvider>(context, listen: false)
                                    .userProfile
                                    .phone,
                                context,
                                planController.text);
                            setState(() {
                              isLoading = false;
                              FocusScope.of(context).unfocus();
                            });
                          },
                          text: provider.verifiedUser == null
                              ? "Confirm Card"
                              : "Buy Subscription",
                        )
                      ],
                    ),
                  ),
                ),
                if(isLoadingVariation)Container(
                  width: double.maxFinite,
                  color: Colors.black.withOpacity(0.4),
                  child: const LoadingScreen(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
