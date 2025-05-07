import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/remain_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/settings/settings.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/widgets/home_drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/core/utils/functions.dart';
import 'package:To3maa/zakat/domain/entities/cart_items.dart';
import 'package:To3maa/zakat/domain/entities/tab_items.dart';
import 'package:To3maa/core/di/di.dart';
import 'package:To3maa/core/shared/constant/app_assets.dart';
import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/add_zakat/add_zahat_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/cart/cart_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/products/products_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/totals/totals_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/widgets/tab_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/style/app_colors.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  List<TabItem> tabItems = [
    TabItem(
        title: AppStrings.addZakat.tr(), activeTab: true, icon: AppAssets.addNew),
    TabItem(title: AppStrings.cart.tr(), activeTab: false, icon: AppAssets.cart),
    TabItem(
        title: AppStrings.totals.tr(), activeTab: false, icon: AppAssets.totals),
    TabItem(
        title: AppStrings.remainTab.tr(), activeTab: false, icon: AppAssets.remain),
    TabItem(
        title: AppStrings.products.tr(), activeTab: false, icon: AppAssets.products),
    TabItem(
        title: "", activeTab: false, icon: AppAssets.settings)
  ];

  int selectedTab = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var tabPages = [
    const AddZakatView(),
    const CartView(),
    const TotalsView(),
    const RemainView(),
    const ProductsView(),
    const SettingsView()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackButtonPressed(context),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              drawer: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: const HomeDrawer()),
          body: BlocProvider(
              create: (context) => sl<ZakatCubit>(),
              child: contentBody(context)),
        )),
      ),
    );
  }

  Widget contentBody(BuildContext context) {
    // SingleChildScrollView
    return BlocConsumer<ZakatCubit, ZakatState>(
        listener: (context, state) async {
      if (state.zakatState == RequestState.zakatLoading) {
      } else if (state.zakatState == RequestState.zakatError) {
      } else if (state.zakatState == RequestState.zakatLoaded) {
        cartItems = state.zakatList;
      }
    }, builder: (context, state) {
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Center(
                            child: Text(
                              AppStrings.appName.tr(),
                              style: AppTypography.kBold24
                                  .copyWith(fontFamily: AppFonts.boldFontFamily),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState
                                ?.openDrawer();
                          },
                          child: SvgPicture.asset(
                            AppAssets.menu,
                            width: 35.w,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15.h),
                      child: ListView.separated(
                        itemCount: tabItems.length,
                        shrinkWrap: false,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 25.h,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return TabBarWidget(
                            title: tabItems[index].title!,
                            activeTab: tabItems[index].activeTab!,
                            index: index,
                            icon: tabItems[index].icon!,
                            badgeVal: cartItems.length,
                            toggleTabs: () {
                              setState(() {
                                for (var n in tabItems) {
                                  n.activeTab = false;
                                }
                                tabItems[index].activeTab = true;
                                selectedTab = index;
                              });
                            },
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
    });
  }
}
