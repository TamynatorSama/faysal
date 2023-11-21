// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/app_navigator.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/creation/create_savings.dart';
import 'package:faysal/pages/rotating_savings/join_savings/join_main.dart';
import 'package:faysal/pages/rotating_savings/manage/manage_savings.dart';
import 'package:faysal/pages/rotating_savings/my_ajo/my_ajo_main.dart';
import 'package:faysal/pages/rotating_savings/myajo_view.dart';
import 'package:faysal/pages/rotating_savings/widget/rotating_savings_card.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/dynamic_links.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RotatingSavings extends StatefulWidget {
  const RotatingSavings({super.key});

  @override
  State<RotatingSavings> createState() => _RotatingSavingsState();
}

class _RotatingSavingsState extends State<RotatingSavings> {
  late SavingsProvider provider;
  bool isLoading = false;

  @override
  void initState() {
    provider = Provider.of<SavingsProvider>(context, listen: false);
    getData();
    super.initState();
  }


  Future getData() async{
    setState(() {
      isLoading = true;
    });
    await provider.getMyRotationalSavings(context);
    setState(() {
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async{
        if(DynamicLinkHandler().fromLogin){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AppNavigator()));
        }
        return true;
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: Scaffold(
            backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
            body: RefreshIndicator(
                  onRefresh: ()async{
                    await getData();
                  },
                  child:Consumer<SavingsProvider>(
              builder: (context,provider,child) {
                return  WidgetBackgorund(
                      home: true,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Column(children: [
                            CustomNavBar(header: "Rotating Savings",customCall: DynamicLinkHandler().fromLogin ? (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AppNavigator()));
                      }:null,),
                            Expanded(
                                child: ScrollConfiguration(
                                    behavior: const ScrollBehavior()
                                        .copyWith(overscroll: false),
                                    child: SingleChildScrollView(
                                      physics: const AlwaysScrollableScrollPhysics(),
                                      child: Column(children: [
                                        Container(
                                          width: double.maxFinite,
                                          height: 160,
                                          margin:
                                              EdgeInsets.only(top: size.height * 0.05),
                                          decoration: BoxDecoration(
                                              color: MyFaysalTheme.of(context)
                                                  .secondaryColor,
                                              borderRadius: BorderRadius.circular(20),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/savings_main.png"),
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment(0, -0.3))),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.symmetric(vertical: 30.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateRotationalSavings())),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: size.longestSide * 0.065,
                                                      height: size.longestSide * 0.065,
                                                      alignment: Alignment.center,
                                                      constraints: const BoxConstraints(
                                                          maxHeight: 56,
                                                          maxWidth: 56,
                                                          minHeight: 40,
                                                          minWidth: 40),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  size.longestSide *
                                                                      0.017),
                                                          color: MyFaysalTheme.of(context)
                                                              .secondaryColor),
                                                      child: Icon(Icons.add,
                                                          color: MyFaysalTheme.of(context)
                                                              .primaryText,
                                                          size: size.longestSide * 0.04 >
                                                                  32
                                                              ? 26
                                                              : size.longestSide * 0.04 <
                                                                      24
                                                                  ? 23
                                                                  : size.longestSide *
                                                                      0.04),
                                                    ),
                                                    // images/Transfer.svg
                                                    Text("Create Ajo",
                                                        maxLines: 1,
                                                        style: MyFaysalTheme.of(context)
                                                            .text1
                                                            .override(
                                                                lineHeight: 2,
                                                                fontSize:
                                                                    size.width * 0.034)),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const JoinRotatingSavings())),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        width: size.longestSide * 0.062,
                                                        height: size.longestSide * 0.062,
                                                        padding: EdgeInsets.all(
                                                            size.width> 600?15:size.width * 0.03),
                                                        constraints: const BoxConstraints(
                                                            maxHeight: 56,
                                                            maxWidth: 56,
                                                            minHeight: 40,
                                                            minWidth: 40),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    size.longestSide *
                                                                        0.017),
                                                            color:
                                                                MyFaysalTheme.of(context)
                                                                    .secondaryColor),
                                                        child: SvgPicture.asset(
                                                          "assets/svg/multiuser.svg",
                                                          color: MyFaysalTheme.of(context)
                                                              .primaryText,
                                                        )),
                                                    SizedBox(
                                                      width: 58,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top:8.0),
                                                        child: Text("Join Ajo",
                                                            textAlign: TextAlign.center,
                                                            style: MyFaysalTheme.of(context)
                                                                .text1
                                                                .override(
                                                                    lineHeight: 1,
                                                                    fontSize: size.width * 0.033 > 15
                                                                                                      ? size.width > 600 ? 30:15
                                                                                                      : size.width * 0.033)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const ManageSavings())),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        width: size.longestSide * 0.062,
                                                        height: size.longestSide * 0.062,
                                                        padding: EdgeInsets.all(
                                                            size.width> 600?15:size.width * 0.03 ),
                                                        constraints: const BoxConstraints(
                                                            maxHeight: 56,
                                                            maxWidth: 56,
                                                            minHeight: 40,
                                                            minWidth: 40),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    size.longestSide *
                                                                        0.017),
                                                            color:
                                                                MyFaysalTheme.of(context)
                                                                    .secondaryColor),
                                                        child: SvgPicture.asset(
                                                          "assets/svg/grid.svg",
                                                          color: MyFaysalTheme.of(context)
                                                              .primaryText,
                                                        )
                                                        // Icons.sync_alt_outlined
                                                        ),
                                                    Text("Manage Ajo",
                                                        style: MyFaysalTheme.of(context)
                                                            .text1
                                                            .override(
                                                                lineHeight: 2,
                                                                fontSize:
                                                                    size.width * 0.034)),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyRotatingSavings(autoFocus: false,))),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        width: size.longestSide * 0.062,
                                                        height: size.longestSide * 0.062,
                                                        constraints: const BoxConstraints(
                                                            maxHeight: 56,
                                                            maxWidth: 56,
                                                            minHeight: 40,
                                                            minWidth: 40),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    size.longestSide *
                                                                        0.017),
                                                            color:
                                                                MyFaysalTheme.of(context)
                                                                    .secondaryColor),
                                                        child: Icon(Icons.lock,
                                                            color:
                                                                MyFaysalTheme.of(context)
                                                                    .primaryText,
                                                            size: size.longestSide *
                                                                        0.04 >
                                                                    32
                                                                ? 26
                                                                : size.longestSide *
                                                                            0.04 <
                                                                        24
                                                                    ? 23
                                                                    : size.longestSide *
                                                                        0.04)),
                                                    Text(
                                                      "My Ajo",
                                                      style: MyFaysalTheme.of(context)
                                                          .text1
                                                          .override(
                                                              lineHeight: 2,
                                                              fontSize:
                                                                  size.width * 0.034),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: TextField(
                                            keyboardType: TextInputType.none,
                                            decoration: InputDecoration(
                                              hintText: "Search Ajo by ID or Name",
                                              
                                              hintStyle: MyFaysalTheme.of(context)
                                                  .splashHeaderText
                                                  .override(fontSize: size.width * 0.045),
                                              filled: true,
                                              contentPadding: const EdgeInsets.all(15),
                                              prefixIcon: Container(
                                                  padding:
                                                      EdgeInsets.all(size.width * 0.03 < 15 ? 15:size.width * 0.03),
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
                                            onTap: ()async{
                                             await Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyRotatingSavings(autoFocus: true,)));
                                            
                                             },
                                            style: MyFaysalTheme.of(context)
                                                .splashHeaderText
                                                .override(fontSize: size.width * 0.045),
                                          ),
                                        ),
                                        
                                        Container(
                                          width: double.maxFinite,
                                          margin:
                                              const EdgeInsets.only(top: 40, bottom: 30),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 25, horizontal: 15),
                                          decoration: BoxDecoration(
                                              color: MyFaysalTheme.of(context)
                                                  .secondaryColor,
                                              borderRadius: BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 22),
                                                child: GestureDetector(
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyRotatingSavings(autoFocus: false,))),
                                                  child: Row(
                                                    children: [
                                                      AutoSizeText("Community Savings",
                                                          style: MyFaysalTheme.of(context)
                                                              .splashHeaderText
                                                              .override(
                                                                fontSize: size.width * 0.037,
                                                              )),
                                                      Container(
                                                          width: 15,
                                                          height: 15,
                                                          margin:
                                                              const EdgeInsets.only(left: 10),
                                                          padding: const EdgeInsets.all(2),
                                                          decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Color(0xff64857D)),
                                                          child: const FittedBox(
                                                              child: Icon(Icons
                                                                  .arrow_forward_ios_rounded)))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              isLoading? Padding(
                                                padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
                                                child: const LoadingScreen(),
                                              ) :provider.mySavings.isEmpty? 
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset("assets/svg/empty.svg",width: size.width * 0.27,color: MyFaysalTheme.of(context).primaryColor,),
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 10.0,bottom: 5),
                                                            child: Text("Oops, Nothing here :(",style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: size.width * 0.05),),
                                                          ),
                                                          ConstrainedBox(
                                                            constraints: BoxConstraints(maxWidth: size.width * 0.55),
                                                            child: Text("There seems to be no community savings at the moment",textAlign: TextAlign.center,style: MyFaysalTheme.of(context).text1.override(fontSize: size.width * 0.033,color: Colors.white.withOpacity(0.3)),)),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                              :Wrap(
                                                runSpacing: 20,
                                                children: List.generate(
                                                     provider.mySavings.length > 2?2 :provider.mySavings.length,
                                                    (index) => InkWell(
                                                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleAjoView(savings: provider.mySavings[index]))),
                                                      child: RotatingSavingsCard(
                                                        ajoTypeId:provider.mySavings[index].ajo.ajoTypeId,
                                                          createdAt: DateTime.parse(provider.mySavings[index].ajo.createdAt),
                                                            name: provider.mySavings[index].ajo.name,
                                                            start: DateTime.parse(provider.mySavings[index].ajo.startedAt),
      
                                                            bgColor: index ~/ 2 == 0 &&
                                                                    index != 0
                                                                ? MyFaysalTheme.of(context)
                                                                    .accentColor
                                                                : index ~/ 3 == 0 &&
                                                                        index != 0
                                                                    ? const Color(
                                                                        0xffFFDF6C)
                                                                    : MyFaysalTheme.of(
                                                                            context)
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
              }
               
            ))),
      ),
    );
  }
}
