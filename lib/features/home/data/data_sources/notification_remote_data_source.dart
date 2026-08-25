import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/home/data/endpoints/notification_endpoints.dart';
import 'package:dental_clinic_app/features/home/data/models/notification_model.dart';
import 'package:injectable/injectable.dart';

/// One page of the inbox, straight off the wire.
class NotificationPageResponse {
  final List<NotificationModel> notifications;
  final String? nextCursor;
  final int unreadCount;

  const NotificationPageResponse({
    required this.notifications,
    required this.nextCursor,
    required this.unreadCount,
  });
}

/// The `/unseen` payload — Windows polling only.
class UnseenNotificationsResponse {
  final List<NotificationModel> notifications;
  final int remaining;
  final int unreadCount;
  final int pollAfter;

  const UnseenNotificationsResponse({
    required this.notifications,
    required this.remaining,
    required this.unreadCount,
    required this.pollAfter,
  });
}

abstract class NotificationRemoteDataSource {
  Future<NotificationPageResponse> getNotifications({
    int limit,
    String? before,
  });
  Future<UnseenNotificationsResponse> getUnseen();
  Future<int> markSeen(List<String> ids);
  Future<int> markAsRead(String id);
  Future<int> markAsUnread(String id);
  Future<int> markAllAsRead();
  Future<int> getUnreadCount();
}

@Injectable(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiConsumer _apiConsumer;

  NotificationRemoteDataSourceImpl(this._apiConsumer);

  /// The server caps `limit` at 100.
  static const int defaultLimit = 30;

  /// `POST /notifications/seen` accepts 1–200 ids per call.
  static const int maxSeenIdsPerRequest = 200;

  @override
  Future<NotificationPageResponse> getNotifications({
    int limit = defaultLimit,
    String? before,
  }) async {
    final response = await _apiConsumer.get(
      NotificationEndpoints.notifications,
      queryParameters: {
        'limit': limit,
        if (before != null) 'before': before,
      },
    );

    final meta = _meta(response);
    return NotificationPageResponse(
      notifications: _parseList(response['data']),
      // null means "no more pages" — not an error.
      nextCursor: meta['next_cursor'] as String?,
      unreadCount: _asInt(meta['unread_count']),
    );
  }

  @override
  Future<UnseenNotificationsResponse> getUnseen() async {
    final response = await _apiConsumer.get(NotificationEndpoints.unseen);

    final meta = _meta(response);
    return UnseenNotificationsResponse(
      notifications: _parseList(response['data']),
      remaining: _asInt(meta['remaining']),
      unreadCount: _asInt(meta['unread_count']),
      // Obey the server's interval so it can be raised under load without
      // shipping a new build. 30 only covers a malformed response.
      pollAfter: _asInt(meta['poll_after'], fallback: 30),
    );
  }

  @override
  Future<int> markSeen(List<String> ids) async {
    if (ids.isEmpty) return 0;

    var marked = 0;
    // The endpoint rejects more than 200 ids at once; chunk rather than drop.
    for (var i = 0; i < ids.length; i += maxSeenIdsPerRequest) {
      final chunk = ids.sublist(
        i,
        (i + maxSeenIdsPerRequest).clamp(0, ids.length),
      );
      final response = await _apiConsumer.post(
        NotificationEndpoints.seen,
        body: {'ids': chunk},
      );
      marked += _asInt(_data(response)['marked']);
    }
    return marked;
  }

  @override
  Future<int> markAsRead(String id) async {
    final response =
        await _apiConsumer.post(NotificationEndpoints.markAsRead(id));
    return _asInt(_data(response)['unread_count']);
  }

  @override
  Future<int> markAsUnread(String id) async {
    final response =
        await _apiConsumer.post(NotificationEndpoints.markAsUnread(id));
    return _asInt(_data(response)['unread_count']);
  }

  @override
  Future<int> markAllAsRead() async {
    final response = await _apiConsumer.post(NotificationEndpoints.readAll);
    return _asInt(_data(response)['unread_count']);
  }

  @override
  Future<int> getUnreadCount() async {
    final response = await _apiConsumer.get(NotificationEndpoints.unreadCount);
    return _asInt(_data(response)['unread_count']);
  }

  // ── envelope helpers ──────────────────────────────────────────────────

  List<NotificationModel> _parseList(dynamic data) {
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((e) => NotificationModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// `meta` is `null` on several endpoints — never index it blind.
  Map<String, dynamic> _meta(dynamic response) {
    final meta = response is Map ? response['meta'] : null;
    return meta is Map ? Map<String, dynamic>.from(meta) : const {};
  }

  Map<String, dynamic> _data(dynamic response) {
    final data = response is Map ? response['data'] : null;
    return data is Map ? Map<String, dynamic>.from(data) : const {};
  }

  int _asInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }
}
