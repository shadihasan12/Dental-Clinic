import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/gen/assets.gen.dart';
import 'package:dental_clinic_app/custom_widgets/custom_button.dart';
import 'package:dental_clinic_app/core/localization/language_bloc.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingItem> _items(AppLocalizations l10n) => [
    OnboardingItem(
      imageUrl: Assets.imagesOnboarding1.path,
      title: l10n.onboardingTitle1,
      description: l10n.onboardingDesc1,
    ),
    OnboardingItem(
      imageUrl: Assets.imagesOnboarding2.path,
      title: l10n.onboardingTitle2,
      description: l10n.onboardingDesc2,
    ),
    OnboardingItem(
      imageUrl: Assets.imagesOnboarding3.path,
      title: l10n.onboardingTitle3,
      description: l10n.onboardingDesc3,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage(int itemCount) {
    if (_currentPage < itemCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    context.goNamed(AppRoutesNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = _items(l10n);
    final isLastPage = _currentPage == items.length - 1;
    final fontFamily = FontHelper.fontFamily(context);

    return Scaffold(
      body: Stack(
        children: [
          // Full-screen PageView with images
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildPage(items[index]);
            },
          ),

          // Bottom overlay with gradient, text, indicators, and button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomOverlay(
              items[_currentPage],
              fontFamily,
              isLastPage,
              items.length,
              l10n,
            ),
          ),

          // Top bar: language toggle (left) + skip (right)
          Positioned(
            top: MediaQuery.of(context).padding.top + 12.h,
            right: 20.w,
            left: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Language toggle
                _buildLanguageToggle(fontFamily),

                // Skip button
                GestureDetector(
                  onTap: _navigateToLogin,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      l10n.skip,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeightManager.medium,
                        fontFamily: fontFamily,
                        fontSize: FontSizesManager.s14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingItem item) {
    return Image.asset(
      item.imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      // loadingBuilder: (context, child, loadingProgress) {
      //   if (loadingProgress == null) return child;
      //   return Container(
      //     color: ColorManager.primary.withValues(alpha: 0.1),
      //     child: Center(
      //       child: CircularProgressIndicator(
      //         value: loadingProgress.expectedTotalBytes != null
      //             ? loadingProgress.cumulativeBytesLoaded /
      //                   loadingProgress.expectedTotalBytes!
      //             : null,
      //         color: ColorManager.primary,
      //         strokeWidth: 2,
      //       ),
      //     ),
      //   );
      // },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: ColorManager.primary.withValues(alpha: 0.15),
          child: Center(
            child: Icon(
              Icons.medical_services_rounded,
              size: 80.w,
              color: ColorManager.primary.withValues(alpha: 0.4),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomOverlay(
    OnboardingItem item,
    String fontFamily,
    bool isLastPage,
    int itemCount,
    AppLocalizations l10n,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.4),
            Colors.black.withValues(alpha: 0.85),
            Colors.black.withValues(alpha: 0.95),
          ],
          stops: const [0.0, 0.3, 0.6, 1.0],
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        24.w,
        60.h,
        24.w,
        dockedBottomPadding(context, 24.h),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            item.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeightManager.bold,
              height: FontHeightsManager.h120,
              fontFamily: fontFamily,
              fontSize: FontSizesManager.s28,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12.h),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              item.description,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                height: FontHeightsManager.h140,
                fontFamily: fontFamily,
                fontSize: FontSizesManager.s15,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 28.h),

          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              itemCount,
              (index) => _buildIndicator(index == _currentPage),
            ),
          ),

          SizedBox(height: 24.h),

          // Next / Get Started button
          PrimaryButton(
            text: isLastPage ? l10n.getStarted : l10n.next,
            onPressed: () => _nextPage(itemCount),
            height: 56.h,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageToggle(String fontFamily) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: getIt<LanguageBloc>(),
      builder: (context, state) {
        final isEnglish = state.locale.languageCode == 'en';
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLangPill(
                label: 'EN',
                fontFamily: FontFamily.geist,
                isSelected: isEnglish,
                onTap: () =>
                    getIt<LanguageBloc>().add(const ChangeLanguageEvent('en')),
              ),
              _buildLangPill(
                label: 'عربي',
                fontFamily: FontFamily.cairo,
                isSelected: !isEnglish,
                onTap: () =>
                    getIt<LanguageBloc>().add(const ChangeLanguageEvent('ar')),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLangPill({
    required String label,
    required String fontFamily,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.6),
            fontWeight: isSelected
                ? FontWeightManager.semiBold
                : FontWeightManager.regular,
            fontFamily: fontFamily,
            fontSize: FontSizesManager.s13,
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 28.w : 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadiusManager.full,
      ),
    );
  }
}

class OnboardingItem {
  final String imageUrl;
  final String title;
  final String description;

  OnboardingItem({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}
