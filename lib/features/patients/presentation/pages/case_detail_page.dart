import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/add_treatment_form.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/treatment_detail_popup.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/treatment_item_card.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/payment/record_payment_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:intl/intl.dart';

class CaseDetailsPage extends StatefulWidget {
  final String caseId;

  const CaseDetailsPage({super.key, required this.caseId});

  @override
  State<CaseDetailsPage> createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  bool _showAddForm = false;

  // Mock case data - replace with actual data from bloc/repository
  late DentalCase _case;
  final List<PaymentRecord> _payments = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadMockData();
  }

  void _recordPayment(PaymentRecord payment) {
    setState(() {
      _payments.add(payment);
      _case = _case.copyWith(
        paidAmount: _case.paidAmount + payment.amount,
      );
    });
  }

  void _showRecordPaymentPopup() {
    RecordPaymentPopup.show(
      context,
      patientName: _case.patientName,
      caseTitle: _case.title,
      totalCost: _case.totalCost,
      paidAmount: _case.paidAmount,
      onSave: _recordPayment,
    );
  }

  void _loadMockData() {
    _case = DentalCase(
      id: widget.caseId,
      patientId: '1',
      patientName: 'Sarah Johnson',
      title: 'Root Canal Treatment',
      startDate: DateTime(2024, 11, 1),
      status: 'In Progress',
      totalCost: 1500,
      paidAmount: 1000,
      treatmentItems: [
        TreatmentItem(
          id: '1',
          description: 'Initial consultation and X-ray examination',
          treatmentTypes: [TreatmentType.consultation, TreatmentType.xray],
          selectedTeeth: [14],
          attachments: ['xray-14.jpg'],
          createdAt: DateTime(2024, 11, 1),
          completedAt: DateTime(2024, 11, 1),
          isDone: true,
        ),
        TreatmentItem(
          id: '2',
          description: 'Root canal procedure - first session',
          treatmentTypes: [TreatmentType.rootCanal],
          selectedTeeth: [14],
          attachments: [],
          createdAt: DateTime(2024, 11, 8),
          completedAt: DateTime(2024, 11, 8),
          isDone: true,
        ),
        TreatmentItem(
          id: '3',
          description: 'Root canal completion and temporary crown',
          treatmentTypes: [TreatmentType.rootCanal, TreatmentType.crown],
          selectedTeeth: [14],
          attachments: [],
          createdAt: DateTime(2024, 11, 15),
          isDone: false,
        ),
        TreatmentItem(
          id: '4',
          description: 'Permanent crown fitting',
          treatmentTypes: [TreatmentType.crown],
          selectedTeeth: [14],
          attachments: [],
          createdAt: DateTime(2024, 11, 20),
          isDone: false,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleTreatmentDone(TreatmentItem item) {
    setState(() {
      final index = _case.treatmentItems.indexWhere((t) => t.id == item.id);
      if (index != -1) {
        final updatedItem = item.copyWith(
          isDone: !item.isDone,
          completedAt: !item.isDone ? DateTime.now() : null,
        );
        final updatedItems = List<TreatmentItem>.from(_case.treatmentItems);
        updatedItems[index] = updatedItem;
        _case = _case.copyWith(treatmentItems: updatedItems);
      }
    });
  }

  void _addTreatment(TreatmentItem item) {
    setState(() {
      final updatedItems = [..._case.treatmentItems, item];
      _case = _case.copyWith(treatmentItems: updatedItems);
      _showAddForm = false;
    });
  }

  List<_PageData> _buildPages() {
    final pages = <_PageData>[];
    
    // First page: Pending treatments
    pages.add(_PageData(
      title: 'Pending',
      subtitle: '${_case.pendingTreatments.length} treatment(s)',
      items: _case.pendingTreatments,
      isPending: true,
    ));
    
    // Additional pages: Completed treatments grouped by date
    final completedByDate = _case.completedByDate;
    for (final entry in completedByDate.entries) {
      pages.add(_PageData(
        title: DateFormat('MMM d, yyyy').format(entry.key),
        subtitle: '${entry.value.length} completed',
        items: entry.value,
        isPending: false,
      ));
    }
    
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();
    
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: PaddingManager.all16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Case info card
                  _buildCaseInfoCard(),
                  
                  SizedBox(height: 16.h),

                  // Action buttons row
                  _buildActionButtons(),
                  
                  SizedBox(height: 16.h),
                  
                  // Add treatment form (expandable)
                  if (_showAddForm)
                    AddTreatmentForm(
                      patientName: _case.patientName,
                      onSave: _addTreatment,
                      onCancel: () => setState(() => _showAddForm = false),
                    ),
                  
                  if (!_showAddForm) SizedBox(height: 8.h),
                  
                  // Page indicators
                  _buildPageIndicators(pages),
                  
                  SizedBox(height: 12.h),
                  
                  // Treatments PageView
                  _buildTreatmentsPageView(pages),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _showAddForm = true),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadiusManager.lg,
                border: Border.all(color: ColorManager.primary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle, size: 18.w, color: ColorManager.primary),
                  SizedBox(width: 6.w),
                  Text(
                    'Add Treatment',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: GestureDetector(
            onTap: _showRecordPaymentPopup,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: ColorManager.success.withValues(alpha: 0.1),
                borderRadius: BorderRadiusManager.lg,
                border: Border.all(color: ColorManager.success),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payments_outlined, size: 18.w, color: ColorManager.success),
                  SizedBox(width: 6.w),
                  Text(
                    'Record Payment',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.success,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: GradientManager.primaryHeader,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // App bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: ColorManager.white),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      'Case Details',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: FontFamily.geist,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: ColorManager.white),
                    onPressed: () {
                      // TODO: Show options menu (extract PDF, delete, etc.)
                    },
                  ),
                ],
              ),
            ),
            
            // Case title
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Column(
                children: [
                  Text(
                    _case.title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _case.patientName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontFamily.geist,
                      color: ColorManager.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseInfoCard() {
    return CustomCard(
      child: Column(
        children: [
          // Stats row
          Row(
            children: [
              _buildStatItem('Total', '\$${_case.totalCost.toStringAsFixed(0)}', ColorManager.textPrimary),
              _buildStatItem('Paid', '\$${_case.paidAmount.toStringAsFixed(0)}', ColorManager.success),
              _buildStatItem('Pending', '\$${_case.pendingAmount.toStringAsFixed(0)}', ColorManager.warning),
            ],
          ),
          
          SizedBox(height: 12.h),
          Divider(color: ColorManager.gray200),
          SizedBox(height: 12.h),
          
          // Info rows
          _buildInfoRow('Started', DateFormat('MMM d, yyyy').format(_case.startDate)),
          _buildInfoRow('Status', _case.status),
          _buildInfoRow('Total Treatments', '${_case.treatmentItems.length}'),
          _buildInfoRow('Completed', '${_case.completedTreatments.length}'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color valueColor) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
              color: ColorManager.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicators(List<_PageData> pages) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          final isSelected = _currentPageIndex == index;
          
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? ColorManager.primary : ColorManager.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? ColorManager.primary : ColorManager.gray300,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (page.isPending)
                    Icon(
                      Icons.schedule,
                      size: 14.w,
                      color: isSelected ? ColorManager.white : ColorManager.warning,
                    )
                  else
                    Icon(
                      Icons.check_circle,
                      size: 14.w,
                      color: isSelected ? ColorManager.white : ColorManager.success,
                    ),
                  SizedBox(width: 6.w),
                  Text(
                    page.title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? ColorManager.white : ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTreatmentsPageView(List<_PageData> pages) {
    // Calculate dynamic height based on content
    final maxItems = pages.map((p) => p.items.length).reduce((a, b) => a > b ? a : b);
    final estimatedHeight = (maxItems * 120.h).clamp(200.h, 500.h);
    
    return SizedBox(
      height: estimatedHeight,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPageIndex = index),
        itemCount: pages.length,
        itemBuilder: (context, pageIndex) {
          final page = pages[pageIndex];
          
          if (page.items.isEmpty) {
            return _buildEmptyState(page.isPending);
          }
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page header
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Text(
                  page.subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: FontFamily.geist,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ),
              
              // Treatment items
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: page.items.length,
                  itemBuilder: (context, itemIndex) {
                    final item = page.items[itemIndex];
                    final globalIndex = _case.treatmentItems.indexOf(item);
                    
                    return TreatmentItemCard(
                      item: item,
                      index: globalIndex,
                      showCheckbox: page.isPending,
                      onTap: () => TreatmentDetailPopup.show(context, item, globalIndex),
                      onToggleDone: page.isPending 
                          ? (_) => _toggleTreatmentDone(item)
                          : null,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(bool isPending) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isPending ? Icons.check_circle_outline : Icons.history,
            size: 48.w,
            color: ColorManager.textTertiary,
          ),
          SizedBox(height: 12.h),
          Text(
            isPending 
                ? 'All treatments completed!' 
                : 'No completed treatments yet',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageData {
  final String title;
  final String subtitle;
  final List<TreatmentItem> items;
  final bool isPending;

  const _PageData({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.isPending,
  });
}