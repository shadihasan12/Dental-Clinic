import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/custom_widgets/currency_chips.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/domain/use_cases/get_categories_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/services/currency/currency_bloc.dart';
import 'package:dental_clinic_app/services/file_picker/file_picker_service.dart';
import 'package:dental_clinic_app/services/file_picker/picked_file_model.dart';
import 'package:dental_clinic_app/services/media/media_service.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key, required this.onSave, this.expense});

  final ValueChanged<Map<String, dynamic>> onSave;
  final ExpenseEntity? expense;

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _customCategoryController = TextEditingController();
  DateTime _date = DateTime.now();
  ExpenseCategoryEntity? _selectedCategory;
  CurrencyEntity? _selectedCurrency;
  bool _isOtherCategory = false;
  final List<PickedFileResult> _attachments = [];
  final List<String> _uploadedMediaIds = [];
  bool _isUploading = false;

  List<ExpenseCategoryEntity> _categories = [];
  bool _categoriesLoading = true;

  bool get _isEditing => widget.expense != null;

  /// Shown only after the first save attempt, then kept current on every
  /// edit - the same discipline the patient and appointment forms use.
  _ExpenseErrors _errors = _ExpenseErrors.none;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _initCurrency();

    if (_isEditing) {
      final e = widget.expense!;
      _amountController.text = e.amount;
      _noteController.text = e.notes;
      _date = DateTime.tryParse(e.entryDate) ?? DateTime.now();
    }
  }

  void _initCurrency() {
    final bloc = getIt<CurrencyBloc>();
    // Try current state first
    _trySelectCurrency(bloc.state);

    // If not loaded yet, listen for future state changes
    if (_selectedCurrency == null) {
      bloc.stream.listen((state) {
        if (!mounted) return;
        if (_selectedCurrency == null) {
          _trySelectCurrency(state);
          if (_selectedCurrency != null) setState(() {});
        }
      });
    }
  }

  void _trySelectCurrency(CurrencyState state) {
    state.whenOrNull(
      loaded: (currencies) {
        _selectedCurrency =
            currencies.where((c) => c.currencyCode == 'SYP').firstOrNull ??
            (currencies.isNotEmpty ? currencies.first : null);

        if (_isEditing) {
          final e = widget.expense!;
          _selectedCurrency =
              currencies.where((c) => c.id == e.currency.id).firstOrNull ??
              _selectedCurrency;
        }
      },
    );
  }

  Future<void> _loadCategories() async {
    final result = await getIt<GetCategoriesUseCase>()(NoParams());
    if (!mounted) return;

    result.fold((_) => setState(() => _categoriesLoading = false), (
      categories,
    ) {
      setState(() {
        _categories = categories;
        _categoriesLoading = false;

        if (_isEditing) {
          final e = widget.expense!;
          _selectedCategory = categories
              .where((c) => c.id == e.category.id)
              .firstOrNull;
          if (_selectedCategory == null) {
            _isOtherCategory = true;
            _customCategoryController.text = e.category.name;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _customCategoryController.dispose();
    super.dispose();
  }

  Future<void> _pickAttachment() async {
    final picked = await getIt<FilePickerService>().pickFile();
    if (picked == null) return;

    setState(() {
      _attachments.add(picked);
      _isUploading = true;
    });

    try {
      final uploadResult = await getIt<MediaService>().uploadFile(picked.file);
      _uploadedMediaIds.add(uploadResult.id);
    } catch (_) {
      if (mounted) {
        setState(() => _attachments.removeLast());
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
      if (index < _uploadedMediaIds.length) {
        _uploadedMediaIds.removeAt(index);
      }
    });
  }

  _ExpenseErrors _validate() {
    final l10n = AppLocalizations.of(context)!;
    final amount = _amountController.text.trim();
    final parsed = double.tryParse(amount);
    return _ExpenseErrors(
      amount: amount.isEmpty
          ? l10n.pleaseEnterAmount
          : (parsed == null || parsed <= 0
                ? l10n.pleaseEnterValidAmount
                : null),
      category: _selectedCategory == null
          ? l10n.pleaseSelectExpenseType
          : (_isOtherCategory && _customCategoryController.text.trim().isEmpty
                ? l10n.pleaseSelectExpenseType
                : null),
      currency: _selectedCurrency == null ? l10n.pleaseSelectCurrency : null,
    );
  }

  void _revalidate() {
    if (!_submitted) return;
    final next = _validate();
    if (next != _errors) setState(() => _errors = next);
  }

  void _save() {
    FocusScope.of(context).unfocus();
    final errors = _validate();
    setState(() {
      _submitted = true;
      _errors = errors;
    });
    if (errors.hasAny) return;

    final body = <String, dynamic>{
      'amount': _amountController.text,
      'currency_id': _selectedCurrency!.id,
    };

    // Category (required)
    if (_isOtherCategory && _customCategoryController.text.trim().isNotEmpty) {
      body['new_category_name'] = _customCategoryController.text.trim();
    } else {
      body['expense_category_id'] = _selectedCategory!.id;
    }

    // Optional fields
    final note = _noteController.text.trim();
    if (note.isNotEmpty) {
      body['notes'] = note;
    }

    body['entry_date'] = DateFormat('yyyy-MM-dd').format(_date);

    if (_uploadedMediaIds.isNotEmpty) {
      body['media_ids'] = _uploadedMediaIds;
    }

    widget.onSave(body);
    Navigator.pop(context);
  }

  Future<void> _selectDate() async {
    final l10n = AppLocalizations.of(context)!;
    final picked = await DatePickerSheet.show(
      context,
      title: l10n.date,
      initial: _date,
      minimum: DateTime(2020),
      maximum: DateTime.now(),
    );
    if (picked == null || !mounted) return;
    setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return FormSheetShell(
      title: _isEditing ? l10n.edit : l10n.addExpense,
      footer: FormSheetButton(
        label: l10n.save,
        onPressed: _save,
        busy: _isUploading,
      ),
      children: [
        // The amount is the one number this sheet exists to capture, so it
        // stays a hero figure rather than another 13sp row.
        FormFieldShell(
          label: l10n.amount,
          required: true,
          errorText: _errors.amount,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: formInputDecoration(
              context,
              focused: false,
              hasError: _errors.amount != null,
            ),
            child: TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              autofocus: !_isEditing,
              onChanged: (_) => _revalidate(),
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 26.sp,
                height: 1.3,
                letterSpacing: -0.5,
                fontWeight: FontWeight.w700,
                color: c.textPrimary,
              ),
              decoration: bareInputDecoration().copyWith(
                hintText: '0',
                hintStyle: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 26.sp,
                  height: 1.3,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w700,
                  color: c.textSubtle.withValues(alpha: 0.5),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // Currency
        BlocBuilder<CurrencyBloc, CurrencyState>(
          bloc: getIt<CurrencyBloc>(),
          builder: (context, currencyState) {
            return currencyState.maybeWhen(
              loaded: (currencies) {
                if (currencies.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: FormFieldShell(
                    label: l10n.currency,
                    required: true,
                    errorText: _errors.currency,
                    child: CurrencyChips(
                      currencies: currencies,
                      selectedCurrency: _selectedCurrency,
                      onSelected: (cur) {
                        setState(() => _selectedCurrency = cur);
                        _revalidate();
                      },
                    ),
                  ),
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),

        // Category
        if (_categoriesLoading)
          FormFieldShell(
            label: l10n.expenseType,
            required: true,
            child: ShimmerBox(
              width: double.infinity,
              height: 42.h,
              radius: BorderRadius.circular(12.r),
            ),
          )
        else
          _buildCategoryDropdown(context, l10n),

        if (_isOtherCategory) ...[
          SizedBox(height: 12.h),
          FormTextField(
            label: l10n.expenseType,
            required: true,
            controller: _customCategoryController,
            hintText: l10n.whatWasThisFor,
            errorText: _errors.category,
            onChanged: _revalidate,
          ),
        ],
        SizedBox(height: 12.h),

        FormDateField(label: l10n.date, value: _date, onTap: _selectDate),
        SizedBox(height: 12.h),

        FormTextField(
          label: l10n.notes,
          controller: _noteController,
          hintText: l10n.addNoteOptional,
          maxLines: 3,
        ),
        SizedBox(height: 12.h),

        _buildAttachmentsSection(l10n),
        SizedBox(height: 4.h),
      ],
    );
  }

  Widget _buildCategoryDropdown(BuildContext context, AppLocalizations l10n) {
    return FormDropdownField<ExpenseCategoryEntity>(
      label: l10n.expenseType,
      required: true,
      value: _selectedCategory,
      items: _categories,
      itemLabel: (cat) => cat.name,
      hint: l10n.expenseType,
      // The custom-name field carries its own error once "other" is picked.
      errorText: _isOtherCategory ? null : _errors.category,
      onChanged: (v) {
        if (v == null) return;
        final name = v.name.toLowerCase();
        final isOther = name == 'other' || name == 'أخرى';
        setState(() {
          _selectedCategory = v;
          _isOtherCategory = isOther;
          if (isOther) _customCategoryController.clear();
        });
        _revalidate();
      },
    );
  }

  Widget _buildAttachmentsSection(AppLocalizations l10n) {
    final c = ColorManager.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Attachment thumbnails
        if (_attachments.isNotEmpty) ...[
          SizedBox(
            height: 70.w,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _attachments.length,
              separatorBuilder: (_, _) => SizedBox(width: 8.w),
              itemBuilder: (_, index) {
                final picked = _attachments[index];
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: picked.isImage
                          ? Image.file(
                              picked.file,
                              width: 70.w,
                              height: 70.w,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 70.w,
                              height: 70.w,
                              color: c.cardBgSecondary,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.insert_drive_file_outlined,
                                    size: 24.w,
                                    color: c.textSecondary,
                                  ),
                                  SizedBox(height: 4.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                    ),
                                    child: Text(
                                      picked.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        color: c.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: GestureDetector(
                        onTap: () => _removeAttachment(index),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 14.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
        ],

        // Add attachment button
        GestureDetector(
          onTap: _isUploading ? null : _pickAttachment,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
            decoration: formInputDecoration(
              context,
              focused: false,
              hasError: false,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 16.w,
                  color: c.textTertiary,
                ),
                SizedBox(width: 6.w),
                Text(
                  l10n.addReceipt,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: c.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// The three values this sheet cannot be saved without.
class _ExpenseErrors {
  const _ExpenseErrors({this.amount, this.category, this.currency});

  final String? amount;
  final String? category;
  final String? currency;

  static const _ExpenseErrors none = _ExpenseErrors();

  bool get hasAny => amount != null || category != null || currency != null;

  @override
  bool operator ==(Object other) =>
      other is _ExpenseErrors &&
      other.amount == amount &&
      other.category == category &&
      other.currency == currency;

  @override
  int get hashCode => Object.hash(amount, category, currency);
}
