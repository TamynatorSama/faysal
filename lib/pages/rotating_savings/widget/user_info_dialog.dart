// ignore_for_file: use_build_context_synchronously

import 'package:faysal/models/ajo_member_model.dart';
import 'package:faysal/pages/home/topupwallet/widget/topup_wallet_info.dart';
import 'package:faysal/pages/topup/widgets/topup_button.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberInfo extends StatefulWidget {
  final MemberModel model;
  final bool isCordinator;
  final int ajoId;
  const MemberInfo(
      {super.key,
      required this.model,
      required this.isCordinator,
      required this.ajoId});

  @override
  State<MemberInfo> createState() => _MemberInfoState();
}

class _MemberInfoState extends State<MemberInfo> {
  late SavingsProvider _savingsProvider;
  bool accept = false;
  bool reject = false;

  @override
  void initState() {
    _savingsProvider = Provider.of<SavingsProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isApproved =
        widget.model.membership.toLowerCase() == "request";
    return Container(
        width: double.maxFinite,
        height: !widget.isCordinator || !isApproved ? size.height * 0.42 : size.height * 0.55,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
            color: MyFaysalTheme.of(context).secondaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Expanded(
              child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white.withOpacity(0.4),
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: ScrollConfiguration(
                    behavior:
                        const ScrollBehavior().copyWith(overscroll: false),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Container(
                        width: size.width * 0.22 < 30
                            ? 30
                            : size.width * 0.22 > 70
                                ? 70
                                : size.width * 0.22,
                        height: size.width * 0.22,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/avatar/avatar${generateAvatar(widget.model.id)}.png"))),
                      ),
                      TopupWalletInfo(
                          header: "Name",
                          value: widget.model.userData.name.capitalize(" ")),
                      TopupWalletInfo(
                          header: "Email", value: widget.model.userData.email),
                      TopupWalletInfo(
                          header: "Phone Number",
                          value: widget.model.userData.phone),
                      if (isApproved && widget.isCordinator)
                        TopUpButton(
                          call: () async{
                            setState(() {
                              accept = true;
                            });
                            await _savingsProvider.approveMembership(widget.ajoId,
                            widget.model.id, context, widget.model);
                            setState(() {
                              accept = false;
                            });
                            Navigator.pop(context,true);
                          },
                          isLoading: accept ? accept : null,
                          text: "Approve",
                          reuse: true,
                          color: MyFaysalTheme.of(context).primaryColor,
                          bottom: 0,
                        ),
                      if (isApproved && widget.isCordinator)
                        TopUpButton(
                          call: () async {
                            setState(() {
                              reject = true;
                            });
                            await _savingsProvider.rejectMembership(
                                widget.ajoId, context, widget.model);
                            setState(() {
                              reject = false;
                            });
                            Navigator.pop(context,false);
                          },
                          text: "Reject",
                          isLoading: reject ? reject : null,
                          reuse: false,
                          color: MyFaysalTheme.of(context).accentColor,
                          bottom: 0,
                        )
                    ]))))
          ]))
        ]));
  }
}
