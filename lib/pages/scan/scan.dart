// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/provider/qr_scan_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class ScanToPay extends StatefulWidget {
  const ScanToPay({super.key});

  @override
  State<ScanToPay> createState() => _ScanToPayState();
}

class _ScanToPayState extends State<ScanToPay> {

  MobileScannerController? qrScanner;
  bool isLoading = false;
  late QrScanProvider qrScanProvider;
  bool scanned = false;
  
  @override
  void initState() {
    qrScanProvider = Provider.of<QrScanProvider>(context,listen: false);
   qrScanner =
        MobileScannerController(facing: CameraFacing.back, torchEnabled: false);
    
  qrScanner!.autoStart;

    super.initState();
  }

  @override 
  void deactivate(){
    qrScanner!.stop();

    super.deactivate();
  }

  @override
  void dispose() {
    qrScanner!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top < 30
                  ? size.height * 0.1 > 70
                      ? 70
                      : size.height * 0.05
                  : MediaQuery.of(context).padding.top + 20,
              left: 24,
              right: 24),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(),
              Text(
                "Scan QR to Pay",
                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: 20),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: size.longestSide * 0.36,
                            width: size.longestSide * 0.36,
                            child: MobileScanner(
                              controller: qrScanner,
                              onDetect: (barcode) async{
                                if (barcode.barcodes.first.rawValue == null){
                        debugPrint('Failed to scan Barcode');
                      } else {
                        Future.delayed(const Duration(minutes: 7),()async{
                          await qrScanProvider.cancelTransaction(
                                          qrScanProvider.transactionRef, context,true);
                          
                          Provider.of<QrScanProvider>(context,listen: false).isLoading = false;
                                          setState(() {
                                            
                                          });
                                          showToast(context, "Reciever took too long to respond");
                                          return;
                        });
                        if(scanned) return;
                        scanned == true;
                        final String code = barcode.barcodes.first.rawValue!;
                        var result = jsonDecode(code);
                        if(result["ref"] == null || !result["ref"].toString().contains("faysal") )return;
                        qrScanProvider.transactionRef = result["ref"];
                        var response = await qrScanProvider.acceptTransaction(result["ref"],context);
                        if(response){
                          qrScanProvider.checkScanStatus(context,result["ref"],false,(() async{
                            await showTransferSuccess(qrScanProvider.qrcode.sender.name, result["amount"],null,true);
                          
                        }));
                        }
                        
                      }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.03, bottom: 20),
                          child: Image.asset("assets/images/long.png",width: size.width * 0.2,),
                        ),
                        Text("Pay with QR Code",style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: size.width * 0.06),),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: size.width * 0.6),
                            child: AutoSizeText("Hold the code inside the frame, it will be scanned automatically",maxLines: 2,textAlign: TextAlign.center,style: MyFaysalTheme.of(context).text1.override(fontSize: size.width * 0.24,color: Colors.white.withOpacity(0.5)),)),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top:20.0),
                        //   child: ConstrainedBox(
                        //     constraints: const BoxConstraints(maxWidth: 250),
                        //     child: TopupWalletBtn(call: (){
                        //       Navigator.push(context, MaterialPageRoute(builder: (context)=> const QrAmount()));
                        //     }, text: "Generate Qr", icon: """<svg width="24" height="20" viewBox="0 0 24 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        //   <path d="M22.5 10.8057H1.5" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        //   <path d="M20.6299 6.5951V5.0821C20.6299 3.0211 18.9589 1.3501 16.8969 1.3501H15.6919" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        //   <path d="M3.37012 6.5951V5.0821C3.37012 3.0211 5.04112 1.3501 7.10312 1.3501H8.33912" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        //   <path d="M20.6299 10.8047V14.8787C20.6299 16.9407 18.9589 18.6117 16.8969 18.6117H15.6919" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        //   <path d="M3.37012 10.8047V14.8787C3.37012 16.9407 5.04112 18.6117 7.10312 18.6117H8.33912" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        //   </svg>
                        //   """),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
        Provider.of<QrScanProvider>(context).isLoading ? BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
          child: Container(
                width: double.maxFinite,
                height: size.height,
                color: const Color.fromARGB(181, 0, 0, 0),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LoadingScreen(),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 250),
                        child: Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("Waiting for confirmation from sender",textAlign: TextAlign.center,style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: 15),),
                        ),
                
                      ),
                      
                    ],
                  ),
                ),
              ),
        )
            :const Offstage(),
          //  Provider.of<QrScanProvider>(context).isLoading ? Align(
          //               alignment: const AlignmentDirectional(0,0.7),
          //               child: InkWell(
          //                 onTap: () async{
                            // await qrScanProvider.cancelTransaction(
                            //               qrScanProvider.transactionRef, context);
                                          // Provider.of<QrScanProvider>(context,listen: false).isLoading = false;
                                          // setState(() {
                                            
                                          // });
                                          
          //                 },
          //                 child: Text("Taking too long? Cancel",textAlign: TextAlign.center,style: MyFaysalTheme.of(context).promtHeaderText.override(fontSize: 15,decoration: TextDecoration.underline),)),
          //             ):const Offstage()
      ],
    );
  }
}
