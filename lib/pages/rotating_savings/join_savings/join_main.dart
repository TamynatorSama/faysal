import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/join_savings/all_savings.dart';
import 'package:faysal/pages/rotating_savings/join_savings/single_join_view.dart';
import 'package:faysal/pages/rotating_savings/widget/rotating_savings_card.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class JoinRotatingSavings extends StatefulWidget {
  const JoinRotatingSavings({super.key});

  @override
  State<JoinRotatingSavings> createState() => _JoinRotatingSavingsState();
}

class _JoinRotatingSavingsState extends State<JoinRotatingSavings> {
  late SavingsProvider provider;
  bool isLoading = false;

  @override
  void initState() {
    provider = Provider.of<SavingsProvider>(context, listen: false);
    getData();
    super.initState();
  }

  Future getData() async {
    setState(() {
      isLoading = true;
    });
    await provider.getPublicRotationalSavings(context);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: Scaffold(
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body: RefreshIndicator(
            onRefresh: getData,
            child: Consumer<SavingsProvider>(builder: (context, provider, child) {
              return WidgetBackgorund(
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
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  child: Column(children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.05),
                                      child: Column(
                                        children: [
                                          Text("Join Ajo",
                                              style: MyFaysalTheme.of(context)
                                                  .splashHeaderText
                                                  .override(
                                                      fontSize:
                                                          size.width * 0.06)),
                                          Text("Find a community ajo to join",
                                              style: MyFaysalTheme.of(context)
                                                  .splashHeaderText
                                                  .override(
                                                      fontSize:
                                                          size.width * 0.045,
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: TextField(
                                        keyboardType: TextInputType.none,
                                        decoration: InputDecoration(
                                          hintText: "Search AjoID",
                                          
                                          hintStyle: MyFaysalTheme.of(context)
                                              .splashHeaderText
                                              .override(
                                                  fontSize: size.width * 0.04,
                                                  color: Colors.white
                                                      .withOpacity(0.3)),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          prefixIcon: Container(
                                              padding: EdgeInsets.all(
                                                  size.width * 0.03 < 15
                                                      ? 15
                                                      : size.width * 0.03),
                                              child: SvgPicture.asset(
                                                  "assets/svg/Search.svg")),
                                              
                                          // prefixIconConstraints: const BoxConstraints(maxHeight: 50,maxWidth: 50),
                                          // prefix: Padding(
                                          //   padding: const EdgeInsets.only(right: 8.0),
                                          //   child: SvgPicture.asset("assets/svg/Search.svg"),
                                          // ),
                                          fillColor: const Color(0xff123F33),
                                          border: InputBorder.none,
                                        ),
                                        onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AllRotationalSavings(autoFocus: true,))),
                                        style: MyFaysalTheme.of(context)
                                            .splashHeaderText
                                            .override(
                                                fontSize: size.width * 0.045),
                                      ),
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 30),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25, horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: MyFaysalTheme.of(context)
                                              .secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(bottom: 22),
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AllRotationalSavings(autoFocus: false,))),
                                              child: Row(
                                                children: [
                                                  AutoSizeText(
                                                      "Community Savings",
                                                      style: MyFaysalTheme.of(
                                                              context)
                                                          .splashHeaderText
                                                          .override(
                                                            fontSize: size.width *
                                                                0.037,
                                                          )),
                                                  Container(
                                                      width: 15,
                                                      height: 15,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      padding:
                                                          const EdgeInsets.all(2),
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape:
                                                                  BoxShape.circle,
                                                              color: Color(
                                                                  0xff64857D)),
                                                      child: const FittedBox(
                                                          child: Icon(Icons
                                                              .arrow_forward_ios_rounded)))
                                                ],
                                              ),
                                            ),
                                          ),
                                          isLoading
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          size.height * 0.05),
                                                  child: const LoadingScreen(),
                                                )
                                              : provider.allSavings.isEmpty
                                                  ? Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 20.0),
                                                        child: Column(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/svg/empty.svg",
                                                              width: size.width *
                                                                  0.27,
                                                              color: MyFaysalTheme
                                                                      .of(context)
                                                                  .primaryColor,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10.0,
                                                                          bottom:
                                                                              5),
                                                                  child: Text(
                                                                    "Oops, Nothing here :(",
                                                                    style: MyFaysalTheme.of(
                                                                            context)
                                                                        .splashHeaderText
                                                                        .override(
                                                                            fontSize:
                                                                                size.width * 0.05),
                                                                  ),
                                                                ),
                                                                ConstrainedBox(
                                                                    constraints: BoxConstraints(
                                                                        maxWidth:
                                                                            size.width *
                                                                                0.55),
                                                                    child: Text(
                                                                      "There seems to be no community savings at the moment",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: MyFaysalTheme.of(context).text1.override(
                                                                          fontSize:
                                                                              size.width *
                                                                                  0.033,
                                                                          color: Colors
                                                                              .white
                                                                              .withOpacity(0.3)),
                                                                    )),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Wrap(
                                                      runSpacing: 20,
                                                      children: List.generate(
                                                          provider.allSavings
                                                                      .length <
                                                                  2
                                                              ? provider
                                                                  .allSavings
                                                                  .length
                                                              : 2,
                                                          (index) => InkWell(
                                                                onTap: () => Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => SingleJoinView(
                                                                              savings:
                                                                                  provider.allSavings[index],
                                                                            ))),
                                                                child:
                                                                    RotatingSavingsCard(
                                                                      ajoTypeId: provider.allSavings[index].ajoTypeId,
                                                                  name: provider
                                                                      .allSavings[
                                                                          index]
                                                                      .name,
                                                                  createdAt: DateTime
                                                                      .parse(provider
                                                                          .allSavings[
                                                                              index]
                                                                          .createdAt),
                                                                  start: DateTime
                                                                      .parse(provider
                                                                          .allSavings[
                                                                              index]
                                                                          .startedAt),
                                                                  bgColor: index ~/
                                                                                  2 ==
                                                                              0 &&
                                                                          index !=
                                                                              0
                                                                      ? MyFaysalTheme.of(
                                                                              context)
                                                                          .accentColor
                                                                      : index ~/ 3 ==
                                                                                  0 &&
                                                                              index !=
                                                                                  0
                                                                          ? const Color(
                                                                              0xffFFDF6C)
                                                                          : MyFaysalTheme.of(context)
                                                                              .primaryColor,
                                                                ),
                                                              )),
                                                    ),
                                        ],
                                      ),
                                    )
                                  ]),
                                )))
                      ])));
            }),
          )),
    );
  }
}
