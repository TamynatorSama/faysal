import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class TransactionPin extends StatefulWidget {
  const TransactionPin({super.key});

  @override
  State<TransactionPin> createState() => _TransactionPinState();
}

class _TransactionPinState extends State<TransactionPin> {
  late TextEditingController pin;

  @override
  void initState() {
    pin = TextEditingController()..addListener(checkPin);
    super.initState();
  }

  checkPin() {
    setState(() {});
    if (pin.text.length >= 4) {
      Navigator.pop(context,pin.text);
    }
  }

  @override
  void deactivate() {
    pin.removeListener(checkPin);
    super.deactivate();
  }

  @override
  void dispose() {
    pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      alignment: Alignment.center,
      height: size.height * 0.7,
      decoration: BoxDecoration(
          color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.3,
                height: 3,
                margin: const EdgeInsets.only(top: 15, bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white.withOpacity(0.5)),
              )
            ],
          ),
          Text("Transaction Pin",
              style: MyFaysalTheme.of(context)
                  .splashHeaderText
                  .override(fontSize: 19)),
          Text(
            "Confirm your purchase",
            style: MyFaysalTheme.of(context).text1.override(
                color: MyFaysalTheme.of(context).primaryText.withOpacity(0.5)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.025,
            ),
            child: Wrap(
              spacing: 4,
              alignment: WrapAlignment.center,
              children: List.generate(
                  4,
                  (index) => Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: pin.text.length > index ? Colors.white:MyFaysalTheme.of(context)
                                .primaryText
                                .withOpacity(0.5)),
                      )),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width * 0.6),
            child: Wrap(
              runSpacing: size.height < 630
                  ? size.height < 576
                      ? 10
                      : 14
                  : size.height * 0.037,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBlockButton(text: "1",pinController: pin),
                    CustomBlockButton(text: "2",pinController: pin),
                    CustomBlockButton(text: "3",pinController: pin),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBlockButton(text: "4",pinController: pin),
                    CustomBlockButton(text: "5",pinController: pin),
                    CustomBlockButton(text: "6",pinController: pin),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBlockButton(text: "7",pinController: pin),
                    CustomBlockButton(text: "8",pinController: pin),
                    CustomBlockButton(text: "9",pinController: pin),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBlockButton(text: ".",pinController: pin),
                    CustomBlockButton(text: "0",pinController: pin,),
                    GestureDetector(
                      onTap: (){
                        pin.text = pin.text.replaceRange(pin.text.length - 1, null, "");

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.shortestSide * 0.12,
                        height: MediaQuery.of(context).size.shortestSide * 0.12,
                        decoration: BoxDecoration(
                            color: MyFaysalTheme.of(context).overlayColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: MyFaysalTheme.of(context).primaryText,
                        ),
                      ),
                    )
                    // CustomBlockButton(text: "<"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomBlockButton extends StatelessWidget {
  final String text;
  final TextEditingController pinController;
  const CustomBlockButton({super.key, required this.text,required this.pinController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        pinController.text = pinController.text + text;
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.shortestSide * 0.12,
        height: MediaQuery.of(context).size.shortestSide * 0.12,
        decoration: BoxDecoration(
            color: MyFaysalTheme.of(context).overlayColor,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: MyFaysalTheme.of(context).splashHeaderText,
        ),
      ),
    );
  }
}

enum PaymentType { externalTransfer, internalTransfer, airtime, data, tv }
