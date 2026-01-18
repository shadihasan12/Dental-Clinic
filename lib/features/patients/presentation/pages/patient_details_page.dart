import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/widgets.dart';

import '../widgets/details/widgets.dart';

class PatientDetailsPage extends StatefulWidget {
  final String patientId;

  const PatientDetailsPage({super.key, required this.patientId});

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data
  final _patient = const _MockPatient(
    id: '1',
    name: 'Sarah Johnson',
    age: 32,
    gender: 'Female',
    phone: '+963988026431',
    email: 'sarah.j@email.com',
    address: '123 Main St, New York, NY 10001',
    dateOfBirth: '1992-05-15',
    medicalHistory:
        'No known allergies. Previous dental work includes 2 fillings.',
    insuranceProvider: 'Delta Dental',
    insuranceNumber: 'DD-123456789',
    emergencyContact: 'John Johnson - (555) 987-6543',
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
      // visits: [
      //   VisitData(
      //     date: '2024-11-01',
      //     treatmentTypes: ['X-Ray', 'Consultation'],
      //     teethTreated: [14],
      //     summary: 'Initial consultation. X-ray shows infection in tooth 14.',
      //     attachments: ['xray-14-nov01.jpg'],
      //   ),
      //   VisitData(
      //     date: '2024-11-08',
      //     treatmentTypes: ['Root Canal'],
      //     teethTreated: [14],
      //     summary: 'First session of root canal. Removed infected pulp.',
      //     attachments: [],
      //   ),
      // ],
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
      // visits: [
      //   VisitData(
      //     date: '2024-10-15',
      //     treatmentTypes: ['Consultation', 'X-Ray'],
      //     teethTreated: [],
      //     summary: 'Full mouth evaluation for braces.',
      //     attachments: ['panoramic-xray-oct15.jpg'],
      //   ),
      // ],
    ),
  ];

  final List<_MockPayment> _payments = [
    _MockPayment(
      date: '2024-12-15',
      amount: 500,
      method: 'Credit Card',
      isPaid: true,
      description: 'Root Canal - Final Payment',
    ),
    _MockPayment(
      date: '2024-11-20',
      amount: 1000,
      method: 'Insurance',
      isPaid: true,
      description: 'Orthodontic - Deposit',
    ),
    _MockPayment(
      date: '2024-12-20',
      amount: 2500,
      method: 'Pending',
      isPaid: false,
      description: 'Orthodontic - Remaining Balance',
    ),
  ];

  double get _totalPaid =>
      _payments.where((p) => p.isPaid).fold(0.0, (sum, p) => sum + p.amount);

  double get _totalPending =>
      _payments.where((p) => !p.isPaid).fold(0.0, (sum, p) => sum + p.amount);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          PatientHeader(
            name: _patient.name,
            age: _patient.age,
            gender: _patient.gender,
            totalPaid: _totalPaid,
            totalPending: _totalPending,
            onBackPressed: () => context.pop(),
            onEditPressed: () {
              // TODO: Navigate to edit patient
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: PaddingManager.all16,
                child: Column(
                  children: [
                    ContactInfoCard(
                      phone: _patient.phone,
                      email: _patient.email,
                      address: _patient.address,
                    ),
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

  Widget _buildTabSection() {
    return Column(
      children: [
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
            onTap: (index) => setState(() => {}),
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Cases'),
              // Tab(text: 'Payments'),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildTabContent(),
      ],
    );
  }

  Widget _buildTabContent() {
    switch (_tabController.index) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildCasesTab();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildOverviewTab() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Medical History',
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _patient.medicalHistory,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w400,
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
              style: TextStyle(
                color: ColorManager.textSecondary,
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w400,
              ),
            ),
            _buildAddButton(
              'New Case',
              onTap: () {
                context.pushNamed(
                  AppRoutesNames.newCase,
                  pathParameters: {'patientId': _patient.id},
                  extra: {'patientName': _patient.name},
                );
              },
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Column(
          children: _cases
              .map(
                (c) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: CaseCard(
                    title: c.title,
                    startDate: c.startDate,
                    endDate: c.endDate,
                    status: c.status,
                    totalCost: c.totalCost,
                    paidAmount: c.paidAmount,
                    pendingAmount: c.pendingAmount,
                    id: '',
                    onViewMore: () => context.pushNamed(
                      AppRoutesNames.caseDetails,
                      pathParameters: {'caseId': c.id},
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
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
            _buildAddButton('Record Payment', onTap: () {}),
          ],
        ),
        SizedBox(height: 12.h),
        Column(
          children: List.generate(
            _payments.length,
            (index) => PaymentCard(
              description: _payments[index].description,
              method: _payments[index].method,
              date: _payments[index].date,
              amount: _payments[index].amount,
              isPaid: _payments[index].isPaid,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadiusManager.full,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 18.w, color: ColorManager.white),
            SizedBox(width: 4.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w500,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simplified mock classes
class _MockPatient {
  final String id, name, gender, phone, email, address, dateOfBirth;
  final String medicalHistory,
      insuranceProvider,
      insuranceNumber,
      emergencyContact;
  final int age;

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
  });
}

class _MockCase {
  final String id, title, startDate, status;
  final String? endDate;
  final double totalCost, paidAmount, pendingAmount;
  // final List<VisitData> visits;

  const _MockCase({
    required this.id,
    required this.title,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.totalCost,
    required this.paidAmount,
    required this.pendingAmount,
    // required this.visits,
  });
}

class _MockPayment {
  final String date, method, description;
  final double amount;
  final bool isPaid;

  const _MockPayment({
    required this.date,
    required this.amount,
    required this.method,
    required this.isPaid,
    required this.description,
  });
}
