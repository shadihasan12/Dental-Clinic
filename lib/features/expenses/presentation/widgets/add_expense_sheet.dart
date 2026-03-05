import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
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

  void _save() {
    // Required: amount, category, and currency
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
    DateTime tempDate = _date;
    final l10n = AppLocalizations.of(context)!;

    final picked = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.white,
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
                        color: Colors.grey,
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
            Divider(height: 1, color: Colors.grey.shade200),
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
    final l10n = AppLocalizations.of(context)!;
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
            // Handle
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
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
                color: const Color(0xFF2D2D2D),
              ),
            ),
            SizedBox(height: 20.h),

            // Amount
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              autofocus: !_isEditing,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D2D2D),
              ),
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade300,
                ),
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 16.h),

            // Category dropdown
            _categoriesLoading
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          l10n.filter,
                          style: TextStyle(
                            fontFamily: FontHelper.fontFamily(context),
                            fontSize: 13.sp,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildCategoryDropdown(context, l10n),

            // Custom category text field (shown when "Other" is selected)
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
                    color: Colors.grey.shade400,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
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

            // Notes
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
                  color: Colors.grey.shade400,
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
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

            // Currency chips from root CurrencyBloc
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

            // Date selector
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14.w,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      isToday ? l10n.today : formatted,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 14.h),

            // Attachments section
            _buildAttachmentsSection(l10n),

            SizedBox(height: 20.h),

            // Save button
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

  Widget _buildCategoryDropdown(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ExpenseCategoryEntity>(
          value: _selectedCategory,
          isExpanded: true,
          hint: Text(
            l10n.expenseType,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 13.sp,
              color: Colors.grey.shade400,
            ),
          ),
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 13.sp,
            color: Colors.black87,
          ),
          icon: Icon(
            Icons.expand_more,
            size: 18.w,
            color: Colors.grey.shade400,
          ),
          items: _categories
              .map(
                (c) => DropdownMenuItem(
                  value: c,
                  child: Text(
                    c.name,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 13.sp,
                      color: Colors.black87,
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

  Widget _buildAttachmentsSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                      borderRadius: BorderRadius.circular(8.r),
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
                              color: Colors.grey.shade100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.insert_drive_file_outlined,
                                    size: 24.w,
                                    color: Colors.grey.shade500,
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
                                        color: Colors.grey.shade600,
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Colors.grey.shade200,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.attach_file,
                  size: 16.w,
                  color: Colors.grey.shade500,
                ),
                SizedBox(width: 6.w),
                Text(
                  l10n.attachments,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
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
