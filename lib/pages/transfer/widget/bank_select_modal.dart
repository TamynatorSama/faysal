import 'package:faysal/models/bank_model.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BankSelectModal extends StatefulWidget {
  final List<BankModel> banks;
  const BankSelectModal({required this.banks, Key? key}) : super(key: key);

  @override
  State<BankSelectModal> createState() => _BankSelectModalState();
}

class _BankSelectModalState extends State<BankSelectModal> {
  double height = 370.0;
  bool scroll = false;
  int itemCount = 0;
  final ScrollController _controller = ScrollController();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    itemCount = widget.banks.length;
    _controller.addListener(check);
    super.initState();
  }

  void check() {
    if (scroll) return;
    scroll = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInExpo,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      padding: const EdgeInsets.only(
        top: 20,
      ),
      height: scroll ? MediaQuery.of(context).size.height * 0.68 : height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Banks",
                  style: MyFaysalTheme.of(context).promtHeaderText.override(
                      color: Colors.white, fontSize: size.width * 0.06),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: MyFaysalTheme.of(context).primaryText,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Search bank",
                  hintStyle: MyFaysalTheme.of(context)
                      .splashHeaderText
                      .override(fontSize: size.width * 0.045),
                  filled: true,
                  contentPadding: const EdgeInsets.all(15),
                  prefixIcon: Container(
                      padding: EdgeInsets.all(
                          size.width * 0.03 < 15 ? 15 : size.width * 0.03),
                      child: SvgPicture.asset("assets/svg/Search.svg")),
                  fillColor: const Color(0xff123F33),
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() {}),
                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: size.width * 0.045),
              ),
            ),

            // child: TextFormField(
            //   controller: controller,
            //   decoration: InputDecoration(
            //       hintText: "Search bank",
            //       prefixIcon: Icon(
            //         Icons.search,
            //         color: Theme.of(context).primaryColor,
            //       ),
            //       hintStyle: TextStyle(
            //           color: Theme.of(context).primaryColor.withOpacity(0.5),
            //           fontFamily: "Poppins"),
            //       border: InputBorder.none),
            //   onChanged: (value) => setState(() {}),
            // ),
          ),
          Expanded(
              child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: ListView.builder(
                controller: _controller,
                itemCount: widget.banks
                    .where((element) => element.bankName
                        .contains(controller.text.toUpperCase()))
                    .toList()
                    .length,
                itemBuilder: ((context, index) {
                  var filter = widget.banks
                      .where((element) => element.bankName
                          .contains(controller.text.toUpperCase()))
                      .toList();
                  return InkWell(
                    onTap: (() => Navigator.of(context).pop(filter[index])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            filter[index].bankName,
                            style: MyFaysalTheme.of(context)
                                .promtHeaderText
                                .override(
                                    color: Colors.white,
                                    fontSize: size.width * 0.04),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  );
                })),
          ))
        ],
      ),
    );
  }
}
