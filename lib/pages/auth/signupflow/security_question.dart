
import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_btn.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_success_background.dart';
import 'package:faysal/pages/topup/widgets/custom_text_fields.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/services/http_class.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SetSequrityQuestion extends StatefulWidget {
  const SetSequrityQuestion({super.key});

  @override
  State<SetSequrityQuestion> createState() => _SetSequrityQuestionState();
}

class _SetSequrityQuestionState extends State<SetSequrityQuestion> {
  late ProfileProvider provider;
  TextEditingController answerController = TextEditingController();
  bool isLoadingQuestion = false;
  bool isLoading = false;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    getData();
    super.initState();
  }

  getData() async {
    if (provider.questions.isNotEmpty) return;
    setState(() {
      isLoadingQuestion = true;
    });
    await provider.getQuestions();
    setState(() {
      isLoadingQuestion = false;
    });
  }

  String question = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
          child: Scaffold(
            backgroundColor: MyFaysalTheme.of(context).secondaryColor,
            body: Consumer<ProfileProvider>(builder: (context, provider, child) {
              return SavingsBackground(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const CustomNavBar(header: "Security",hide: true,),
                        Expanded(
                            child: ScrollConfiguration(
                          behavior:
                              const ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.height * 0.038),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: AutoSizeText(
                                          "Set Security Question",
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: MyFaysalTheme.of(context)
                                              .splashHeaderText
                                              .override(fontSize: 20),
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: size.width * 0.68),
                                        child: AutoSizeText(
                                          "This would serve as a subsequent means to update information or access your Faysal account ",
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: MyFaysalTheme.of(context)
                                              .text1
                                              .override(
                                                  color: Colors.white
                                                      .withOpacity(0.4)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: DropdownButtonFormField<dynamic>(
                                      dropdownColor:
                                          MyFaysalTheme.of(context).secondaryColor,
                                      iconSize: 0,
                                      decoration: InputDecoration(
                                          labelText: "Security Question",
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
                                          fillColor: const Color(0xff123F33),
                                          filled: true,
                                          contentPadding: const EdgeInsets.all(10),
                                          hintText: "Select Security Question",
                                          hintStyle: MyFaysalTheme.of(context)
                                              .textFieldText,
                                          border: InputBorder.none),
                                      style:
                                          MyFaysalTheme.of(context).textFieldText,
                                      items: List.generate(
                                          provider.questions.length,
                                          (index) => DropdownMenuItem<dynamic>(
                                              value: provider.questions[index],
                                              child:
                                                  Text(provider.questions[index]))),
                                      onChanged: (value) {
                                        question = value.toString();
                                      },
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: CustomTextField(
                                      label: "Answer",
                                      suffix: false,
                                      inputType: TextInputType.name,
                                      format: const [],
                                      controller: answerController),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        )),
                        SavingsButton(
                          isLoading: isLoading ? true:null,
                          text: "Set Question", call: ()async{
                              if (isLoading) return;
                            setState(() {
                              isLoading = true;
                            });
        
                            var response = await HttpResponse()
                                .setSecurityQuestion(question.toLowerCase().trim(),
                                    answerController.text..toLowerCase().trim());
                            setState(() {
                              isLoading = false;
                            });
        
                            if (response["status"] == 200) {
                              pop();
                              provider
                                  .userProfile
                                  .question = question.trim();
                              FToast().showToast(
                                gravity: ToastGravity.TOP,
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 26, 26, 26),
                                      borderRadius: BorderRadius.circular(3)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 5),
                                  child: Text(
                                    response["data"]["message"],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: "Popppins",
                                        color: Colors.white),
                                  ),
                                ),
                                toastDuration: const Duration(seconds: 3),
                              );
                              
                            } else {
                              FToast().showToast(
                                gravity: ToastGravity.TOP,
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 26, 26, 26),
                                      borderRadius: BorderRadius.circular(3)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 5),
                                  child: Text(
                                    response["data"]["message"],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: "Popppins",
                                        color: Colors.white),
                                  ),
                                ),
                                toastDuration: const Duration(seconds: 3),
                              );
                            }
                        }),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    )),
              );
            }),
          ),
        ),
      ),
    );
  }
  pop(){
    Navigator.pop(context);
  }
}

