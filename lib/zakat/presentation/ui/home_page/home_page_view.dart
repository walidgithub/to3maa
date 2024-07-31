import 'package:flutter/material.dart';
import 'package:flutter_laravel/zakat/domain/entities/tab_items.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_assets.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_constants.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_strings.dart';
import 'package:flutter_laravel/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_typography.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/tabs/add_zakat/add_zahat_view.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/tabs/cart/cart_view.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/tabs/products/products_view.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/tabs/totals/totals_view.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/widgets/tab_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  List<TabItems> tabItems = [
    TabItems(
        title: AppStrings.addZakat, activeTab: true, icon: AppAssets.addNew),
    TabItems(title: AppStrings.cart, activeTab: false, icon: AppAssets.cart),
    TabItems(
        title: AppStrings.totals, activeTab: false, icon: AppAssets.totals),
    TabItems(
        title: AppStrings.products, activeTab: false, icon: AppAssets.products)
  ];

  int selectedTab = 0;

  var tabPages = [
    const AddZakatView(),
    const CartView(),
    const TotalsView(),
    const ProductsView()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: contentBody(context),
    ));
  }

  Widget contentBody(BuildContext context) {
    // SingleChildScrollView
    return Stack(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(color: AppColors.cWhite),
        ),
        Positioned(
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width * 0.75,
            child: tabPages[selectedTab],
          ),
        ),
        Positioned(
          left: 0,
          child: Container(
            width: MediaQuery.sizeOf(context).width / 4,
            height: MediaQuery.sizeOf(context).height,
            color: AppColors.cBackGround,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height / 4,
                  width: MediaQuery.sizeOf(context).width / 4,
                  decoration: BoxDecoration(
                      color: AppColors.cPrimary,
                      borderRadius: BorderRadius.only(
                          bottomRight:
                              Radius.circular(AppConstants.moreRadius))),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Center(
                      child: Text(
                        AppStrings.zakat,
                        style: AppTypography.kBold24
                            .copyWith(fontFamily: AppFonts.boldFontFamily),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 30.h),
                    child: ListView.separated(
                      itemCount: tabItems.length,
                      shrinkWrap: false,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 40.h,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              for (var n in tabItems) {
                                n.activeTab = false;
                              }
                              tabItems[index].activeTab = true;
                              selectedTab = index;
                            });
                          },
                          child: TabBarWidget(
                            title: tabItems[index].title!,
                            activeTab: tabItems[index].activeTab!,
                            index: index,
                            icon: tabItems[index].icon!,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
