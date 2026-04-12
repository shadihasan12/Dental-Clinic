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

const double _kDesktopBreakpoint = 900;

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

  bool _isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= _kDesktopBreakpoint;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = _items(l10n);
    final isLastPage = _currentPage == items.length - 1;
    final fontFamily = FontHelper.fontFamily(context);

    if (_isDesktop(context)) {
      return _buildDesktopLayout(items, isLastPage, fontFamily, l10n);
    }
    return _buildMobileLayout(items, isLastPage, fontFamily, l10n);
  }

  // ── Desktop: split view ────────────────────────────────────────────
  Widget _buildDesktopLayout(
    List<OnboardingItem> items,
    bool isLastPage,
    String fontFamily,
    AppLocalizations l10n,
  ) {
    return Scaffold(
      body: Row(
        children: [
          // Left: image carousel
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: items.length,
                  itemBuilder: (_, index) => _buildPage(items[index]),
                ),
                // Subtle bottom gradient for polish
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.4),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right: content
          Expanded(
            child: Container(
              color: ColorManager.of(context).scaffoldBg,
              child: Column(
                children: [
                  // Top bar: language toggle + skip
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 24, 32, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDesktopLanguageToggle(fontFamily),
                        _buildDesktopSkipButton(l10n, fontFamily),
                      ],
                    ),
                  ),

                  // Centred content
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Logo
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: ColorManager.primary10,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.medical_services_rounded,
                                  color: ColorManager.primary,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Title
                              Text(
                                items[_currentPage].title,
                                style: TextStyle(
                                  color: ColorManager.of(context).textPrimary,
                                  fontWeight: FontWeightManager.bold,
                                  fontSize: 26,
                                  fontFamily: fontFamily,
                                  height: FontHeightsManager.h120,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),

                              // Description
                              Text(
                                items[_currentPage].description,
                                style: TextStyle(
                                  color: ColorManager.of(context).textSecondary,
                                  fontSize: 15,
                                  fontFamily: fontFamily,
                                  height: FontHeightsManager.h140,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 36),

                              // Indicators
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  items.length,
                                  (i) => _buildDesktopIndicator(i == _currentPage),
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () => _nextPage(items.length),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorManager.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    textStyle: TextStyle(
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeightManager.semiBold,
                                      fontSize: 15,
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    isLastPage ? l10n.getStarted : l10n.next,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLanguageToggle(String fontFamily) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: getIt<LanguageBloc>(),
      builder: (context, state) {
        final isEnglish = state.locale.languageCode == 'en';
        final c = ColorManager.of(context);
        return Container(
          decoration: BoxDecoration(
            color: c.cardBgSecondary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: c.borderLight),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDesktopLangPill(
                label: 'EN',
                fontFamily: FontFamily.geist,
                isSelected: isEnglish,
                onTap: () =>
                    getIt<LanguageBloc>().add(const ChangeLanguageEvent('en')),
              ),
              _buildDesktopLangPill(
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

  Widget _buildDesktopLangPill({
    required String label,
    required String fontFamily,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? ColorManager.primary
                : ColorManager.of(context).textSecondary,
            fontWeight: isSelected
                ? FontWeightManager.semiBold
                : FontWeightManager.regular,
            fontFamily: fontFamily,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopSkipButton(AppLocalizations l10n, String fontFamily) {
    return TextButton(
      onPressed: _navigateToLogin,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        l10n.skip,
        style: TextStyle(
          color: ColorManager.of(context).textSecondary,
          fontWeight: FontWeightManager.medium,
          fontFamily: fontFamily,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildDesktopIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 28 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? ColorManager.primary
            : ColorManager.of(context).borderLight,
        borderRadius: BorderRadiusManager.full,
      ),
    );
  }

  // ── Mobile: original layout ────────────────────────────────────────
  Widget _buildMobileLayout(
    List<OnboardingItem> items,
    bool isLastPage,
    String fontFamily,
    AppLocalizations l10n,
  ) {
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
                _buildLanguageToggle(fontFamily),
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
      errorBuilder: (_, __, ___) {
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
        MediaQuery.of(context).padding.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              itemCount,
              (index) => _buildIndicator(index == _currentPage),
            ),
          ),
          SizedBox(height: 24.h),
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
