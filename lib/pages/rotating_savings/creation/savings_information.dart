import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/creation/rotation_information.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_btn.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/formatter.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SavingsInformation extends StatefulWidget {
  const SavingsInformation({super.key});

  @override
  State<SavingsInformation> createState() => _SavingsInformationState();
}

class _SavingsInformationState extends State<SavingsInformation> {
  late TextEditingController planController;
  late TextEditingController amountController;
  late TextEditingController coordinatorFeeController;
  late SavingsProvider provider;
  DateTime? startDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    planController = TextEditingController(text: "Select Date");
    amountController = TextEditingController();
    coordinatorFeeController = TextEditingController();
    provider = Provider.of<SavingsProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    planController.dispose();
    amountController.dispose();
    coordinatorFeeController.dispose();
    super.dispose();
  }

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
          body: WidgetBackgorund(
              home: true,
              child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(children: [
                    const CustomNavBar(header: "Rotating Savings"),
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: ScrollConfiguration(
                            behavior: const ScrollBehavior()
                                .copyWith(overscroll: false),
                            child: SingleChildScrollView(
                                child: Column(children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.047,
                                    bottom: size.height * 0.04),
                                child: Text("Saving Information",
                                    style: MyFaysalTheme.of(context)
                                        .splashHeaderText
                                        .override(fontSize: size.width * 0.05)),
                              ),
                              Wrap(
                                runSpacing: size.height * 0.04,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: TextFormField(
                                        controller: amountController,
                                        cursorColor: Colors.white,
                                        keyboardType: TextInputType.number,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                            onChanged: (value) => setState(() {}),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CurrencyFormatter()
                                        ],
                                        style: MyFaysalTheme.of(context)
                                            .textFieldText,
                                        decoration: InputDecoration(
                                            labelText: "Amount",
                                            // labelText: "${MediaQuery.of(context).viewInsets.bottom}",
                                            labelStyle:
                                                MyFaysalTheme.of(context)
                                                    .promtHeaderText
                                                    .override(
                                                        color: MyFaysalTheme.of(
                                                                context)
                                                            .primaryColor
                                                            .withOpacity(0.2),
                                                        fontSize: 15),
                                            border: InputBorder.none,
                                            hintStyle: MyFaysalTheme.of(context)
                                                .textFieldText
                                                .override(
                                                    color: Colors.white
                                                        .withOpacity(0.2)),
                                            filled: true,
                                            fillColor: const Color(0xff123F33)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field is required";
                                          }
                                          return null;
                                        }),
                                  ),
                                  
                                  provider.ajoType == "2" ?const Offstage() :ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: TextFormField(
                                        controller: coordinatorFeeController,
                                        cursorColor: Colors.white,
                                        keyboardType: TextInputType.number,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CurrencyFormatter()
                                        ],
                                        style: MyFaysalTheme.of(context)
                                            .textFieldText,
                                        decoration: InputDecoration(
                                            labelText: "Coordinator Fee",
                                            // labelText: "${MediaQuery.of(context).viewInsets.bottom}",
                                            labelStyle:
                                                MyFaysalTheme.of(context)
                                                    .promtHeaderText
                                                    .override(
                                                        color: MyFaysalTheme.of(
                                                                context)
                                                            .primaryColor
                                                            .withOpacity(0.2),
                                                        fontSize: 15),
                                            border: InputBorder.none,
                                            hintStyle: MyFaysalTheme.of(context)
                                                .textFieldText
                                                .override(
                                                    color: Colors.white
                                                        .withOpacity(0.2)),
                                            filled: true,
                                            fillColor: const Color(0xff123F33)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field is required";
                                          }
                                          return null;
                                        }),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      String date = await selectFilterDate(
                                          context,
                                          DateTime.now(),
                                          DateTime(
                                              DateTime.now().year + 10, 1, 1));

                                      if (date.isEmpty) return;

                                      List<String> separatedDate =
                                          date.split("-");

                                      startDate = DateTime(
                                          int.parse(separatedDate[0]),
                                          int.parse(separatedDate[1]),
                                          int.parse(separatedDate[2]));
                                      planController.text = DateFormat.yMMMMd()
                                          .format(startDate!);
                                      setState(() {});
                                    },
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: TextFormField(
                                              controller: planController,
                                              readOnly: true,
                                              cursorColor: Colors.white,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: MyFaysalTheme.of(context)
                                                  .textFieldText,
                                              decoration: InputDecoration(
                                                  labelText: "Start Date",
                                                  labelStyle: MyFaysalTheme.of(
                                                          context)
                                                      .promtHeaderText
                                                      .override(
                                                          color: MyFaysalTheme
                                                                  .of(context)
                                                              .primaryColor
                                                              .withOpacity(0.2),
                                                          fontSize: 15),
                                                  suffix: SvgPicture.string(
                                                    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>',
                                                    color: Colors.white,
                                                    width: 16,
                                                  ),
                                                  border: InputBorder.none,
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xff123F33)),
                                              validator: (value) {
                                                if (!value!.contains(
                                                    DateTime.now()
                                                        .year
                                                        .toString())) {
                                                  return "Select start date";
                                                }
                                                return null;
                                              },
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
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:20.0,bottom: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: SvgPicture.string(
                                        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>',
                                        color:
                                            MyFaysalTheme.of(context).accentColor,
                                        width: 15,
                                      ),
                                    ),
                                    AutoSizeText(
                                      "Commission Breakdown",
                                      maxLines: 2,
                                      style: MyFaysalTheme.of(context)
                                          .text1
                                          .override(
                                            fontSize: size.width * 0.02,
                                            color: MyFaysalTheme.of(context)
                                                .accentColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Wrap(
                                runSpacing: 15,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Faysal Percentage",
                                        style: MyFaysalTheme.of(context)
                                            .splashHeaderText
                                            .override(
                                                fontSize: size.width * 0.035),
                                      ),
                                      Text(
                                        "${Provider.of<ProfileProvider>(context).settings.ajoCommission}%",
                                        style: MyFaysalTheme.of(context)
                                              .text1
                                              .override(fontSize: size.width *0.03),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Faysal Fee",
                                        style: MyFaysalTheme.of(context)
                                            .splashHeaderText
                                            .override(
                                                fontSize: size.width * 0.035),
                                      ),
                                      AutoSizeText.rich(
                                          TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "${int.parse(Provider.of<ProfileProvider>(context,listen: false).settings.ajoCommission)}% of "),
                                            TextSpan(
                                                text: getCurrency(),
                                                style: const TextStyle(
                                                    fontFamily: "Poppins")),
                                            TextSpan(
                                                text: amountController
                                                    .text.isEmpty ? "0": NumberFormat().format(double.parse(RemoveSeparator(amountController.text).toString()))),
                                            const TextSpan(text: " => "),
                                            TextSpan(
                                                text: getCurrency(),
                                                style: const TextStyle(
                                                    fontFamily: "Poppins")),
                                            TextSpan(
                                                text: NumberFormat().format(
                                                    calcPercentage(
                                                        amountController
                                                            .text,
                                                        Provider.of<ProfileProvider>(
                                                                context,listen: false)
                                                            .settings
                                                            .ajoCommission)))
                                          ]),
                                          style: MyFaysalTheme.of(context)
                                              .text1
                                              .override(fontSize: size.width *0.03)),
                                    ],
                                  )
                                ],
                              )
                            ]))),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.05),
                        child: SavingsButton(
                            text: "Next",
                            call: () {
                              if (_formKey.currentState == null ||
                                  !_formKey.currentState!.validate()) {
                                return;
                              }
                              if (startDate == null) {
                                return;
                              }
                              provider.amount = amountController.text;
                              provider.coordinatorFee =
                                  coordinatorFeeController.text;
                              provider.faysalFee = calcPercentage(amountController.text, Provider.of<ProfileProvider>(
                                                                context,listen: false)
                                                            .settings
                                                            .ajoCommission).toString();
                              provider.startDate =
                                  "${startDate!.year}-${startDate!.month}-${startDate!.day}";

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RotationInformation()));
                            }))
                  ]))),
        ),
      ),
    );
  }

  double calcPercentage(String controllerText, String commission) {
    if (controllerText.isEmpty) {
      return 0;
    }
    double returnable =
        (double.parse(RemoveSeparator(controllerText).toString()) *
                    (double.parse(commission) / 100))
                .isNaN
            ? 0
            : double.parse(RemoveSeparator(controllerText).toString()) *
                ( double.parse(commission) / 100);
    return returnable;
  }
}
