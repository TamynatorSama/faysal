import 'package:faysal/utils/constants.dart';
import 'package:flutter/material.dart';


extension TextHelper on TextStyle{
  TextStyle override({String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    // bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,})=>copyWith(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
        height: lineHeight,
    );
    }

abstract class MyFaysalTheme{
  late Color primaryColor;
  late Color primaryText;
  late Color secondaryColor;
  late Color overlayColor;
  late Color scaffolbackgeroundColor;
  late Color accentColor;

  static MyFaysalTheme of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? DarkModeTheme()
          : DarkModeTheme();

  

  TextStyle get text1 => textThemeLight.primaryText;
  TextStyle get promtHeaderText => textThemeLight.promtHeaderText;
  TextStyle get splashHeaderText=> textThemeLight.splashHeaderText;
  TextStyle get textFieldText=> textThemeLight.textField;
  
  TextTheme get textThemeLight => TextTheme(this);
  

}
abstract class Typography{
  TextStyle get primaryText;
  TextStyle get promtHeaderText;
  TextStyle get splashHeaderText;
  TextStyle get textField;
}

class TextTheme extends Typography{
  TextTheme(this.theme);

  final MyFaysalTheme theme;

  @override
  TextStyle get primaryText => TextStyle(
    color: theme.primaryText,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14
  );

  @override
  TextStyle get promtHeaderText => TextStyle(
    color: theme.primaryColor,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20
  );

  @override
  TextStyle get splashHeaderText => TextStyle(
    color: theme.primaryText,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 27
  );
  @override
  TextStyle get textField => TextStyle(
    color: theme.primaryText,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16
  );

}
class DarkModeTheme extends MyFaysalTheme{
  @override
  Color accentColor = const Color(0xffE86B35);

  @override
  Color overlayColor = const Color(0xff113A2F);

  @override
  Color primaryColor = const Color(0xff4BF0A5);

  @override
  Color primaryText = Colors.white;

  @override
  Color scaffolbackgeroundColor= const Color(0xff113A2F);

  @override
  Color secondaryColor = const Color(0xff0A221C);
  
}