import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// ──────────────────────────────────────────────
// Models
// ──────────────────────────────────────────────

class SupportMessage {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isFromUser;

  SupportMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isFromUser,
  });
}

class SupportConversation {
  final String id;
  String subject;
  final List<SupportMessage> messages;
  bool isRead;

  SupportConversation({
    required this.id,
    required this.subject,
    required this.messages,
    this.isRead = true,
  });

  DateTime? get lastMessageTime =>
      messages.isNotEmpty ? messages.last.timestamp : null;

  String? get lastMessagePreview =>
      messages.isNotEmpty ? messages.last.text : null;
}

// ──────────────────────────────────────────────
// Page
// ──────────────────────────────────────────────

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({super.key});

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  late final List<SupportConversation> _conversations;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _conversations = [
      SupportConversation(
        id: '1',
        subject: 'Cannot access my account',
        isRead: true,
        messages: [
          SupportMessage(
            id: 'm1',
            text:
                'Hello, I am unable to log in to my account. I keep getting an invalid credentials error.',
            timestamp: now.subtract(const Duration(days: 2, hours: 3)),
            isFromUser: true,
          ),
          SupportMessage(
            id: 'm2',
            text:
                'Hi! Thank you for reaching out. Could you please try resetting your password using the "Forgot Password" link on the login screen?',
            timestamp: now.subtract(const Duration(days: 2, hours: 2)),
            isFromUser: false,
          ),
          SupportMessage(
            id: 'm3',
            text: 'That worked! Thank you so much.',
            timestamp: now.subtract(const Duration(days: 2, hours: 1)),
            isFromUser: true,
          ),
          SupportMessage(
            id: 'm4',
            text: 'Great to hear! Let us know if you need anything else.',
            timestamp: now.subtract(const Duration(days: 2)),
            isFromUser: false,
          ),
        ],
      ),
      SupportConversation(
        id: '2',
        subject: 'Billing question about subscription',
        isRead: false,
        messages: [
          SupportMessage(
            id: 'm5',
            text:
                'Hi, I was charged twice this month for my subscription. Can you please look into this?',
            timestamp: now.subtract(const Duration(hours: 5)),
            isFromUser: true,
          ),
          SupportMessage(
            id: 'm6',
            text:
                'We are sorry to hear that. We are looking into this and will get back to you within 24 hours.',
            timestamp: now.subtract(const Duration(hours: 4)),
            isFromUser: false,
          ),
        ],
      ),
    ];
  }

  void _openNewConversation() {
    final newConvo = SupportConversation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      subject: 'New Conversation',
      messages: [],
      isRead: true,
    );
    _conversations.insert(0, newConvo);
    context
        .pushNamed(AppRoutesNames.supportChat, extra: newConvo)
        .then((_) => setState(() {}));
  }

  void _openConversation(SupportConversation convo) {
    setState(() => convo.isRead = true);
    context
        .pushNamed(AppRoutesNames.supportChat, extra: convo)
        .then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          PageHeader(title: l10n.contactSupport),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                _buildResponseTimeBanner(l10n),
                SizedBox(height: 16.h),
                _buildNewConversationCard(l10n),
                SizedBox(height: 24.h),
                _buildConversationsList(l10n),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponseTimeBanner(AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadiusManager.lg,
        border: Border.all(color: ColorManager.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.schedule_rounded,
              size: 18.w,
              color: ColorManager.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              l10n.supportResponseTime,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewConversationCard(AppLocalizations l10n) {
    return CustomCard(
      onTap: _openNewConversation,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadiusManager.lg,
            ),
            child: Icon(
              Icons.headset_mic_rounded,
              color: ColorManager.white,
              size: 24.w,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.newConversation,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  l10n.startConversationDesc,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.textTertiary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.w,
            color: ColorManager.textTertiary,
          ),
        ],
      ),
    );
  }

  Widget _buildConversationsList(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.previousConversations,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w600,
            color: ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 10.h),
        if (_conversations.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Text(
                l10n.noConversations,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textTertiary,
                ),
              ),
            ),
          )
        else
          CustomCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: _conversations.asMap().entries.map((entry) {
                final index = entry.key;
                final convo = entry.value;
                final isLast = index == _conversations.length - 1;
                return _buildConversationTile(convo, isLast: isLast);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildConversationTile(
    SupportConversation convo, {
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () => _openConversation(convo),
      borderRadius: isLast
          ? BorderRadiusManager.xl
          : BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: isLast
            ? null
            : BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: ColorManager.borderLight, width: 1),
                ),
              ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Support avatar
            Stack(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary10,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.support_agent_rounded,
                    size: 22.w,
                    color: ColorManager.primary,
                  ),
                ),
                if (!convo.isRead)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorManager.white,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12.w),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          convo.subject,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: convo.isRead
                                ? FontWeight.w500
                                : FontWeight.w700,
                            color: ColorManager.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (convo.lastMessageTime != null) ...[
                        SizedBox(width: 8.w),
                        Text(
                          _formatConvoTime(convo.lastMessageTime!),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: convo.isRead
                                ? ColorManager.textTertiary
                                : ColorManager.primary,
                            fontWeight: convo.isRead
                                ? FontWeight.w400
                                : FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (convo.lastMessagePreview != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      convo.lastMessagePreview!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: ColorManager.textTertiary,
                        fontWeight: convo.isRead
                            ? FontWeight.w400
                            : FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.chevron_right_rounded,
              size: 18.w,
              color: ColorManager.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  String _formatConvoTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inDays == 0) {
      final hour = time.hour > 12
          ? time.hour - 12
          : (time.hour == 0 ? 12 : time.hour);
      final min = time.minute.toString().padLeft(2, '0');
      final period = time.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$min $period';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[time.weekday - 1];
    } else {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[time.month - 1]} ${time.day}';
    }
  }
}
