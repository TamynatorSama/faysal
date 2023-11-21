import 'package:faysal/models/rotational_savings.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/join_savings/single_join_view.dart';
import 'package:faysal/pages/rotating_savings/widget/rotating_savings_card.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/colors.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AllRotationalSavings extends StatefulWidget {
  final bool autoFocus;
  const AllRotationalSavings({super.key, required this.autoFocus });

  @override
  State<AllRotationalSavings> createState() => _AllRotationalSavingsState();
}

class _AllRotationalSavingsState extends State<AllRotationalSavings> {
  late SavingsProvider provider;
  bool isLoading = false;
  bool isRefresh = false;
  late TextEditingController searchController;

  @override
  void initState() {
    provider = Provider.of<SavingsProvider>(context, listen: false);
    searchController = TextEditingController();
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: Scaffold(
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body: RefreshIndicator(onRefresh: () async {
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.05, bottom: 20),
                        child: Text("My Ajo",
                            style: MyFaysalTheme.of(context)
                                .splashHeaderText
                                .override(
                                    fontSize:
                                        (size.width * 0.07).clamp(18, 26))),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          controller: searchController,
                          autofocus: widget.autoFocus,
                          decoration: InputDecoration(
                            hintText: "Search Ajo by ID or Name",
                            hintStyle: MyFaysalTheme.of(context)
                                .splashHeaderText
                                .override(fontSize: size.width * 0.045),
                            filled: true,
                            contentPadding: const EdgeInsets.all(15),
                            prefixIcon: Container(
                                padding: EdgeInsets.all(size.width * 0.03 < 15
                                    ? 15
                                    : size.width * 0.03),
                                child:
                                    SvgPicture.asset("assets/svg/Search.svg")),
                            fillColor: const Color(0xff123F33),
                            border: InputBorder.none,
                          ),
                          onChanged: (value)=> setState(() {
                            
                          }),
                          style: MyFaysalTheme.of(context)
                              .splashHeaderText
                              .override(fontSize: size.width * 0.045),
                        ),
                      ),
                      
                      isLoading
                          ? const Expanded(
                              child: Center(child: LoadingScreen()))
                          : provider.allSavings
                                  .isEmpty || provider.allSavings.where((element) => element
                                                            .ajoCode
                                                            .toUpperCase()
                                                            .contains(
                                                                searchController
                                                                    .text
                                                                    .toUpperCase()))
                                                        .toList().isEmpty
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
                                                    provider.allSavings.where((element) => element
                                                            .ajoCode
                                                            .toUpperCase()
                                                            .contains(
                                                                searchController
                                                                    .text
                                                                    .toUpperCase()))
                                                        .toList().isEmpty? "There is no community savings with the id: ${searchController.text}": "No public rotational savings is available",
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
                                                    provider.allSavings.where((element) => element
                                                            .ajoCode
                                                            .toUpperCase()
                                                            .contains(
                                                                searchController
                                                                    .text
                                                                    .toUpperCase()))
                                                        .toList().length, (index) {
                                                  List<RotationalSavingsModel>
                                                      willUse = provider.allSavings.where((element) => element
                                                            .ajoCode
                                                            .toUpperCase()
                                                            .contains(
                                                                searchController
                                                                    .text
                                                                    .toUpperCase()))
                                                        .toList();
                                                  return InkWell(
                                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> SingleJoinView(savings: willUse[index], ))),
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
          }))),
    );
  }
}
