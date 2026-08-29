import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/presentation/bloc/billing_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/file_picker/file_picker_service.dart';
import 'package:dental_clinic_app/services/file_picker/picked_file_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SubmitPaymentProofPage extends StatelessWidget {
  const SubmitPaymentProofPage({super.key, required this.invoice});

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BillingBloc>()
        ..add(BillingEvent.selectInvoice(invoice)),
      child: _SubmitPaymentProofView(invoice: invoice),
    );
  }
}

class _SubmitPaymentProofView extends StatefulWidget {
  const _SubmitPaymentProofView({required this.invoice});

  final InvoiceEntity invoice;

  @override
  State<_SubmitPaymentProofView> createState() =>
      _SubmitPaymentProofViewState();
}

class _SubmitPaymentProofViewState extends State<_SubmitPaymentProofView> {
  final _formKey = GlobalKey<FormState>();
  final _refController = TextEditingController();
  final _notesController = TextEditingController();
  final _picker = getIt<FilePickerService>();

  PickedFileResult? _receipt;
  ManualPaymentMethod _method = ManualPaymentMethod.bankTransfer;

  @override
  void dispose() {
    _refController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return AdaptivePageScaffold(
      title: l10n.submitProofTitle,
      backgroundColor: c.scaffoldBg,
      body: BlocConsumer<BillingBloc, BillingState>(
        listener: (context, state) {
          if (state.error != null) {
            AppSnackbar.showError(
              context,
              title: l10n.errorTitle,
              message: state.error!,
            );
            context.read<BillingBloc>().add(
                  const BillingEvent.clearFlags(),
                );
          }
          if (state.proofSubmitted) {
            context.read<BillingBloc>().add(
                  const BillingEvent.clearFlags(),
                );
            AppSnackbar.showSuccess(
              context,
              title: l10n.proofSubmittedTitle,
              message: l10n.proofSubmittedMessage,
            );
            context.pop();
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
                    children: [
                      Text(
                        l10n.invoiceNumberLabel(widget.invoice.number),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: fontFamily,
                          color: c.textSecondary,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _ReceiptPicker(
                        receipt: _receipt,
                        onPick: _pickReceipt,
                      ),
                      SizedBox(height: 16.h),
                      _MethodSelector(
                        method: _method,
                        onChanged: (m) => setState(() => _method = m),
                      ),
                      SizedBox(height: 16.h),
                      AppFormField(
                        label: l10n.transactionReferenceLabel,
                        controller: _refController,
                        hintText: l10n.transactionReferenceHint,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return l10n.fieldRequired;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      AppFormField(
                        label: l10n.notesOptional,
                        controller: _notesController,
                        hintText: l10n.notesHint,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                // Explicit bottom inset using viewPadding so the button
                // always clears the Android system nav bar in edge-to-edge
                // mode — SafeArea here was sometimes resolving to 0.
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom,
                  ),
                  child: PrimaryButton(
                    text: l10n.submitForReview,
                    isLoading: state.isProcessing,
                    onPressed: () => _onSubmit(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickReceipt() async {
    final picked = await _picker.pickImage();
    if (picked != null) {
      setState(() => _receipt = picked);
    }
  }

  void _onSubmit(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_receipt == null) {
      AppSnackbar.showError(
        context,
        title: l10n.errorTitle,
        message: l10n.receiptRequired,
      );
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<BillingBloc>().add(
          BillingEvent.submitProof(
            invoiceId: widget.invoice.id,
            receipt: _receipt!.file,
            referenceNumber: _refController.text.trim(),
            method: _method,
            notes: _notesController.text.trim().isEmpty
                ? null
                : _notesController.text.trim(),
          ),
        );
  }
}

class _ReceiptPicker extends StatelessWidget {
  const _ReceiptPicker({required this.receipt, required this.onPick});

  final PickedFileResult? receipt;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return GestureDetector(
      onTap: onPick,
      child: Container(
        height: 180.h,
        decoration: BoxDecoration(
          color: c.cardBgSecondary,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: receipt == null
                ? c.border
                : ColorManager.primary.withValues(alpha: 0.4),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: receipt == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined,
                      size: 36.w, color: c.textTertiary),
                  SizedBox(height: 8.h),
                  Text(
                    l10n.uploadReceipt,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w600,
                      color: c.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    l10n.uploadReceiptHint,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: fontFamily,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: receipt!.isImage
                          ? Image.file(receipt!.file, fit: BoxFit.cover)
                          : Container(
                              color: c.cardBgSecondary,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.description_outlined,
                                        size: 32.w, color: c.textSecondary),
                                    SizedBox(height: 6.h),
                                    Text(
                                      receipt!.name,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: fontFamily,
                                        color: c.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.refresh,
                            size: 16.w, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _MethodSelector extends StatelessWidget {
  const _MethodSelector({required this.method, required this.onChanged});

  final ManualPaymentMethod method;
  final ValueChanged<ManualPaymentMethod> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.methodUsed,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            color: c.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: c.inputBg,
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ManualPaymentMethod>(
              value: method,
              isExpanded: true,
              icon: Icon(Icons.expand_more, color: c.textSecondary),
              items: ManualPaymentMethod.values
                  .map(
                    (m) => DropdownMenuItem(
                      value: m,
                      child: Text(
                        _label(m, l10n),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: fontFamily,
                          color: c.textPrimary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _label(ManualPaymentMethod method, AppLocalizations l10n) {
    switch (method) {
      case ManualPaymentMethod.cash:
        return l10n.paymentMethodCash;
      case ManualPaymentMethod.syriatelCash:
        return l10n.paymentMethodSyriatelCash;
      case ManualPaymentMethod.shamCash:
        return l10n.paymentMethodShamCash;
      case ManualPaymentMethod.bankTransfer:
        return l10n.paymentMethodBankTransfer;
    }
  }
}
