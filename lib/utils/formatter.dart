
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: "");
    }

    int selectionIndex = newValue.text.length - newValue.selection.extentOffset;

    String valueToReturn = NumberFormat().format(int.parse(RemoveSeparator(newValue.text).toString()));
    return TextEditingValue(
        text: valueToReturn,
        selection: TextSelection.collapsed(
            offset: valueToReturn.length - selectionIndex));
    // throw UnimplementedError();
  }
}

class RemoveSeparator {
  final String _amount;

  RemoveSeparator(this._amount);

  @override
  String toString() => _amount.split(" ").last.replaceAll(",", '');
}

class HandsFormatter extends TextInputFormatter {
  final int maxNumber;

  HandsFormatter({required this.maxNumber});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: "");
    }

    int selectionIndex = newValue.text.length - newValue.selection.extentOffset;

    bool isAllowed = int.parse(newValue.text) > maxNumber;

    String valueToReturn =
        !isAllowed && int.parse(newValue.text) != 0 ? newValue.text : "";

    return TextEditingValue(
        text: valueToReturn,
        selection: TextSelection.collapsed(
            offset: valueToReturn.length - selectionIndex));
  }
}

