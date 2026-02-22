import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'contact_support_page.dart';

class SupportChatPage extends StatefulWidget {
  final SupportConversation conversation;
  final VoidCallback? onUpdated;

  const SupportChatPage({
    super.key,
    required this.conversation,
    this.onUpdated,
  });

  @override
  State<SupportChatPage> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSending = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final newMessage = SupportMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      timestamp: DateTime.now(),
      isFromUser: true,
    );

    // If this is the first message, use it as the subject
    if (widget.conversation.messages.isEmpty) {
      widget.conversation.subject =
          text.length > 40 ? '${text.substring(0, 40)}...' : text;
    }

    setState(() {
      widget.conversation.messages.add(newMessage);
      _isSending = true;
    });
    _messageController.clear();
    widget.onUpdated?.call();

    _scrollToBottom();

    // Simulate support auto-response after 1.5 s
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      final reply = SupportMessage(
        id: '${DateTime.now().millisecondsSinceEpoch}_reply',
        text:
            'Thank you for your message. Our support team has received your request and will respond shortly.',
        timestamp: DateTime.now(),
        isFromUser: false,
      );
      setState(() {
        widget.conversation.messages.add(reply);
        widget.conversation.isRead = true;
        _isSending = false;
      });
      widget.onUpdated?.call();
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final messages = widget.conversation.messages;

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          _buildHeader(l10n),
          Expanded(
            child: messages.isEmpty
                ? _buildEmptyState(l10n)
                : ListView.builder(
                    controller: _scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    itemCount: _groupedItems(messages).length,
                    itemBuilder: (context, index) {
                      final item = _groupedItems(messages)[index];
                      if (item is _DateSeparator) {
                        return _buildDateSeparator(item.label);
                      }
                      return _buildMessageBubble(item as SupportMessage);
                    },
                  ),
          ),
          if (_isSending) _buildTypingIndicator(l10n),
          _buildInputBar(l10n),
        ],
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: ColorManager.white,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: ColorManager.textPrimary,
                      size: 20.w,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // Support avatar
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: ColorManager.primary10,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.support_agent_rounded,
                      size: 18.w,
                      color: ColorManager.primary,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.supportTeam,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w600,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                        Text(
                          widget.conversation.subject,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: ColorManager.textTertiary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(height: 1, color: ColorManager.borderLight),
      ],
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 36.w,
              color: ColorManager.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.newConversation,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              l10n.startConversationDesc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.textTertiary,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadiusManager.full,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.schedule_rounded,
                  size: 12.w,
                  color: ColorManager.primary,
                ),
                SizedBox(width: 4.w),
                Text(
                  l10n.supportResponseTime,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.primaryDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: ColorManager.borderLight)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.textTertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: Divider(color: ColorManager.borderLight)),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(SupportMessage message) {
    final isUser = message.isFromUser;
    final time = _formatTime(message.timestamp);

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Support avatar (left side only)
            if (!isUser) ...[
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary10,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.support_agent_rounded,
                  size: 14.w,
                  color: ColorManager.primary,
                ),
              ),
              SizedBox(width: 6.w),
            ],
            // Bubble
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 0.72.sw),
              child: Column(
                crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? ColorManager.primary : ColorManager.white,
                      borderRadius: isUser
                          ? BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                              bottomLeft: Radius.circular(16.r),
                              bottomRight: Radius.circular(4.r),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(4.r),
                              topRight: Radius.circular(16.r),
                              bottomLeft: Radius.circular(16.r),
                              bottomRight: Radius.circular(16.r),
                            ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withValues(alpha: 0.06),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w400,
                        color: isUser
                            ? ColorManager.white
                            : ColorManager.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          color: ColorManager.textTertiary,
                        ),
                      ),
                      if (isUser) ...[
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.done_all_rounded,
                          size: 12.w,
                          color: ColorManager.primary,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (isUser) SizedBox(width: 4.w),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(AppLocalizations l10n) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, bottom: 4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: ColorManager.primary10,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.support_agent_rounded,
                size: 14.w,
                color: ColorManager.primary,
              ),
            ),
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  3,
                  (i) => _TypingDot(delay: Duration(milliseconds: i * 200)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        16.w,
        10.h,
        12.w,
        MediaQuery.of(context).padding.bottom + 10.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.gray50,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: ColorManager.borderLight),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: 5,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: l10n.typeAMessage,
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: ColorManager.textTertiary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: ColorManager.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.send_rounded,
                color: ColorManager.white,
                size: 20.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────

  String _formatTime(DateTime time) {
    final hour =
        time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final min = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$min $period';
  }

  // Inserts _DateSeparator objects between messages from different days
  List<dynamic> _groupedItems(List<SupportMessage> messages) {
    final List<dynamic> items = [];
    DateTime? lastDate;
    for (final msg in messages) {
      final msgDate = DateTime(msg.timestamp.year, msg.timestamp.month, msg.timestamp.day);
      if (lastDate == null || msgDate != lastDate) {
        items.add(_DateSeparator(_dateLabel(msgDate)));
        lastDate = msgDate;
      }
      items.add(msg);
    }
    return items;
  }

  String _dateLabel(DateTime date) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final diff = todayDate.difference(date).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _DateSeparator {
  final String label;
  const _DateSeparator(this.label);
}

// Animated typing dot
class _TypingDot extends StatefulWidget {
  final Duration delay;
  const _TypingDot({required this.delay});

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Container(
            width: 7.w,
            height: 7.w,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              color: ColorManager.textTertiary,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
