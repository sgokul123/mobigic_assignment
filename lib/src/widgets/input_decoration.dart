import 'package:flutter/material.dart';
import 'package:mobigic_assignment/src/utils/custom_color.dart';

class AppInputDecoration {
  InputDecoration getDecoration(
      {String prefix,
      Widget prefixIcon,
      Widget suffixIcon,
      @required String hint,
      Widget suffix,
      String counterText,
      FloatingLabelBehavior floatingLabelBehavior,
      double borderRadius,
      EdgeInsetsGeometry contentPadding}) {
    return InputDecoration(
        floatingLabelBehavior:
            floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        fillColor: CustomColor.colorWhite,
        filled: true,
        errorMaxLines: 2,
        prefixText: prefix,
        prefixIcon: prefixIcon != null
            ? new Container(
                child: prefixIcon,
              )
            : null,
        counterText: "",
        suffixIcon: suffixIcon != null
            ? new Container(
                child: suffixIcon,
              )
            : null,
        suffix: suffix,
        labelText: hint,
        labelStyle: TextStyle(
          color: CustomColor.darkGrey,
          fontSize: 14.0,
        ),
        contentPadding:
            contentPadding == null ? EdgeInsets.all(16) : contentPadding,
        errorStyle: TextStyle(
          color: CustomColor.fieldErrorTextColor,
          fontSize: 14.0,
        ),
        hintStyle: TextStyle(color: CustomColor.labelBlack),
        border: getOutlineBorder(borderRadius),
        focusedBorder: getOutlineBorder(borderRadius),
        enabledBorder: getOutlineBorder(borderRadius));
  }

  InputBorder getOutlineBorder(double borderRadius) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(width: 5.0, color: CustomColor.appPrimaryColor));
  }

  EdgeInsetsGeometry getCommonPaddingForField() {
    return EdgeInsets.only(left: 0.0, top: 12, right: 0.0);
  }
}
