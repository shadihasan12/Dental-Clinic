import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/custom_widgets/currency_chips.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/domain/use_cases/get_categories_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/services/currency/currency_bloc.dart';
import 'package:dental_clinic_app/services/file_picker/file_picker_service.dart';
import 'package:dental_clinic_app/services/file_picker/picked_file_model.dart';
import 'package:dental_clinic_app/services/media/media_service.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/cupertino.dart';
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
    _trySelectCurrency(bloc.state);

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
    PickedFileResult? picked;
    try {
      picked = await getIt<FilePickerService>().pickFile();
    } catch (e, st) {
      debugPrint('[AddExpense] pickFile threw: $e\n$st');
      if (mounted) _showError('Could not open file picker: $e');
      return;
    }
    if (picked == null) return;

    setState(() {
      _attachments.add(picked!);
      _isUploading = true;
    });

    try {
      final uploadResult = await getIt<MediaService>().uploadFile(picked.file);
      _uploadedMediaIds.add(uploadResult.id);
    } catch (e, st) {
      debugPrint('[AddExpense] upload failed: $e\n$st');
      if (mounted) {
        setState(() => _attachments.removeLast());
        _showError('Upload failed: $e');
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontFamily: FontHelper.fontFamily(context)),
        ),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void _removeAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
      if (index < _uploadedMediaIds.length) {
        _uploadedMediaIds.removeAt(index);
      }
    });
  }

  void _save() {
    if (_amountController.text.isEmpty) return;
    if (_selectedCategory == null) return;
    if (_isOtherCategory && _customCategoryController.text.trim().isEmpty) {
      return;
    }
    if (_selectedCurrency == null) return;

    final body = <String, dynamic>{
      'amount': _amountController.text,
      'currency_id': _selectedCurrency!.id,
    };

    if (_isOtherCategory && _customCategoryController.text.trim().isNotEmpty) {
      body['new_category_name'] = _customCategoryController.text.trim();
    } else {
      body['expense_category_id'] = _selectedCategory!.id;
    }

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
    if (Responsive.isDesktop(context)) {
      final picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        builder: (ctx, child) {
          return Theme(
            data: Theme.of(ctx).copyWith(
              colorScheme: Theme.of(ctx).colorScheme.copyWith(
                    primary: ColorManager.primary,
                  ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null) setState(() => _date = picked);
      return;
    }

    // Mobile: Cupertino-style bottom sheet
    DateTime tempDate = _date;
    final l10n = AppLocalizations.of(context)!;

    final picked = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: ColorManager.of(context).cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (ctx) => SizedBox(
        height: 300.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(
                      l10n.cancel,
                      style: TextStyle(
                        color: ColorManager.of(ctx).textSecondary,
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(ctx),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, tempDate),
                    child: Text(
                      l10n.save,
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontHelper.fontFamily(ctx),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: ColorManager.of(ctx).divider),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _date,
                minimumDate: DateTime(2020),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (date) => tempDate = date,
              ),
            ),
          ],
        ),
      ),
    );

    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) return _buildDesktop(context);
    return _buildMobile(context);
  }

  // ═══════════════════════════════════════════════════════════════════
  // MOBILE LAYOUT (unchanged)
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildMobile(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final bottomPadding =
        MediaQuery.of(context).viewInsets.bottom +
        MediaQuery.of(context).viewPadding.bottom;
    final formatted = DateFormat('MMM d, yyyy').format(_date);
    final isToday = DateUtils.isSameDay(_date, DateTime.now());

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h + bottomPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: c.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              _isEditing ? l10n.edit : l10n.addExpense,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
            SizedBox(height: 20.h),

            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              autofocus: !_isEditing,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: c.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: c.border,
                ),
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 16.h),

            _categoriesLoading
                ? _mobileLoadingBox(l10n)
                : _buildCategoryDropdown(context, l10n, desktop: false),

            if (_isOtherCategory) ...[
              SizedBox(height: 10.h),
              TextField(
                controller: _customCategoryController,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  hintText: l10n.whatWasThisFor,
                  hintStyle: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 14.sp,
                    color: c.textSubtle,
                  ),
                  filled: true,
                  fillColor: c.inputBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ],
            SizedBox(height: 14.h),

            TextField(
              controller: _noteController,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: l10n.addNoteOptional,
                hintStyle: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 14.sp,
                  color: c.textSubtle,
                ),
                filled: true,
                fillColor: c.inputBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            BlocBuilder<CurrencyBloc, CurrencyState>(
              bloc: getIt<CurrencyBloc>(),
              builder: (context, currencyState) {
                return currencyState.maybeWhen(
                  loaded: (currencies) {
                    if (currencies.isEmpty) return const SizedBox.shrink();
                    return Column(
                      children: [
                        CurrencyChips(
                          currencies: currencies,
                          selectedCurrency: _selectedCurrency,
                          onSelected: (c) =>
                              setState(() => _selectedCurrency = c),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),

            GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: c.inputBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14.w,
                      color: c.textSecondary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      isToday ? l10n.today : formatted,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: c.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 14.h),

            _buildAttachmentsSection(l10n, desktop: false),

            SizedBox(height: 20.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isUploading ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _isUploading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        l10n.save,
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _mobileLoadingBox(AppLocalizations l10n) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: c.inputBg,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 16.w,
            height: 16.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: c.textSubtle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            l10n.filter,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 13.sp,
              color: c.textSubtle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown(
    BuildContext context,
    AppLocalizations l10n, {
    required bool desktop,
  }) {
    final c = ColorManager.of(context);
    final hPad = desktop ? 14.0 : 12.w;
    final fontSize = desktop ? 14.0 : 13.sp;
    final iconSize = desktop ? 20.0 : 18.w;
    final radius = desktop ? 10.0 : 10.r;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad),
      decoration: BoxDecoration(
        color: c.inputBg,
        borderRadius: BorderRadius.circular(radius),
        border: desktop ? Border.all(color: c.borderLight) : null,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ExpenseCategoryEntity>(
          value: _selectedCategory,
          isExpanded: true,
          hint: Text(
            l10n.expenseType,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: fontSize,
              color: c.textSubtle,
            ),
          ),
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: fontSize,
            color: c.textPrimary,
          ),
          icon: Icon(
            Icons.expand_more,
            size: iconSize,
            color: c.textSubtle,
          ),
          items: _categories
              .map(
                (cat) => DropdownMenuItem(
                  value: cat,
                  child: Text(
                    cat.name,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: fontSize,
                      color: c.textPrimary,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (v) {
            if (v == null) return;
            final name = v.name.toLowerCase();
            final isOther = name == 'other' || name == 'أخرى';
            setState(() {
              _selectedCategory = v;
              _isOtherCategory = isOther;
              if (isOther) _customCategoryController.clear();
            });
          },
        ),
      ),
    );
  }

  Widget _buildAttachmentsSection(
    AppLocalizations l10n, {
    required bool desktop,
  }) {
    final c = ColorManager.of(context);
    final thumbSize = desktop ? 64.0 : 70.w;
    final gap = desktop ? 8.0 : 8.w;
    final vPad = desktop ? 12.0 : 10.h;
    final hPad = desktop ? 14.0 : 12.w;
    final radius = desktop ? 10.0 : 10.r;
    final iconSize = desktop ? 16.0 : 16.w;
    final fontSize = desktop ? 13.0 : 13.sp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_attachments.isNotEmpty) ...[
          SizedBox(
            height: thumbSize,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _attachments.length,
              separatorBuilder: (_, _) => SizedBox(width: gap),
              itemBuilder: (_, index) {
                final picked = _attachments[index];
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: picked.isImage
                          ? Image.file(
                              picked.file,
                              width: thumbSize,
                              height: thumbSize,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: thumbSize,
                              height: thumbSize,
                              color: c.cardBgSecondary,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.insert_drive_file_outlined,
                                    size: desktop ? 22 : 24.w,
                                    color: c.textSecondary,
                                  ),
                                  SizedBox(height: desktop ? 4 : 4.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: desktop ? 4 : 4.w,
                                    ),
                                    child: Text(
                                      picked.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: desktop ? 8.5 : 8.sp,
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
                            size: desktop ? 14 : 14.w,
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
          SizedBox(height: desktop ? 10 : 10.h),
        ],

        GestureDetector(
          onTap: _isUploading ? null : _pickAttachment,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
            decoration: BoxDecoration(
              color: c.inputBg,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: c.divider,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.attach_file,
                  size: iconSize,
                  color: c.textSecondary,
                ),
                SizedBox(width: desktop ? 6 : 6.w),
                Text(
                  l10n.attachments,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: fontSize,
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

  // ═══════════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildDesktop(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Header ────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 16, 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: c.borderLight)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _isEditing
                      ? Icons.edit_outlined
                      : Icons.receipt_long_outlined,
                  color: ColorManager.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isEditing ? l10n.edit : l10n.addExpense,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 17,
                        fontWeight: FontWeightManager.semiBold,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.saveExpense,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 20, color: c.textSecondary),
                splashRadius: 18,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),

        // ── Scrollable body ───────────────────────────────────
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Amount
                _desktopFieldLabel(l10n.amount, fontFamily, c),
                const SizedBox(height: 8),
                _DesktopAmountField(
                  controller: _amountController,
                  currencyCode: _selectedCurrency?.currencyCode,
                  fontFamily: fontFamily,
                ),
                const SizedBox(height: 18),

                // Currency chips
                BlocBuilder<CurrencyBloc, CurrencyState>(
                  bloc: getIt<CurrencyBloc>(),
                  builder: (context, currencyState) {
                    return currencyState.maybeWhen(
                      loaded: (currencies) {
                        if (currencies.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _desktopFieldLabel(
                                l10n.currency, fontFamily, c),
                            const SizedBox(height: 8),
                            _DesktopCurrencyChips(
                              currencies: currencies,
                              selected: _selectedCurrency,
                              onSelected: (v) =>
                                  setState(() => _selectedCurrency = v),
                              fontFamily: fontFamily,
                            ),
                            const SizedBox(height: 18),
                          ],
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),

                // Category + Date row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _desktopFieldLabel(
                              l10n.expenseType, fontFamily, c),
                          const SizedBox(height: 8),
                          _categoriesLoading
                              ? _desktopLoadingField(c)
                              : _buildCategoryDropdown(
                                  context,
                                  l10n,
                                  desktop: true,
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _desktopFieldLabel(l10n.date, fontFamily, c),
                          const SizedBox(height: 8),
                          _DesktopDateField(
                            date: _date,
                            onTap: _selectDate,
                            fontFamily: fontFamily,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (_isOtherCategory) ...[
                  const SizedBox(height: 12),
                  _DesktopTextField(
                    controller: _customCategoryController,
                    hint: l10n.whatWasThisFor,
                    fontFamily: fontFamily,
                  ),
                ],
                const SizedBox(height: 18),

                // Notes
                _desktopFieldLabel(l10n.notes, fontFamily, c),
                const SizedBox(height: 8),
                _DesktopTextField(
                  controller: _noteController,
                  hint: l10n.addNoteOptional,
                  fontFamily: fontFamily,
                  maxLines: 3,
                ),
                const SizedBox(height: 18),

                // Attachments
                _desktopFieldLabel(l10n.attachments, fontFamily, c),
                const SizedBox(height: 8),
                _buildAttachmentsSection(l10n, desktop: true),
              ],
            ),
          ),
        ),

        // ── Footer ────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
          decoration: BoxDecoration(
            color: c.cardBgSecondary,
            border: Border(top: BorderSide(color: c.borderLight)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  l10n.cancel,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeightManager.medium,
                    color: c.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _isUploading ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isUploading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        _isEditing ? l10n.saveChanges : l10n.saveExpense,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _desktopFieldLabel(String label, String fontFamily, AppColors c) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeightManager.semiBold,
        color: c.textSecondary,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _desktopLoadingField(AppColors c) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: c.inputBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: c.textSubtle,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP WIDGETS
// ═══════════════════════════════════════════════════════════════════════

class _DesktopAmountField extends StatelessWidget {
  const _DesktopAmountField({
    required this.controller,
    required this.currencyCode,
    required this.fontFamily,
  });

  final TextEditingController controller;
  final String? currencyCode;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      decoration: BoxDecoration(
        color: c.inputBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.borderLight),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 22,
                fontWeight: FontWeightManager.bold,
                color: c.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 22,
                  fontWeight: FontWeightManager.bold,
                  color: c.border,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
              ),
            ),
          ),
          if (currencyCode != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                currencyCode!,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DesktopCurrencyChips extends StatelessWidget {
  const _DesktopCurrencyChips({
    required this.currencies,
    required this.selected,
    required this.onSelected,
    required this.fontFamily,
  });

  final List<CurrencyEntity> currencies;
  final CurrencyEntity? selected;
  final ValueChanged<CurrencyEntity> onSelected;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: currencies.map((cur) {
        final isSel = selected?.id == cur.id;
        return Material(
          color: isSel
              ? ColorManager.primary.withValues(alpha: 0.12)
              : c.inputBg,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: () => onSelected(cur),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      isSel ? ColorManager.primary : c.borderLight,
                ),
              ),
              child: Text(
                cur.currencyCode,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  fontWeight: isSel
                      ? FontWeightManager.semiBold
                      : FontWeightManager.medium,
                  color: isSel
                      ? ColorManager.primary
                      : c.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _DesktopDateField extends StatelessWidget {
  const _DesktopDateField({
    required this.date,
    required this.onTap,
    required this.fontFamily,
  });

  final DateTime date;
  final VoidCallback onTap;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final isToday = DateUtils.isSameDay(date, DateTime.now());
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final formatted = DateFormat.yMMMd(locale).format(date);

    return Material(
      color: c.inputBg,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.borderLight),
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: c.textSecondary,
              ),
              const SizedBox(width: 10),
              Text(
                isToday ? l10n.today : formatted,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeightManager.medium,
                  color: c.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopTextField extends StatelessWidget {
  const _DesktopTextField({
    required this.controller,
    required this.hint,
    required this.fontFamily,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final String fontFamily;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        color: c.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          color: c.textSubtle,
        ),
        filled: true,
        fillColor: c.inputBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: c.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: c.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: ColorManager.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
    );
  }
}
