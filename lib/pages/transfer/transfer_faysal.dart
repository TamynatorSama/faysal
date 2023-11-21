// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/topup/widgets/custom_text_fields.dart';
import 'package:faysal/pages/topup/widgets/topup_button.dart';
import 'package:faysal/pages/transfer/widget/usercard.dart';
import 'package:faysal/provider/trasfer_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransferFaysal extends StatefulWidget {
  const TransferFaysal({super.key});

  @override
  State<TransferFaysal> createState() => _TransferFaysalState();
}

class _TransferFaysalState extends State<TransferFaysal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController accountController;
  late TextEditingController narrationController;
  bool gettingBank = false;

  late TransferProvider transfer;

  @override
  void initState() {
    transfer = Provider.of<TransferProvider>(context, listen: false);
    transfer.transferFaysal = null;
    accountController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    narrationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    accountController.dispose();
    narrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body: WidgetBackgorund(
            home: true,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  24.0,
                  size.height < 750 ? size.height * 0.02 : size.height * 0.02,
                  24.0,
                  0),
              child:
                  Consumer<TransferProvider>(builder: (context, provider, child) {
                return Column(
                  children: [
                    const CustomNavBar(header: "Transfer"),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.03),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          padding: const EdgeInsets.all(6.5),
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: MyFaysalTheme.of(context)
                                                  .primaryColor),
                                          child: SvgPicture.string(
                                            '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="7" y1="17" x2="17" y2="7"></line><polyline points="7 7 17 7 17 17"></polyline></svg>',
                                          ),
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: size.width * 0.53),
                                          child: AutoSizeText.rich(
                                            TextSpan(children: [
                                              TextSpan(
                                                  text: getCurrency(),
                                                  style: const TextStyle(
                                                      fontFamily: "Poppins")),
                                              TextSpan(
                                                  text: NumberFormat()
                                                      .format(provider.amount))
                                            ]),
                                            maxLines: 1,
                                            style: MyFaysalTheme.of(context)
                                                .splashHeaderText
                                                .override(fontSize: 36),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          label: "Reciever Phone Number",
                                          suffix: true,
                                          controller: accountController,
                                          functionChange: true,
                                        ),
                                        CustomTextField(
                                          label: "Naration",
                                          suffix: false,
                                          inputType: TextInputType.text,
                                          controller: narrationController,
                                          format: const [],
                                        ),
                                      ],
                                    ),
                                  ),
                                  provider.transferFaysal == null
                                      ? const Offstage()
                                      : FaysalTransaferUserCard(
                                          id: provider.transferFaysal!.id,
                                          name: provider.transferFaysal!.name,
                                          acctNumber:
                                              provider.transferFaysal!.phone,
                                              userProfilePics: provider.transferFaysal!.avatar.isEmpty? null:provider.transferFaysal!.avatar,
                                        ),
                                ],
                              ),
                            ),
                          ),
                          TopUpButton(
                              isLoading: gettingBank ? true : null,
                              call: () async {
                                if (_formKey.currentState == null ||
                                    !_formKey.currentState!.validate()) {
                                  return;
                                }
                                if (gettingBank) return;
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  gettingBank = true;
                                });
                                provider.accountNumer =
                                    accountController.text;
                                provider.description = narrationController.text;
    
                                if (provider.transferFaysal == null) {
                                  if (accountController.text.isNotEmpty &&
                                      accountController.text.length >= 10) {
                                    await provider.getUser(
                                        accountController.text.trim(), context);
                                  }
                                  setState(() {
                                    gettingBank = false;
                                  });
                                  return;
                                }
                                FocusScope.of(context).unfocus();
    
                                var proceed =
                                    await showTransferConfirmationDialog();
                                if (proceed == null) {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    gettingBank = false;
                                  });
                                }
    
                                if (proceed) {
                                  var pin = await showPinConfirmationModal();
                                  if (pin == null) {
                                    setState(() {
                                      gettingBank = false;
                                      FocusScope.of(context).unfocus();
                                    });
                                    return;
                                  }
                                  provider.pin = pin;
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                  });
    
                                  await provider.internalTransfer(context);
    
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    gettingBank = false;
                                  });
                                } else {
                                  setState(() {
                                    gettingBank = false;
                                    FocusScope.of(context).unfocus();
                                  });
                                }
                              },
                              text: provider.transferFaysal == null
                                  ? "Verify User"
                                  : "Continue",
                              reuse: true)
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
