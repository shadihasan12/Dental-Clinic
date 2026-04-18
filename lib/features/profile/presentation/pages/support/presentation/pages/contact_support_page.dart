import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/presentation/manager/support_conversations_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SupportConversationsBloc>()
        ..add(const SupportConversationsEvent.loadConversations()),
      child: const _ContactSupportContent(),
    );
  }
}

class _ContactSupportContent extends StatelessWidget {
  const _ContactSupportContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = Responsive.isDesktop(context);

    final body = BlocConsumer<SupportConversationsBloc,
        SupportConversationsState>(
      listenWhen: (prev, curr) => curr.maybeMap(
        created: (_) => true,
        error: (_) => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.maybeWhen(
          created: (newConvo, _) {
            context
                .pushNamed(
              AppRoutesNames.supportChat,
              extra: newConvo,
            )
                .then((_) {
              context.read<SupportConversationsBloc>().add(
                    const SupportConversationsEvent.loadConversations(),
                  );
            });
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          orElse: () {},
        );
      },
      buildWhen: (prev, curr) => curr.maybeMap(
        loading: (_) => true,
        loaded: (_) => true,
        created: (_) => true,
        error: (_) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (conversations) => _buildBody(
            context,
            l10n,
            conversations,
            isDesktop,
          ),
          created: (_, conversations) => _buildBody(
            context,
            l10n,
            conversations,
            isDesktop,
          ),
          error: (message) => Center(child: Text(message)),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );

    if (isDesktop) {
      return DesktopShell(
        title: l10n.contactSupport,
        body: Scaffold(
          backgroundColor: ColorManager.of(context).scaffoldBg,
          body: body,
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: Column(
        children: [
          PageHeader(title: l10n.contactSupport),
          Expanded(child: body),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    List<SupportConversationEntity> conversations,
    bool isDesktop,
  ) {
    if (isDesktop) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildResponseTimeBanner(context, l10n),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildNewConversationCard(context, l10n),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: _buildConversationsList(
                          context, l10n, conversations),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        _buildResponseTimeBanner(context, l10n),
        SizedBox(height: 16.h),
        _buildNewConversationCard(context, l10n),
        SizedBox(height: 24.h),
        _buildConversationsList(context, l10n, conversations),
        SizedBox(height: 16.h),
      ],
    );
  }

  void _openConversation(
      BuildContext context, SupportConversationEntity convo) {
    context
        .pushNamed(AppRoutesNames.supportChat, extra: convo)
        .then((_) {
      context.read<SupportConversationsBloc>().add(
            const SupportConversationsEvent.loadConversations(),
          );
    });
  }

  Widget _buildResponseTimeBanner(BuildContext context, AppLocalizations l10n) {
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

  Widget _buildNewConversationCard(
      BuildContext context, AppLocalizations l10n) {
    return CustomCard(
      onTap: () {
        context.read<SupportConversationsBloc>().add(
              const SupportConversationsEvent.createConversation(),
            );
      },
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
              color: Colors.white,
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
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  l10n.startConversationDesc,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.of(context).textTertiary,
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
            color: ColorManager.of(context).textTertiary,
          ),
        ],
      ),
    );
  }

  Widget _buildConversationsList(
    BuildContext context,
    AppLocalizations l10n,
    List<SupportConversationEntity> conversations,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.previousConversations,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w600,
            color: ColorManager.of(context).textPrimary,
          ),
        ),
        SizedBox(height: 10.h),
        if (conversations.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Text(
                l10n.noConversations,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.of(context).textTertiary,
                ),
              ),
            ),
          )
        else
          CustomCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: conversations.asMap().entries.map((entry) {
                final index = entry.key;
                final convo = entry.value;
                final isLast = index == conversations.length - 1;
                return _buildConversationTile(context, convo, isLast: isLast);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildConversationTile(
    BuildContext context,
    SupportConversationEntity convo, {
    bool isLast = false,
  }) {
    final lastMessage =
        convo.messages.isNotEmpty ? convo.messages.last : null;

    return InkWell(
      onTap: () => _openConversation(context, convo),
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
                  bottom:
                      BorderSide(color: ColorManager.of(context).borderLight, width: 1),
                ),
              ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          color: ColorManager.of(context).cardBg,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12.w),
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
                            color: ColorManager.of(context).textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (lastMessage != null) ...[
                        SizedBox(width: 8.w),
                        Text(
                          _formatConvoTime(lastMessage.timestamp),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: convo.isRead
                                ? ColorManager.of(context).textTertiary
                                : ColorManager.primary,
                            fontWeight: convo.isRead
                                ? FontWeight.w400
                                : FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (lastMessage != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      lastMessage.text,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: ColorManager.of(context).textTertiary,
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
              color: ColorManager.of(context).textTertiary,
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
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return '${months[time.month - 1]} ${time.day}';
    }
  }
}
