import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class PatientDetailsPage extends StatefulWidget {
  final String patientId;

  const PatientDetailsPage({
    super.key,
    required this.patientId,
  });

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock patient data
  final _patient = const _MockPatient(
    id: '1',
    name: 'Sarah Johnson',
    age: 32,
    gender: 'Female',
    phone: '(555) 123-4567',
    email: 'sarah.j@email.com',
    address: '123 Main St, New York, NY 10001',
    dateOfBirth: '1992-05-15',
    medicalHistory: 'No known allergies. Previous dental work includes 2 fillings.',
    insuranceProvider: 'Delta Dental',
    insuranceNumber: 'DD-123456789',
    emergencyContact: 'John Johnson - (555) 987-6543',
    status: 'active',
  );

  final List<_MockCase> _cases = [
    _MockCase(
      id: '1',
      title: 'Root Canal Treatment',
      startDate: '2024-11-01',
      endDate: '2024-12-15',
      status: 'Done',
      totalCost: 1500,
      paidAmount: 1500,
      pendingAmount: 0,
      visits: [
        _MockVisit(
          id: 'v1',
          date: '2024-11-01',
          treatmentTypes: ['X-Ray', 'Consultation'],
          teethTreated: [14],
          summary:
              'Initial consultation. X-ray shows infection in tooth 14. Recommended root canal treatment.',
          attachments: ['xray-14-nov01.jpg'],
        ),
        _MockVisit(
          id: 'v2',
          date: '2024-11-08',
          treatmentTypes: ['Root Canal'],
          teethTreated: [14],
          summary: 'First session of root canal. Removed infected pulp and cleaned canals.',
          attachments: [],
        ),
        _MockVisit(
          id: 'v3',
          date: '2024-12-15',
          treatmentTypes: ['Root Canal', 'Crown'],
          teethTreated: [14],
          summary:
              'Completed root canal and placed temporary crown. Follow-up in 2 weeks for permanent crown.',
          attachments: ['crown-14-dec15.jpg'],
        ),
      ],
    ),
    _MockCase(
      id: '2',
      title: 'Orthodontic Consultation',
      startDate: '2024-10-15',
      endDate: null,
      status: 'In Progress',
      totalCost: 3500,
      paidAmount: 1000,
      pendingAmount: 2500,
      visits: [
        _MockVisit(
          id: 'v4',
          date: '2024-10-15',
          treatmentTypes: ['Consultation', 'X-Ray'],
          teethTreated: [],
          summary: 'Full mouth evaluation for braces. Discussed treatment options and timeline.',
          attachments: ['panoramic-xray-oct15.jpg'],
        ),
        _MockVisit(
          id: 'v5',
          date: '2024-11-20',
          treatmentTypes: ['Cleaning'],
          teethTreated: [],
          summary: 'Pre-orthodontic cleaning completed. Ready for braces installation next visit.',
          attachments: [],
        ),
      ],
    ),
  ];

  final List<_MockPayment> _payments = [
    _MockPayment(
      id: '1',
      date: '2024-12-15',
      amount: 500,
      method: 'Credit Card',
      status: 'paid',
      caseId: '1',
      description: 'Root Canal - Final Payment',
    ),
    _MockPayment(
      id: '2',
      date: '2024-11-20',
      amount: 1000,
      method: 'Insurance',
      status: 'paid',
      caseId: '2',
      description: 'Orthodontic - Deposit',
    ),
    _MockPayment(
      id: '3',
      date: '2024-12-20',
      amount: 2500,
      method: 'Pending',
      status: 'pending',
      caseId: '2',
      description: 'Orthodontic - Remaining Balance',
    ),
  ];

  double get _totalPaid =>
      _payments.where((p) => p.status == 'paid').fold(0.0, (sum, p) => sum + p.amount);

  double get _totalPending =>
      _payments.where((p) => p.status == 'pending').fold(0.0, (sum, p) => sum + p.amount);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: PaddingManager.all16,
                child: Column(
                  children: [
                    _buildContactCard(),
                    SizedBox(height: 16.h),
                    _buildTabSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit, color: ColorManager.white),
                    onPressed: () {
                      // TODO: Navigate to edit patient
                    },
                  ),
                ],
              ),
            ),
            // Patient info
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 72.w,
                    height: 72.h,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorManager.white, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        _patient.name.split(' ').map((n) => n[0]).take(2).join(),
                        style: TextStyleManager.headlineMedium.copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    _patient.name,
                    style: TextStyleManager.headlineMedium.copyWith(
                      color: ColorManager.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${_patient.age} years • ${_patient.gender}',
                    style: TextStyleManager.bodyMedium.copyWith(
                      color: ColorManager.white.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Stats
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: ColorManager.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadiusManager.lg,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Total Paid',
                                style: TextStyleManager.bodySmall.copyWith(
                                  color: ColorManager.white.withValues(alpha: 0.8),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '\$${_totalPaid.toStringAsFixed(0)}',
                                style: TextStyleManager.titleLarge.copyWith(
                                  color: ColorManager.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: ColorManager.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadiusManager.lg,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Pending',
                                style: TextStyleManager.bodySmall.copyWith(
                                  color: ColorManager.white.withValues(alpha: 0.8),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '\$${_totalPending.toStringAsFixed(0)}',
                                style: TextStyleManager.titleLarge.copyWith(
                                  color: ColorManager.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: TextStyleManager.titleMedium.copyWith(
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          _buildContactRow(Icons.phone_outlined, _patient.phone),
          SizedBox(height: 12.h),
          _buildContactRow(Icons.email_outlined, _patient.email),
          SizedBox(height: 12.h),
          _buildContactRow(Icons.location_on_outlined, _patient.address),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            gradient: GradientManager.primaryButton,
            borderRadius: BorderRadiusManager.full,
          ),
          child: Icon(icon, size: 20.w, color: ColorManager.white),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyleManager.bodyMedium.copyWith(
              color: ColorManager.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    return Column(
      children: [
        // Tab bar
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadiusManager.lg,
            boxShadow: [
              BoxShadow(
                color: ColorManager.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadiusManager.lg,
            ),
            labelColor: ColorManager.white,
            unselectedLabelColor: ColorManager.textSecondary,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: ColorManager.transparent,
            labelStyle: TextStyleManager.labelLarge,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Cases'),
              Tab(text: 'Payments'),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Tab content
        SizedBox(
          height: 600.h,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(),
              _buildCasesTab(),
              _buildPaymentsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Medical History',
            style: TextStyleManager.titleMedium.copyWith(
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _patient.medicalHistory,
            style: TextStyleManager.bodyMedium.copyWith(
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: 20.h),
          _buildInfoRow('Date of Birth', _patient.dateOfBirth),
          _buildInfoRow('Insurance Provider', _patient.insuranceProvider),
          _buildInfoRow('Insurance Number', _patient.insuranceNumber),
          _buildInfoRow('Emergency Contact', _patient.emergencyContact),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyleManager.bodyMedium.copyWith(
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Text(
              value,
              style: TextStyleManager.bodyMedium.copyWith(
                color: ColorManager.textPrimary,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCasesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_cases.length} total cases',
              style: TextStyleManager.bodyMedium.copyWith(
                color: ColorManager.textSecondary,
              ),
            ),
            SizedBox(
              height: 40.h,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add, size: 18.w),
                label: const Text('New Case'),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: ListView.separated(
            itemCount: _cases.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) => _buildCaseCard(_cases[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildCaseCard(_MockCase caseItem) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      caseItem.title,
                      style: TextStyleManager.titleMedium.copyWith(
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Started: ${caseItem.startDate}${caseItem.endDate != null ? ' • Ended: ${caseItem.endDate}' : ''}',
                      style: TextStyleManager.bodySmall.copyWith(
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              StatusBadge(
                label: caseItem.status,
                type: _getCaseStatusType(caseItem.status),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Payment info
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ColorManager.gray50,
              borderRadius: BorderRadiusManager.lg,
            ),
            child: Column(
              children: [
                _buildPaymentRow('Total Cost', '\$${caseItem.totalCost.toStringAsFixed(0)}', null),
                SizedBox(height: 8.h),
                _buildPaymentRow(
                    'Paid', '\$${caseItem.paidAmount.toStringAsFixed(0)}', ColorManager.success),
                if (caseItem.pendingAmount > 0) ...[
                  SizedBox(height: 8.h),
                  _buildPaymentRow('Pending', '\$${caseItem.pendingAmount.toStringAsFixed(0)}',
                      ColorManager.warning),
                ],
              ],
            ),
          ),
          SizedBox(height: 12.h),
          // Visits
          Text(
            'Visits (${caseItem.visits.length})',
            style: TextStyleManager.labelLarge.copyWith(
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          ...caseItem.visits.map((visit) => _buildVisitCard(visit)),
          SizedBox(height: 12.h),
          // Actions
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  text: 'Extract PDF',
                  icon: Icon(Icons.download_outlined, size: 18.w),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: PrimaryButton(
                  text: 'Add Visit',
                  icon: Icon(Icons.add, size: 18.w, color: ColorManager.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, Color? valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyleManager.bodyMedium.copyWith(
            color: ColorManager.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyleManager.bodyMedium.copyWith(
            color: valueColor ?? ColorManager.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildVisitCard(_MockVisit visit) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.gray200),
        borderRadius: BorderRadiusManager.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  gradient: GradientManager.primaryButton,
                  borderRadius: BorderRadiusManager.full,
                ),
                child: Icon(Icons.calendar_today, size: 16.w, color: ColorManager.white),
              ),
              SizedBox(width: 8.w),
              Text(
                visit.date,
                style: TextStyleManager.titleSmall.copyWith(
                  color: ColorManager.textPrimary,
                ),
              ),
              if (visit.teethTreated.isNotEmpty) ...[
                SizedBox(width: 8.w),
                Text(
                  '• Teeth: ${visit.teethTreated.join(', ')}',
                  style: TextStyleManager.bodySmall.copyWith(
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: visit.treatmentTypes
                .map((type) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        gradient: GradientManager.primaryButton,
                        borderRadius: BorderRadiusManager.full,
                      ),
                      child: Text(
                        type,
                        style: TextStyleManager.labelSmall.copyWith(
                          color: ColorManager.white,
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 8.h),
          Text(
            visit.summary,
            style: TextStyleManager.bodySmall.copyWith(
              color: ColorManager.textSecondary,
            ),
          ),
          if (visit.attachments.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.attach_file, size: 16.w, color: ColorManager.textTertiary),
                SizedBox(width: 4.w),
                Text(
                  '${visit.attachments.length} attachment(s)',
                  style: TextStyleManager.bodySmall.copyWith(
                    color: ColorManager.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_payments.length} transactions',
              style: TextStyleManager.bodyMedium.copyWith(
                color: ColorManager.textSecondary,
              ),
            ),
            SizedBox(
              height: 40.h,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add, size: 18.w),
                label: const Text('Record Payment'),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: ListView.separated(
            itemCount: _payments.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) => _buildPaymentCard(_payments[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCard(_MockPayment payment) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment.description,
                      style: TextStyleManager.titleSmall.copyWith(
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      payment.method,
                      style: TextStyleManager.bodySmall.copyWith(
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              StatusBadge(
                label: payment.status == 'paid' ? 'Paid' : 'Pending',
                type: payment.status == 'paid' ? StatusType.success : StatusType.pending,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16.w, color: ColorManager.textTertiary),
                  SizedBox(width: 4.w),
                  Text(
                    payment.date,
                    style: TextStyleManager.bodySmall.copyWith(
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
              Text(
                '\$${payment.amount.toStringAsFixed(0)}',
                style: TextStyleManager.titleMedium.copyWith(
                  color: ColorManager.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  StatusType _getCaseStatusType(String status) {
    switch (status) {
      case 'Done':
        return StatusType.completed;
      case 'In Progress':
        return StatusType.success;
      case 'Pending':
        return StatusType.pending;
      default:
        return StatusType.pending;
    }
  }
}

// Mock data classes
class _MockPatient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String email;
  final String address;
  final String dateOfBirth;
  final String medicalHistory;
  final String insuranceProvider;
  final String insuranceNumber;
  final String emergencyContact;
  final String status;

  const _MockPatient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.dateOfBirth,
    required this.medicalHistory,
    required this.insuranceProvider,
    required this.insuranceNumber,
    required this.emergencyContact,
    required this.status,
  });
}

class _MockCase {
  final String id;
  final String title;
  final String startDate;
  final String? endDate;
  final String status;
  final double totalCost;
  final double paidAmount;
  final double pendingAmount;
  final List<_MockVisit> visits;

  const _MockCase({
    required this.id,
    required this.title,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.totalCost,
    required this.paidAmount,
    required this.pendingAmount,
    required this.visits,
  });
}

class _MockVisit {
  final String id;
  final String date;
  final List<String> treatmentTypes;
  final List<int> teethTreated;
  final String summary;
  final List<String> attachments;

  const _MockVisit({
    required this.id,
    required this.date,
    required this.treatmentTypes,
    required this.teethTreated,
    required this.summary,
    required this.attachments,
  });
}

class _MockPayment {
  final String id;
  final String date;
  final double amount;
  final String method;
  final String status;
  final String caseId;
  final String description;

  const _MockPayment({
    required this.id,
    required this.date,
    required this.amount,
    required this.method,
    required this.status,
    required this.caseId,
    required this.description,
  });
}
