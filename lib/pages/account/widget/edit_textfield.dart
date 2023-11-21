import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isVerified;
  const EditProfileTextField(
      {super.key,
      required this.controller,
      required this.label,
      required this.isVerified});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        cursorColor: Colors.white,
        style: MyFaysalTheme.of(context).textFieldText,
        decoration: InputDecoration(
            labelText: label,
            // labelText: "${MediaQuery.of(context).viewInsets.bottom}",
            labelStyle: MyFaysalTheme.of(context).promtHeaderText.override(
                color: MyFaysalTheme.of(context).primaryColor.withOpacity(0.2),
                fontSize: 15),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            suffixIcon: isVerified ? Icon(Icons.check_circle,color: MyFaysalTheme.of(context).primaryColor,) : Icon(Icons.info_outlined ,color: MyFaysalTheme.of(context).primaryText,),
            filled: true,
            fillColor: const Color(0xff123F33)),
      ),
    );
  }
}
