import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/constant/app_typography.dart';
import '../../../../../../core/shared/style/app_colors.dart';
import '../../../../ui_components/text_field_widget.dart';

class RemainView extends StatefulWidget {
  const RemainView({super.key});

  @override
  State<RemainView> createState() => _RemainViewState();
}

class _RemainViewState extends State<RemainView> {
  final TextEditingController _sundriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cWhite,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: FadeInLeft(
          duration: Duration(milliseconds: AppConstants.animation),
          child: Text(
            AppStrings.remainTab,
            style: AppTypography.kLight20
                .copyWith(fontFamily: AppFonts.boldFontFamily),
          ),
        ),
      ),
      backgroundColor: AppColors.cWhite,
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          textFieldWidget(_sundriesController, AppStrings.sundries,
              TextInputType.number, (String textVal) {}),
          SizedBox(
            height: AppConstants.heightBetweenElements,
          ),
        ],
      ),
    ),
    );
  }
}
