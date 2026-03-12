import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// A bottom sheet for managing notes on a treatment plan item.
///
/// Supports add, edit, and delete operations on a list of [VisitNote]s.
/// On "Save", returns the updated list via [onSave].
class ManageNotesSheet extends StatefulWidget {
  final String treatmentName;
  final List<VisitNote> initialNotes;

  /// Called with the updated notes list when Save is pressed.
  final ValueChanged<List<VisitNote>> onSave;

  const ManageNotesSheet({
    super.key,
    required this.treatmentName,
    required this.initialNotes,
    required this.onSave,
  });

  /// Show as a modal bottom sheet.
  static void show(
    BuildContext context, {
    required String treatmentName,
    required List<VisitNote> initialNotes,
    required ValueChanged<List<VisitNote>> onSave,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ManageNotesSheet(
        treatmentName: treatmentName,
        initialNotes: initialNotes,
        onSave: onSave,
      ),
    );
  }

  @override
  State<ManageNotesSheet> createState() => _ManageNotesSheetState();
}

class _ManageNotesSheetState extends State<ManageNotesSheet> {
  late List<VisitNote> _notes;
  final _controller = TextEditingController();
  int? _editingIndex; // null = adding new, non-null = editing existing

  @override
  void initState() {
    super.initState();
    _notes = List.from(widget.initialNotes);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addOrUpdateNote() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      if (_editingIndex != null) {
        // Update existing note text, keep the same date
        _notes[_editingIndex!] = VisitNote(
          date: _notes[_editingIndex!].date,
          text: text,
        );
        _editingIndex = null;
      } else {
        // Add new note with today's date
        _notes.add(VisitNote(date: DateTime.now(), text: text));
      }
      _controller.clear();
    });
  }

  void _startEditing(int index) {
    setState(() {
      _editingIndex = index;
      _controller.text = _notes[index].text;
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingIndex = null;
      _controller.clear();
    });
  }

  void _deleteNote(int index) {
    setState(() {
      // If editing the note being deleted, cancel edit
      if (_editingIndex == index) {
        _editingIndex = null;
        _controller.clear();
      } else if (_editingIndex != null && _editingIndex! > index) {
        _editingIndex = _editingIndex! - 1;
      }
      _notes.removeAt(index);
    });
  }

  void _save() {
    // If user was typing something, add it before saving
    if (_controller.text.trim().isNotEmpty) {
      _addOrUpdateNote();
    }
    widget.onSave(_notes);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Scrollable content ─────────────────────────────
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: ColorManager.gray300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Title
                  Text(
                    AppLocalizations.of(context)!.notes,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.treatmentName,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: ColorManager.textTertiary,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Notes list
                  if (_notes.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _notes.length,
                      separatorBuilder: (_, _) => SizedBox(height: 8.h),
                      itemBuilder: (_, i) => _buildNoteItem(i),
                    ),

                  if (_notes.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.noNotesYet,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: ColorManager.textTertiary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ── Sticky bottom: input + save ─────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              20.w,
              8.h,
              20.w,
              (bottomInset > 0 ? bottomInset : bottomPadding) + 16.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Input field + add button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        maxLines: 3,
                        minLines: 1,
                        autofocus: false,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          color: ColorManager.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: _editingIndex != null
                              ? AppLocalizations.of(context)!.editNote
                              : AppLocalizations.of(context)!.writeANote,
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: ColorManager.textTertiary,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 12.h),
                          filled: true,
                          fillColor: ColorManager.gray50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: ColorManager.borderLight),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide:
                                BorderSide(color: ColorManager.borderLight),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(
                              color: _editingIndex != null
                                  ? ColorManager.warning
                                  : ColorManager.primary,
                            ),
                          ),
                          suffixIcon: _editingIndex != null
                              ? IconButton(
                                  icon: Icon(Icons.close,
                                      size: 18.w,
                                      color: ColorManager.textTertiary),
                                  onPressed: _cancelEditing,
                                )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: _addOrUpdateNote,
                      child: Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          color: _editingIndex != null
                              ? ColorManager.warning
                              : ColorManager.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          _editingIndex != null
                              ? Icons.check_rounded
                              : Icons.add_rounded,
                          size: 20.w,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Save button
                GestureDetector(
                  onTap: _save,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
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

  Widget _buildNoteItem(int index) {
    final note = _notes[index];
    final isEditing = _editingIndex == index;
    final dateStr = DateFormat('yyyy-MM-dd').format(note.date);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isEditing
            ? ColorManager.warning.withValues(alpha: 0.06)
            : ColorManager.gray50,
        borderRadius: BorderRadius.circular(10.r),
        border: isEditing
            ? Border.all(color: ColorManager.warning.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Note content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateStr,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primary,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  note.text,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Edit / Delete actions
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => _startEditing(index),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Icon(
                Icons.edit_outlined,
                size: 16.w,
                color: ColorManager.textTertiary,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: () => _deleteNote(index),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Icon(
                Icons.delete_outline,
                size: 16.w,
                color: ColorManager.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
