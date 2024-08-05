import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:to3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:to3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestedView extends StatelessWidget {
  final String imagePath;
  final Function addSuggested;
  final bool selected;
  final int id;
  const SuggestedView(
      {super.key,
      required this.imagePath,
      required this.addSuggested,
      required this.selected,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
        duration: Duration(milliseconds: AppConstants.animation),
        child: GestureDetector(
          onTap: () {
            addSuggested(id);
          },
          child: SizedBox(
            height: 70.h,
            width: 70.h,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2.w,
                    color:
                        selected ? AppColors.cButton : AppColors.cBackGround),
                color: AppColors.cBackGround,
                borderRadius: BorderRadius.circular(AppConstants.radius),
              ),
              child: Image.asset(
                imagePath,
                width: 50.w,
              ),
            ),
          ),
        ));
  }
}
