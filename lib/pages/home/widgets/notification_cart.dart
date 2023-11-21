import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String date;
  const NotificationCard({Key? key,required this.date, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.width * 0.12,
              constraints: const BoxConstraints(minHeight: 20,minWidth: 20,maxHeight: 40,maxWidth: 40),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE86B35),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width* 0.55),
                    child: Text(title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                        style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: MediaQuery.of(context).size.width < 300 ? 12:15) ),
                  ),
                          Text("${DateFormat.yMMMMd().format(DateTime.parse(date))}, ${DateFormat.jm().format(DateTime.parse(date))}",
                      style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: MediaQuery.of(context).size.width < 300 ? 9:11,)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
