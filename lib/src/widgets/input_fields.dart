import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic_assignment/src/utils/custom_color.dart';
import 'package:mobigic_assignment/src/utils/text_field_util.dart';

import 'input_decoration.dart';

// ignore: must_be_immutable
class InputFieldArea extends StatelessWidget {
  final String hint;
  final String error;
  final String initialValue;
  final bool obscure;
  final IconData icon;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final FocusNode firstFocus;
  final FocusNode nextFocus;
  TextInputAction textAction;
  TextInputType inputType;
  OnValueChanged onValueChanged;
  OnFieldError onFieldError;
  OnKeyBoardKeyEvent onKeyBoardKeyEvent;
  TextEditingController textEditingController;
  String inputFormattersType;
  bool requiredTapEvent;
  bool disabled = true;
  bool isEmpty = false;
  String prefixText;
  String suffix;
  final RegExp regex;
  final RegExp onlyNumberRegex;
  final String regexError;
  int maxLength;
  int minLength;
  int maxLines;
  String counterText;
  final TextCapitalization textCapitalization;
  double borderRadius;

  /// calender dateformat
  String dateFormat;

  /// Enable calender from  - to year
  int fromYear = 80;
  int toYear = 0;

  InputFieldArea(
      {this.hint,
      this.obscure,
      this.textEditingController,
      this.icon,
      this.disabled,
      this.isEmpty,
      this.error,
      this.suffix,
      this.maxLength,
      this.minLength,
      this.maxLines,
      this.counterText,
      this.regex,
      this.onlyNumberRegex,
      this.textCapitalization,
      this.initialValue,
      this.firstFocus,
      this.regexError,
      this.nextFocus,
      this.textAction,
      this.inputType,
      this.onKeyBoardKeyEvent,
      this.onValueChanged,
      this.inputFormattersType,
      this.requiredTapEvent,
      this.suffixIcon,
      this.borderRadius,
      this.prefixIcon,
      this.prefixText,
      this.dateFormat,
      this.onFieldError,
      this.fromYear,
      this.toYear});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: AppInputDecoration().getCommonPaddingForField(),
        child: TextFormField(
          obscureText: obscure,
          enabled: disabled == null || !disabled,
          initialValue: initialValue,
          keyboardType: inputType,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: CustomColor.labelBlack),
          controller: textEditingController,
          focusNode: firstFocus,
          maxLines: maxLines != null ? maxLines : 1,
          maxLength: maxLength != null ? maxLength : null,
          readOnly: requiredTapEvent != null,
          textCapitalization: textCapitalization == null
              ? TextCapitalization.none
              : textCapitalization,
          onFieldSubmitted: (term) {
            textAction == TextInputAction.next
                ? TextUtil.fieldFocusChange(context, firstFocus, nextFocus)
                : null;
          },
          onChanged: (text) {
            onValueChanged(text.trim());
          },
          inputFormatters: [
            new FilteringTextInputFormatter(RegExp(" "), allow: false),
          ],
          onSaved: (newVale) {
            onValueChanged(newVale.trim());
          },
          textInputAction: textAction,
          validator: (String val) => getValidate(val.trim()),
          decoration: AppInputDecoration().getDecoration(
              prefix: prefixText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hint: hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              borderRadius: borderRadius ?? 10.0,
              counterText: counterText ?? "",
              suffix: Text(suffix ?? '')),
        ),
      ),
    );
  }

  String getValidate(String val) {
    if (isEmpty != null && isEmpty) {
      if (val != null && val.isNotEmpty) {
        if (regex != null && !regex.hasMatch(val)) {
          if (onFieldError != null)
            onFieldError(firstFocus != null ? firstFocus : FocusNode());
          return (regexError == null || regexError.isEmpty)
              ? "error"
              : regexError;
        } else if (val == null || val.isEmpty) {
          if (onFieldError != null)
            onFieldError(firstFocus != null ? firstFocus : FocusNode());
          return error == null || error.isEmpty ? "error" : error;
        }
      }
    } else {
      if (val == null || val.isEmpty) {
        if (onFieldError != null)
          onFieldError(firstFocus != null ? firstFocus : FocusNode());
        return error == null || error.isEmpty ? "error" : error;
      } else if (minLength != null && val.length < minLength) {
        if (onFieldError != null)
          onFieldError(firstFocus != null ? firstFocus : FocusNode());
        return "Min length not satisfied";
      } else if (regex != null && !regex.hasMatch(val)) {
        if (onFieldError != null)
          onFieldError(firstFocus != null ? firstFocus : FocusNode());
        return (regexError == null || regexError.isEmpty)
            ? "This field is mandatory!"
            : regexError;
      }
    }
  }
}

typedef OnValueChanged = void Function(String newValue);
typedef OnFieldError = void Function(FocusNode focusNode);
typedef OnKeyBoardKeyEvent = void Function(TextInputAction event);
