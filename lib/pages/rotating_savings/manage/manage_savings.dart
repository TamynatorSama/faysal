import 'package:faysal/models/rotational_savings.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/coordinator_view.dart';
import 'package:faysal/pages/rotating_savings/widget/rotating_savings_card.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/colors.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ManageSavings extends StatefulWidget {
  const ManageSavings({super.key});

  @override
  State<ManageSavings> createState() => _ManageSavingsState();
}

class _ManageSavingsState extends State<ManageSavings> {
  late SavingsProvider provider;
  bool isLoading = false;
  bool isRefresh = false;

  @override
  void initState() {
    provider = Provider.of<SavingsProvider>(context, listen: false);
    getData();
    super.initState();
  }

  Future getData() async {
    if (!isRefresh && provider.allSavings.isEmpty) {
      setState(() {
        isLoading = true;
      });
    }
    await provider.getPublicRotationalSavings(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
          child: RefreshIndicator(onRefresh: () async {
            isRefresh = true;
            await getData();
          }, child:
              Consumer<SavingsProvider>(builder: (context, provider, child) {
            return WidgetBackgorund(
                home: true,
                child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(children: [
                      const CustomNavBar(header: "Rotating Savings"),
                      isLoading
                          ? const Expanded(
                              child: Center(child: LoadingScreen()))
                          : provider.allSavings
                                  .where((element) =>
                                      element.userId ==
                                      Provider.of<ProfileProvider>(context,
                                              listen: false)
                                          .userProfile
                                          .id)
                                  .toList()
                                  .isEmpty
                              ? Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/empty.svg",
                                            width: size.width * 0.27,
                                            color: MyFaysalTheme.of(context)
                                                .primaryColor,
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, bottom: 5),
                                                child: Text(
                                                  "Oops, Nothing here :(",
                                                  style: MyFaysalTheme.of(context)
                                                      .splashHeaderText
                                                      .override(
                                                          fontSize:
                                                              size.width * 0.05),
                                                ),
                                              ),
                                              ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          size.width * 0.55),
                                                  child: Text(
                                                    "It seems you have not created any rotational savings community",
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        MyFaysalTheme.of(context)
                                                            .text1
                                                            .override(
                                                                fontSize:
                                                                    size.width *
                                                                        0.033,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.3)),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ScrollConfiguration(
                                      behavior: const ScrollBehavior()
                                          .copyWith(overscroll: false),
                                      child: SingleChildScrollView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 35.0),
                                            child: Wrap(
                                                runSpacing: 20,
                                                children: List.generate(
                                                    provider.allSavings
                                                        .where((element) =>
                                                            element.userId ==
                                                            Provider.of<ProfileProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .userProfile
                                                                .id)
                                                        .toList()
                                                        .length, (index) {
                                                  List<RotationalSavingsModel>
                                                      willUse = provider
                                                          .allSavings
                                                          .where((element) =>
                                                              element.userId ==
                                                              Provider.of<ProfileProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .userProfile
                                                                  .id)
                                                          .toList();
                                                  return InkWell(
                                                     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> SavingsCoordinatorView(savings: willUse[index], ))),
                                                    child: RotatingSavingsCard(
                                                      ajoTypeId: willUse[index].ajoTypeId,
                                                      createdAt: DateTime.parse(
                                                          willUse[index].createdAt),
                                                      name: willUse[index].name,
                                                      start: DateTime.parse(
                                                          willUse[index].startedAt),
                                                      bgColor: list[int.parse(
                                                          generateAvatar(
                                                              index.toString(),
                                                              true))],
                                                    ),
                                                  );
                                                })),
                                          ))))
                    ])));
          })),
        ));
  }
}
