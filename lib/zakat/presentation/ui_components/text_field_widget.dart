import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/shared/style/app_colors.dart';

Widget textFieldWidget(TextEditingController textController, String labelText,
    TextInputType textInputType, Function(String) onChanged) {
  return TextField(
      // autofocus: true,
      onChanged: onChanged,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: textInputType,
      controller: textController,
      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold,),
      decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 15.sp),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 15.sp, color: AppColors.cPrimary),
          border: InputBorder.none));
}
