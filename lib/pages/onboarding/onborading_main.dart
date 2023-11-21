import 'package:faysal/pages/onboarding/widget/first_page.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingMain extends StatefulWidget {
  const OnBoardingMain({super.key});

  @override
  State<OnBoardingMain> createState() => _OnBoardingMainState();
}

class _OnBoardingMainState extends State<OnBoardingMain> {

  late PageController controller;

  List<Map<String,String>> onboardingText = [
    {
      "header": "Saving Made Simple",
      "subtitle": "We offer faster and more efficient ways to save and manage money through various saving methods"
    },
    {
      "header": "Easy Payments",
      "subtitle": "Your payments become easy. You can quickly and easily pay for things like airline tickets, tuition, data, DSTV subscriptions and more"
    },
    {
      "header": "Ease of Use",
      "subtitle": "QR Code scanning technology enables us make your payments process faster"
    }

  ];

  int page = 0;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1, 1.05)),
        child: Stack(
          children: [
            IntrinsicWidth(
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    SvgPicture.asset("assets/svg/background-left.svg",color: Colors.grey,width: MediaQuery.of(context).size.width * 0.6,),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [MyFaysalTheme.of(context).scaffolbackgeroundColor.withOpacity(0.93),MyFaysalTheme.of(context).scaffolbackgeroundColor.withOpacity(0.4)],
                          // colors: [Colors.red,Colors.black],
                          stops: const [0.1,0.6],
                          begin: Alignment.topCenter,
                        )
                      ),
                      ),
                      
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: IntrinsicWidth(
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    SvgPicture.asset("assets/svg/background-right.svg",color: Colors.grey,width: MediaQuery.of(context).size.width * 0.6,),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [MyFaysalTheme.of(context).scaffolbackgeroundColor.withOpacity(0.9),MyFaysalTheme.of(context).scaffolbackgeroundColor.withOpacity(0.4)],
                          // colors: [Colors.red,Colors.black],
                          stops: const [0.7,1],
                          begin: Alignment.topRight,
                        )
                      ),
                      ),
                      
                  ],
                ),
              ),
            ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Image.asset("assets/images/splashImageWithOverlay.png",fit: BoxFit.cover,width: double.maxFinite,),
            ),
            PageView.builder(
              itemCount: onboardingText.length,
              onPageChanged: ((value) => setState(() {
                page = value;
              })),
              itemBuilder: (context,index) => FirstOnboarding(header: onboardingText[index]["header"]!, subtitle: onboardingText[index]["subtitle"]!,page: page,))
          ],
        ),
      ),
    );
  }
}