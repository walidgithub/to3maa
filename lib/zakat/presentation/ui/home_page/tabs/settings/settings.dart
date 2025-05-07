import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import '../../../../../../core/di/di.dart';
import '../../../../../../core/preferences/app_pref.dart';
import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/constant/app_typography.dart';
import '../../../../../../core/shared/style/app_colors.dart';
import '../../../../ui_components/text_field_widget.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();

  final AppPreferences _appPreferences = sl<AppPreferences>();

  String selectedLang = 'عـربـى';

  final List<String> langs = ['عـربـى', 'English'];

  _changeLanguage() {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cWhite,
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          title: FadeInLeft(
            duration: Duration(milliseconds: AppConstants.animation),
            child: Text(
              AppStrings.settings.tr(),
              style: AppTypography.kLight20
                  .copyWith(fontFamily: AppFonts.boldFontFamily),
            ),
          ),
        ),
        backgroundColor: AppColors.cWhite,
        body: Column(
          children: [
            Center(
              child:
              SizedBox(
                width: 300.w,
                child: DropdownButton2(
                  underline: Container(),
                  value: selectedLang,
                  items: langs.map((item) {
                    return DropdownMenuItem(
                        value: item,
                        child: Row(
                          children: [
                            Container(
                                constraints:
                                BoxConstraints(maxWidth: 200.w),
                                child: Text(item,
                                    textDirection: ui.TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color:
                                        AppColors.cPrimary))),
                          ],
                        ));
                  }).toList(),
                  onChanged: (dropDownSelectedLang) {
                    selectedLang = dropDownSelectedLang as String;
                    setState(() {});
                  },
                  dropdownSearchData: DropdownSearchData(
                    searchController: _languageController,
                    searchInnerWidgetHeight: 60,
                    searchInnerWidget: Container(
                      height: 60,
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 4, right: 8, left: 8),
                      child: TextField(
                        expands: true,
                        maxLines: null,
                        controller: _languageController,
                        textDirection: ui.TextDirection.rtl,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: AppStrings.selectLang.tr(),
                          hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.cPrimary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      selectedLang = item.value as String;
                      var choose =
                      selectedLang.toLowerCase();
                      return choose
                          .contains(searchValue.toLowerCase());
                    },
                  ),
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      _languageController.clear();
                    }
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50.h,
                    padding:
                    const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.cBorder,
                      ),
                    ),
                    elevation: 0,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 300.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: AppColors.cBorder)),
                    elevation: 0,
                    offset: const Offset(0, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: Radius.circular(10.r),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility:
                      MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Text(AppStrings.selectLang.tr(),
                          textDirection: ui.TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        width: AppConstants.heightBetweenElements,
                      )
                    ],
                  ),
                  style: TextStyle(
                      fontSize: 14.sp, fontWeight: FontWeight.w400),
                  iconStyleData: IconStyleData(iconSize: 20.w),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            textFieldWidget(_currencyController, AppStrings.selectCurrency.tr(),
                TextInputType.text, (String textVal) async {},false,true),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () async {
                if (_languageController.text != "" && _currencyController.text != "") {

                  setState(() {
                    _changeLanguage();
                  });

                  await _appPreferences.removeCurrency(PREFS_KEY_CURRENCY);

                  await _appPreferences.setCurrency(
                      PREFS_KEY_CURRENCY, _currencyController.text);

                  final snackBar = SnackBar(
                    duration: Duration(
                        milliseconds:
                        AppConstants.durationOfSnackBar),
                    content: Text(AppStrings.successAdd.tr()),
                  );
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBar);
                }
              },
              child: Container(
                  width: 80.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2.w,
                        color: AppColors
                            .cPrimary),
                    borderRadius:
                    BorderRadius.circular(
                        AppConstants
                            .radius),
                    color: AppColors.cWhite,
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.save.tr(),
                      style: AppTypography
                          .kLight14
                          .copyWith(
                        fontFamily: AppFonts
                            .qabasFontFamily,
                        color:
                        AppColors.cButton,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
