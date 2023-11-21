import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/widget/savings_btn.dart';
import 'package:faysal/pages/rotating_savings/creation/savings_information.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CreateRotationalSavings extends StatefulWidget {
  const CreateRotationalSavings({super.key});

  @override
  State<CreateRotationalSavings> createState() =>
      _CreateRotationalSavingsState();
}

class _CreateRotationalSavingsState extends State<CreateRotationalSavings> {
  TextEditingController ajoNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    ajoNameController.dispose();
    super.dispose();
  }

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
        body: Consumer<SavingsProvider>(builder: (context, provider, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
            child: WidgetBackgorund(
                home: true,
                child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(children: [
                      const CustomNavBar(header: "Rotating Savings"),
                      Expanded(
                          child: ScrollConfiguration(
                              behavior: const ScrollBehavior()
                                  .copyWith(overscroll: false),
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: size.height * 0.05),
                                    child: Column(
                                      children: [
                                        Text("Oya, Let’s Start!",
                                            style: MyFaysalTheme.of(context)
                                                .splashHeaderText
                                                .override(
                                                    fontSize: size.width * 0.06)),
                                        Text("Create your Ajo",
                                            style: MyFaysalTheme.of(context)
                                                .splashHeaderText
                                                .override(
                                                    fontSize: size.width * 0.045,
                                                    color: Colors.white
                                                        .withOpacity(0.4),
                                                    lineHeight: 1.5))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 160,
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 30),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFDF6C),
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/flat_tree_illustration_with_full_leaves_on_blank_back_a0db54ad-f1d9-44f9-a294-629031aff3de 1.png"),
                                            fit: BoxFit.cover,
                                            // scale: 0.2,
                                            alignment: Alignment(1, -1))),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: TextFormField(
                                        controller: ajoNameController,
                                          cursorColor: Colors.white,
                                          style: MyFaysalTheme.of(context)
                                              .textFieldText,
                                          decoration: InputDecoration(
                                              labelText:
                                                  "Rotational Savings name",
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
                                              hintText: "E.g Group Saving",
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
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      if (constraints.maxWidth > 280) {
                                        return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                                2,
                                                (index) => InkWell(
                                                      onTap: () => setState(() {
                                                        selectedIndex = index;
                                                        provider.ajoType = (index+1).toString();
                                                      }),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            width: size.width *
                                                                        0.39 <
                                                                    153
                                                                ? size.width *
                                                                    0.41
                                                                : size.width *
                                                                    0.42,
                                                            height: size.width *
                                                                        0.39 <
                                                                    153
                                                                ? size.width *
                                                                    0.41
                                                                : size.width *
                                                                    0.42,
                                                            decoration: BoxDecoration(
                                                                color: MyFaysalTheme.of(context)
                                                                    .secondaryColor,
                                                                border: selectedIndex == index
                                                                    ? Border.all(
                                                                        width: 1,
                                                                        color: MyFaysalTheme.of(context)
                                                                            .primaryColor)
                                                                    : null,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        size.width *
                                                                            0.03),
                                                                image: DecorationImage(
                                                                    image: AssetImage(index == 0
                                                                        ? "assets/images/Community_savings.png"
                                                                        : "assets/images/solo_savings.png"),
                                                                    alignment:
                                                                        Alignment.topCenter)),
                                                          ),
                                                          Container(
                                                            width: size.width *
                                                                        0.39 <
                                                                    153
                                                                ? size.width *
                                                                    0.41
                                                                : size.width *
                                                                    0.42,
                                                            height: size.width *
                                                                        0.39 <
                                                                    153
                                                                ? size.width *
                                                                    0.41
                                                                : size.width *
                                                                    0.42,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        size.width *
                                                                            0.03),
                                                                gradient: LinearGradient(
                                                                    colors: [
                                                                      MyFaysalTheme.of(
                                                                              context)
                                                                          .secondaryColor,
                                                                      Colors
                                                                          .transparent
                                                                    ],
                                                                    begin: Alignment
                                                                        .bottomCenter,
                                                                    end: Alignment
                                                                        .topCenter,
                                                                    stops: const [
                                                                      0.2,
                                                                      0.7
                                                                    ])),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  index == 0
                                                                      ? SvgPicture
                                                                          .asset(
                                                                          "assets/svg/multiuser.svg",
                                                                          color: MyFaysalTheme.of(context)
                                                                              .primaryText,
                                                                        )
                                                                      : SvgPicture
                                                                          .asset(
                                                                          "assets/svg/user.svg",
                                                                          color: MyFaysalTheme.of(context)
                                                                              .primaryText,
                                                                        ),
                                                                  index == 0
                                                                      ? Text(
                                                                          "Community Ajo",
                                                                          style: MyFaysalTheme.of(context).splashHeaderText.override(
                                                                              fontSize:
                                                                                  14,
                                                                              lineHeight:
                                                                                  2),
                                                                        )
                                                                      : Text(
                                                                          "Solo Ajo",
                                                                          style: MyFaysalTheme.of(context).splashHeaderText.override(
                                                                              fontSize:
                                                                                  14,
                                                                              lineHeight:
                                                                                  2))
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )));
                                      } else {
                                        return Wrap(
                                            runSpacing: 15,
                                            children: List.generate(
                                                2,
                                                (index) => InkWell(
                                                      onTap: () => setState(() {
                                                        selectedIndex = index;
                                                        provider.ajoType = (index+1).toString();
                                                      }),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.maxFinite,
                                                            height: 150,
                                                            decoration: BoxDecoration(
                                                                color: MyFaysalTheme.of(context)
                                                                    .secondaryColor,
                                                                border: selectedIndex == index
                                                                    ? Border.all(
                                                                        width: 1,
                                                                        color: MyFaysalTheme.of(context)
                                                                            .primaryColor)
                                                                    : null,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        size.width *
                                                                            0.03),
                                                                image: DecorationImage(
                                                                    image: AssetImage(index == 0
                                                                        ? "assets/images/Community_savings.png"
                                                                        : "assets/images/solo_savings.png"),
                                                                    alignment:
                                                                        Alignment.topCenter)),
                                                          ),
                                                          Container(
                                                            width:
                                                                double.maxFinite,
                                                            height: 150,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        size.width *
                                                                            0.03),
                                                                gradient: LinearGradient(
                                                                    colors: [
                                                                      MyFaysalTheme.of(
                                                                              context)
                                                                          .secondaryColor,
                                                                      Colors
                                                                          .transparent
                                                                    ],
                                                                    begin: Alignment
                                                                        .bottomCenter,
                                                                    end: Alignment
                                                                        .topCenter,
                                                                    stops: const [
                                                                      0.2,
                                                                      0.7
                                                                    ])),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  index == 0
                                                                      ? SvgPicture
                                                                          .asset(
                                                                          "assets/svg/multiuser.svg",
                                                                          color: MyFaysalTheme.of(context)
                                                                              .primaryText,
                                                                        )
                                                                      : SvgPicture
                                                                          .asset(
                                                                          "assets/svg/user.svg",
                                                                          color: MyFaysalTheme.of(context)
                                                                              .primaryText,
                                                                        ),
                                                                  index == 0
                                                                      ? Text(
                                                                          "Community Ajo",
                                                                          style: MyFaysalTheme.of(context).splashHeaderText.override(
                                                                              fontSize:
                                                                                  14,
                                                                              lineHeight:
                                                                                  2),
                                                                        )
                                                                      : Text(
                                                                          "Solo Ajo",
                                                                          style: MyFaysalTheme.of(context).splashHeaderText.override(
                                                                              fontSize:
                                                                                  14,
                                                                              lineHeight:
                                                                                  2))
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )));
                                      }
                                    }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.1, bottom: 20),
                                    child: SavingsButton(
                                        text: "Next",
                                        call: () {
                                          if (_formKey.currentState == null ||
                                              !_formKey.currentState!
                                                  .validate()) {
                                            return;
                                          }
                                          provider.ajoName =
                                              ajoNameController.text;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SavingsInformation()));
                                        }),
                                  )
                                ]),
                              )))
                    ]))),
          );
        }));
  }
}
