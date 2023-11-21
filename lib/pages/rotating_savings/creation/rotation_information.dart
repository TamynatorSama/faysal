import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/creation/successful_creation.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_btn.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RotationInformation extends StatefulWidget {
  const RotationInformation({super.key});

  @override
  State<RotationInformation> createState() => _RotationInformationState();
}

class _RotationInformationState extends State<RotationInformation> {
  late TextEditingController numberController;
  final _formKey = GlobalKey<FormState>();
  String? frequency;
  String? disbursement;
  bool isLoading = false;

  @override
  void initState() {
    numberController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    numberController.dispose();
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
          body: Consumer<SavingsProvider>(builder: (context, provider, child) {
            return WidgetBackgorund(
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
                                  child: Text("Rotation Information",
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
                                        controller: numberController,
                                        cursorColor: Colors.white,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        style: MyFaysalTheme.of(context)
                                            .textFieldText,
                                        decoration: InputDecoration(
                                            labelText: "Number of hands",
                                            // labelText: "${MediaQuery.of(context).viewInsets.bottom}",
                                            labelStyle: MyFaysalTheme.of(context)
                                                .promtHeaderText
                                                .override(
                                                    color:
                                                        MyFaysalTheme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.2),
                                                    fontSize: 15),
                                            border: InputBorder.none,
                                            hintText: "10",
                                            hintStyle: MyFaysalTheme.of(context)
                                                .textFieldText
                                                .override(
                                                    color: Colors.white
                                                        .withOpacity(0.2)),
                                            filled: true,
                                            fillColor: const Color(0xff123F33)),
                                      ),
                                    ),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: DropdownButtonFormField<dynamic>(
                                          dropdownColor: MyFaysalTheme.of(context)
                                              .secondaryColor,
                                          iconSize: 0,
                                          decoration: InputDecoration(
                                              labelText: "Frequency",
                                              labelStyle:
                                                  MyFaysalTheme.of(context)
                                                      .promtHeaderText
                                                      .override(
                                                          color: MyFaysalTheme.of(
                                                                  context)
                                                              .primaryColor
                                                              .withOpacity(0.2),
                                                          fontSize: 15),
                                              suffixIcon: const Icon(
                                                Icons.keyboard_arrow_down_rounded,
                                                color: Colors.white,
                                              ),
                                              fillColor: const Color(0xff123F33),
                                              filled: true,
                                              hintText: "Select frequency",
                                              hintStyle: MyFaysalTheme.of(context)
                                                  .textFieldText,
                                              border: InputBorder.none),
                                          style: MyFaysalTheme.of(context)
                                              .textFieldText,
                                          items: List.generate(
                                              provider.frequency.length,
                                              (index) =>
                                                  DropdownMenuItem<dynamic>(
                                                      value: provider
                                                          .frequency[index].id,
                                                      child: Text(provider
                                                          .frequency[index]
                                                          .name))),
                                          onChanged: (value) {
                                            frequency = value.toString();
                                          },
                                        )),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: DropdownButtonFormField<dynamic>(
                                          dropdownColor: MyFaysalTheme.of(context)
                                              .secondaryColor,
                                          iconSize: 0,
                                          decoration: InputDecoration(
                                              labelText: "Disbursement Date",
                                              labelStyle:
                                                  MyFaysalTheme.of(context)
                                                      .promtHeaderText
                                                      .override(
                                                          color: MyFaysalTheme.of(
                                                                  context)
                                                              .primaryColor
                                                              .withOpacity(0.2),
                                                          fontSize: 15),
                                              suffixIcon: const Icon(
                                                Icons.keyboard_arrow_down_rounded,
                                                color: Colors.white,
                                              ),
                                              fillColor: const Color(0xff123F33),
                                              filled: true,
                                              hintText:
                                                  "Select disbursement Date",
                                              hintStyle: MyFaysalTheme.of(context)
                                                  .textFieldText,
                                              border: InputBorder.none),
                                          style: MyFaysalTheme.of(context)
                                              .textFieldText,
                                          items: List.generate(
                                              provider.disbursement.length,
                                              (index) =>
                                                  DropdownMenuItem<dynamic>(
                                                      value: provider
                                                          .disbursement[index].id,
                                                      child: Text(provider
                                                          .disbursement[index]
                                                          .name))),
                                          onChanged: (value) {
                                            disbursement = value.toString();
                                          },
                                        )),
                                  
                                  ],
                                )
                              ]))),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.05),
                          child: SavingsButton(
                              isLoading: isLoading ? true : null,
                              text: "Create",
                              call: () async {
                                if (_formKey.currentState == null ||
                                    !_formKey.currentState!.validate()) {
                                  return;
                                }
                                if (disbursement == null || frequency == null) {
                                  return;
                                }
                                provider.disbursementId = disbursement!;
                                provider.frequencyId = frequency!;
                                provider.numberOfHands = numberController.text;
                                setState(() {
                                  isLoading = true;
                                });
      
                                var response = await provider
                                    .createRotationalSavings(context);
                                    
      
                                setState(() {
                                  isLoading = false;
                                });
                                if (response["status"]) {
                                  navigate();
                                }
                              }))
                    ])));
          }),
        ),
      ),
    );
  }

  navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SuccessfulSavingsCreation(header:"Ajo successfully created",message: "You can now share a public link to your Ajo for members to join. You can check full details of your Ajo in profile.",)),
    );
  }
}
