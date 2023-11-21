// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/models/bank_model.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/topup/widgets/custom_text_fields.dart';
import 'package:faysal/pages/topup/widgets/topup_button.dart';
import 'package:faysal/pages/transfer/widget/bank_select_modal.dart';
import 'package:faysal/pages/transfer/widget/usercard.dart';
import 'package:faysal/provider/trasfer_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransferBank extends StatefulWidget {
  const TransferBank({super.key});

  @override
  State<TransferBank> createState() => _TransferBankState();
}

class _TransferBankState extends State<TransferBank> {
  late TextEditingController accountController;
  late TextEditingController bankController;
  late TextEditingController narrationController;
  final _formKey = GlobalKey<FormState>();
  BankModel? bank;
  bool isLoading = false;
  bool gettingBanks = false;

  @override
  void initState() {
    getBanks();
    bankController = TextEditingController(text: "Select Bank");
    accountController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    Provider.of<TransferProvider>(context, listen: false).userBankName = null;
    narrationController = TextEditingController();
    super.initState();
  }

  getBanks()async{
    if(mounted){
      setState(() {
        gettingBanks = true;
      });
    }
    if(Provider.of<TransferProvider>(context, listen: false).banks.isEmpty){
      await Provider.of<TransferProvider>(context, listen: false).populateBank();
    }
    if(mounted){
      setState(() {
        gettingBanks = false;
      });
    }
    if(!Provider.of<TransferProvider>(context, listen: false).ableToDoExternalTransfer){
      showFeedbackToast("Local bank transfers is not available at the moment", true,context);
      Navigator.pop(context);
    }
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
          body: Consumer<TransferProvider>(builder: (context, provider, child) {
            return Stack(
              children: [
                WidgetBackgorund(
                  home: true,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        24.0,
                        size.height < 750 ? size.height * 0.02 : size.height * 0.02,
                        24.0,
                        0),
                    child: Column(
                      children: [
                        const CustomNavBar(header: "Transfer"),
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
                                      margin: const EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              MyFaysalTheme.of(context).primaryColor),
                                      child: SvgPicture.string(
                                        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="7" y1="17" x2="17" y2="7"></line><polyline points="7 7 17 7 17 17"></polyline></svg>',
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: size.width * 0.53),
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
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    provider.update(Update.bankcode, null);
                                    provider.userBankName = null;
                                    var getBank = await showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) => SafeArea(
                                              child: Padding(
                                                padding:
                                                    MediaQuery.of(context).viewInsets,
                                                child: BankSelectModal(
                                                  banks:
                                                      Provider.of<TransferProvider>(
                                                              context,
                                                              listen: false)
                                                          .banks,
                                                ),
                                              ),
                                            ));
                                    if (getBank != null) {
                                      bank = getBank;
                                      bankController.text = bank!.bankName;
                                    }
    
                                    if (bank != null &&
                                        accountController.text.isNotEmpty &&
                                        accountController.text.length > 9) {
                                      await provider.getUserBank(bank!.bankCode,
                                          accountController.text, context);
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: TextFormField(
                                          controller: bankController,
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
                                              labelText: "Select Bank",
                                              labelStyle: MyFaysalTheme.of(context)
                                                  .promtHeaderText
                                                  .override(
                                                      color: MyFaysalTheme.of(context)
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
                                              fillColor: const Color(0xff123F33)),
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
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      label: "Account Number",
                                      suffix: false,
                                      controller: accountController,
                                      functionChange: false,

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
                              provider.userBankName == null
                                  ? const Offstage()
                                  : FaysalTransaferUserCard(
                                      id: 1,
                                      acctNumber: provider.accountNumer.toString(),
                                      name: provider.userBankName!)
                            ],
                          ),
                        )),
                        TopUpButton(
                            isLoading: isLoading ? true : null,
                            call: () async {
                              if (_formKey.currentState == null ||
                                  !_formKey.currentState!.validate()) {
                                return;
                              }
                              if(bank ==null)return;
                              if (isLoading) return;
                              // if(provider.userBankName == null || accountController.text.isEmpty){
                              //   return;
                              // }
                              FocusScope.of(context).unfocus();
                              setState(() {
                                isLoading = true;
                              });
                              provider.update(Update.acccountnum,
                                  accountController.text);
                              provider.update(
                                  Update.description, narrationController.text);
                              provider.update(Update.bankcode, bank!);
                              if (bank != null &&
                                  accountController.text.isNotEmpty &&
                                  provider.userBankName == null) {
                                await provider.getUserBank(
                                    bank!.bankCode, accountController.text, context);
                                setState(() {
                                  isLoading = false;
                                });
                                return;
                              }
    
                              var proceed = await showTransferConfirmationDialog();
                              if (proceed == null) {
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                  isLoading = false;
                                });
                              }
    
                              if (proceed) {
                                var pin = await showPinConfirmationModal();
                                if (pin == null) {
                                  setState(() {
                                    isLoading = false;
                                    FocusScope.of(context).unfocus();
                                  });
                                  return;
                                }
                                provider.pin = pin;
                                FocusScope.of(context).unfocus();
                                
    
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                });
                                FocusScope.of(context).unfocus();
    
                                await provider.externalTransfer(context);
    
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                  isLoading = false;
                                });
                              } else {
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                  isLoading = false;
                                });
                              }
                            },
                            text: provider.userBankName == null
                                ? "Verify User"
                                : "Continue",
                            reuse: true)
                      ],
                    ),
                  ),
                ),
                if(gettingBanks)Container(
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
