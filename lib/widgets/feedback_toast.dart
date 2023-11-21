import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedBackToast extends StatelessWidget {
  final String message;
  final bool isError;
  const FeedBackToast(
      {super.key, required this.message, required this.isError});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyFaysalTheme.of(context).secondaryColor
      ),
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (isError
              ? SvgPicture.string(
                  '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="#E86B35" class="w-5 h-5">
  <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-5a.75.75 0 01.75.75v4.5a.75.75 0 01-1.5 0v-4.5A.75.75 0 0110 5zm0 10a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
</svg>
''',
                  width: 26,
                )
              : SvgPicture.string(
                  '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="#4BF0A5" class="w-5 h-5">
  <path fill-rule="evenodd" d="M16.403 12.652a3 3 0 000-5.304 3 3 0 00-3.75-3.751 3 3 0 00-5.305 0 3 3 0 00-3.751 3.75 3 3 0 000 5.305 3 3 0 003.75 3.751 3 3 0 005.305 0 3 3 0 003.751-3.75zm-2.546-4.46a.75.75 0 00-1.214-.883l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z" clip-rule="evenodd" />
</svg>
''',
                  width: 26,
                )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65),
                child: AutoSizeText(
                  message,
                  style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: 15),
                )),
          ),
          InkWell(
            onTap: () => FToast().removeCustomToast(),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 17,
            ),
          )
        ],
      ),
    );
  }
}
