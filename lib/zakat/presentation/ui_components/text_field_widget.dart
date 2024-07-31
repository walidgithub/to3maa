import 'package:flutter/material.dart';
import 'package:flutter_laravel/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textFieldWidget(TextEditingController textController, String labelText,
    TextInputType textInputType) {
  return TextField(
      // autofocus: true,
      keyboardType: textInputType,
      controller: textController,
      style: TextStyle(fontSize: 15.sp),
      decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 15.sp),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 15.sp, color: AppColors.cPrimary),
          border: InputBorder.none));
}
