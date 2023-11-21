import 'package:faysal/models/rotational_savings.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/myajo_view.dart';
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

class MyRotatingSavings extends StatefulWidget {
  final bool autoFocus;
  const MyRotatingSavings({super.key, required this.autoFocus });

  @override
  State<MyRotatingSavings> createState() => _MyRotatingSavingsState();
}

class _MyRotatingSavingsState extends State<MyRotatingSavings> {
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
    if (!isRefresh && provider.mySavings.isEmpty) {
      setState(() {
        isLoading = true;
      });
    }
    await provider.getMyRotationalSavings(context);
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
          data: MediaQuery.of(context).copyWith(
              textScaleFactor:
                  MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
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
                          : provider.mySavings.isEmpty || provider.mySavings.where((element) => element
                                                            .ajo.ajoCode
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                  style:
                                                      MyFaysalTheme.of(context)
                                                          .splashHeaderText
                                                          .override(
                                                              fontSize:
                                                                  size.width *
                                                                      0.05),
                                                ),
                                              ),
                                              ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          size.width * 0.55),
                                                  child: Text(
                                                    provider.mySavings.where((element) => element
                                                            .ajo.ajoCode
                                                            .toUpperCase()
                                                            .contains(
                                                                searchController
                                                                    .text
                                                                    .toUpperCase()))
                                                        .toList().isEmpty? "You have not joint any Rotational Savings community with the code: ${searchController.text}" :"It seems you have not joined any rotational savings community",
                                                    textAlign: TextAlign.center,
                                                    style: MyFaysalTheme.of(
                                                            context)
                                                        .text1
                                                        .override(
                                                            fontSize:
                                                                size.width *
                                                                    0.033,
                                                            color: Colors.white
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
                                                    provider.mySavings
                                                        .where((element) => element
                                                            .ajo.ajoCode
                                                            .toUpperCase()
                                                            .contains(
                                                                searchController
                                                                    .text
                                                                    .toUpperCase()))
                                                        .toList()
                                                        .length, (index) {
                                                  List<MyRotationalSavingsModel>
                                                      willUse = provider
                                                          .mySavings.where((element) => element
                                                            .ajo.ajoCode
                                                            .toUpperCase()
                                                            .contains(
                                                                searchController
                                                                    .text
                                                                    .toUpperCase()))
                                                        .toList();
                                                  return InkWell(
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SingleAjoView(
                                                                    savings:
                                                                        willUse[
                                                                            index]))),
                                                    child: RotatingSavingsCard(
                                                      ajoTypeId: willUse[index].ajo.ajoTypeId,
                                                      createdAt: DateTime.parse(
                                                          willUse[index]
                                                              .ajo
                                                              .createdAt),
                                                      name: willUse[index]
                                                          .ajo
                                                          .name,
                                                      start: DateTime.parse(
                                                          willUse[index]
                                                              .ajo
                                                              .startedAt),
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
