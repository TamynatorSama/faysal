// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/topup/model/variation_model.dart';
import 'package:faysal/pages/topup/widgets/custom_text_fields.dart';
import 'package:faysal/pages/topup/widgets/provider_display.dart';
import 'package:faysal/pages/topup/widgets/topup_button.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/recharge_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  late RechargeProvider provider;

  List<Map<String, dynamic>> networks = [
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

  late TextEditingController planController;
  TextEditingController amountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  bool isLoadingVariation = false;

  @override
  void initState() {
    provider = Provider.of<RechargeProvider>(context, listen: false);
    planController = TextEditingController(text: "Select Plan");
    getData();
    super.initState();
  }
  getData()async{
    setState(() {
      isLoadingVariation = true;
    });
    await provider.getAllVariations(context);
    if(mounted){
      setState(() {
      isLoadingVariation = false;
    });
    }
  }

  int selectedProvider = 0;
  int selectedPlan = -1;

  @override
  Widget build(BuildContext context) {
    List<String> cases = generateUseCases(selectedProvider == 0
        ? provider.mtnVariation
        : selectedProvider == 1
            ? provider.airtelVariation
            : selectedProvider == 2
                ? provider.etisalatVariation
                : provider.gloVariation);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
          child: Stack(
            children: [
              WidgetBackgorund(
                home: true,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
                  child: Column(
                    children: [
                      const CustomNavBar(header: "Buy Data"),
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
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(
                                              4,
                                              (index) => GestureDetector(
                                                  onTap: () {
                                                    planController =
                                                        TextEditingController(
                                                            text: "Select Plan");
                                                    setState(() {
                                                      selectedProvider = index;
                                                    });
                                                  },
                                                  // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (contex)=>const TopUpSuccessful())),
                                                  child: ProviderDisplay(
                                                    isSelected:
                                                        selectedProvider == index,
                                                    image: networks[index]["image"],
                                                    network: networks[index]
                                                        ["provider"],
                                                  )))),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              CustomTextField(
                                controller: phoneController,
                                label: "Phone Number",
                                suffix: true,
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
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10))),
                                          child: Consumer<RechargeProvider>(
                                              builder: (context, value, child) {
                                            return ScrollConfiguration(
                                              behavior: const ScrollBehavior()
                                                  .copyWith(overscroll: false),
                                              child: SingleChildScrollView(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: List.generate(
                                                      cases.length, (index) {
                                                    List<VariationModel> useCase =
                                                        selectedProvider == 0
                                                            ? value.mtnVariation
                                                            : selectedProvider == 1
                                                                ? value
                                                                    .airtelVariation
                                                                : selectedProvider ==
                                                                        2
                                                                    ? value
                                                                        .etisalatVariation
                                                                    : value
                                                                        .gloVariation;
                                                    return Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 4.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          // Text(cases[index],
                                                          //     style: MyFaysalTheme.of(
                                                          //             context)
                                                          //         .promtHeaderText
                                                          //         .override(
                                                          //             color: Colors
                                                          //                 .white
                                                          //                 .withOpacity(
                                                          //                     0.4),
                                                          //             fontSize: 15)),
                                                          Column(
                                                            children: List.generate(
                                                                useCase.length,
                                                                (newIndex) {
                                                              if (useCase[newIndex]
                                                                      .name
                                                                      .split("-")
                                                                      .last
                                                                      .toLowerCase() ==
                                                                  cases[index].toLowerCase()) {
                                                                // return Text(useCase[newIndex].name.trim());
                                                                return InkWell(
                                                                  onTap: () {
                                                                    provider.data =
                                                                        useCase[
                                                                            newIndex];
                                                                    planController
                                                                            .text =
                                                                        provider.data!
                                                                            .name;
                                                                    Navigator.pop(
                                                                        context);
                                                                    setState(() {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                      selectedPlan =
                                                                          newIndex;
                                                                    });
                                                                  },
                                                                  child: Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            15.0,
                                                                        horizontal:
                                                                            5),
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
                                                                              margin: const EdgeInsets.only(
                                                                                  right:
                                                                                      10),
                                                                              decoration: BoxDecoration(
                                                                                  shape:
                                                                                      BoxShape.circle,
                                                                                  image: DecorationImage(image: AssetImage(networks[selectedProvider]["image"]), fit: BoxFit.cover)),
                                                                            ),
                                                                            ConstrainedBox(
                                                                              constraints: BoxConstraints(maxWidth: size.width * 0.54),
                                                                              child: Text(
                                                                                  useCase[newIndex].name,
                                                                                  style: MyFaysalTheme.of(context).promtHeaderText.override(color: MyFaysalTheme.of(context).primaryText,fontSize: 16)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        
                                                                        AutoSizeText.rich(
                                                                                    TextSpan(children: [
                                                                                      TextSpan(text: getCurrency(), style: const TextStyle(fontFamily: "Poppins")),
                                                                                      TextSpan(
                                                                                        text: NumberFormat().format(double.parse(useCase[newIndex].variationAmount)),
                                                                                      )
                                                                                    ]),
                                                                                    style: MyFaysalTheme.of(context).text1.override(color: Colors.white.withOpacity(0.5))),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              return const Offstage();
                                                            }),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                    //  return Text(useCase[index].name);
                                                    // return Column(
                                                    //   children: List.generate(useCase.length, (indexNew)=> Text(useCase[indexNew].name))
                                                    // );
                                                  }),
                                                ),
                                              ),
                                            );
                                          })));
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
                                              labelText: "Select Plan",
                                              labelStyle: MyFaysalTheme.of(context)
                                                  .promtHeaderText
                                                  .override(
                                                      color: MyFaysalTheme.of(context)
                                                          .primaryColor
                                                          .withOpacity(0.2),
                                                      fontSize: 15),
                                              suffix: GestureDetector(
                                                child: SvgPicture.string(
                                                  '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>',
                                                  color: Colors.white,
                                                  width: 16,
                                                ),
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
        
                              // const CustomTextField(
        
                              //   label: "Amount",
                              //   suffix: false,
                              // ),
        
                              // Text("MyFaysal Balance - ₦3,520,100 ",style: MyFaysalTheme.of(context).text1.override(color:Colors.white.withOpacity(0.5)),)
                            ],
                          ))),
                      TopUpButton(
                        reuse: false,
                        isLoading: isLoading ? true : null,
                        call: () async {
                          if (phoneController.text.isEmpty || selectedPlan == -1) return;
        
                          provider.serviceID = selectedProvider == 0
                              ? "mtn-data"
                              : selectedProvider == 1
                                  ? "glo-data"
                                  : selectedProvider == 2
                                      ? "airtel-data"
                                      : "etisalat-data";
                          String check = phoneController.text.startsWith("0")
                              ? phoneController.text
                              :"0${phoneController.text}";
                          provider.number = check;
                          var pin = await showPinConfirmationModal();
                          
                          if (pin == null) {
                            setState(() {
                              FocusScope.of(context).unfocus();
                            });
                            return;
                          }
                          provider.pin = pin;
                          FocusScope.of(context).unfocus();

                          
                          setState(() {
                            FocusScope.of(context).unfocus();
                          });
                          setState(() {
                            isLoading = true;
                            FocusScope.of(context).unfocus();
                          });
        
                          await provider.buyData(context);
                          setState(() {
                            isLoading = false;
                          });
                        },
                        text: "Buy Data Bundle",
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
          ),
        ),
      ),
    );
  }
}

List<String> generateUseCases(List<VariationModel> dataList) {
  List<String> test = [];
  for (VariationModel strings in dataList) {
    if (!test.contains(strings.name.split("-").last.toLowerCase())) {
      test.add(strings.name.split("-").last.toLowerCase());
    }
  }
  return test;
}

// String getDataPlan(String unparsed) {
//   List testValue = [];
//   if(unparsed.contains('-')){
//     var testValue =  unparsed
//       .split("-")
//       .where((element) => element.contains("MB") || element.contains("GB"));
//   }
  
//   var check = testValue.isEmpty ? unparsed:testValue.first;


      
//   if (check.split(" ").length > 1) {
//     var allList = check
//         .split(" ")
//         .where((element) => element.contains("MB") || element.contains("GB"));

//     String test = allList.isEmpty ? check:allList.first;
//     return test;
//   }
//   return check;
// }

// String getDataPrice(String unparsed) {
//   // print(unparsed);
//   var check = unparsed.split("-");
//   String dataPrice = "";
//   switch (check.length) {
//     case 2:
//       var test = check.first.trim().split(" ");
//       dataPrice = test.first;
//       break;
//     case 3:
//       var test = check.first.trim().split(" ");
//       if (test.last.toLowerCase() == "data") {
//         dataPrice = check[1].trim().split(" ").first;
//       } else {
//         dataPrice = test.last;
//       }

//       break;
//     case 4:
//       dataPrice = check[1].trim().split(" ").first;
//       break;
//   }
//   return dataPrice;
// }
