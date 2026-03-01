import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/home/data/models/notification_model.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getAllNotifications();
  Future<NotificationModel> markAsRead(String id);
  Future<List<NotificationModel>> markAllAsRead();
}

@Injectable(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  // ignore: unused_field
  final ApiConsumer _apiConsumer;

  NotificationRemoteDataSourceImpl(this._apiConsumer);

  // In-memory mock store so markAsRead persists within session
  List<NotificationModel>? _cachedNotifications;

  List<NotificationModel> _getMockNotifications() {
    if (_cachedNotifications != null) return _cachedNotifications!;

    final now = DateTime.now();
    _cachedNotifications = [
      NotificationModel(
        id: '1',
        title: 'Appointment Reminder',
        content:
            'You have an upcoming appointment with Ahmad Ali at 10:00 AM tomorrow.',
        type: 'appointment',
        timestamp: now.subtract(const Duration(minutes: 5)).toIso8601String(),
      ),
      NotificationModel(
        id: '2',
        title: 'New Patient Registered',
        content: 'Sara Mohammed has been added to your patients list.',
        type: 'patient',
        timestamp: now.subtract(const Duration(minutes: 30)).toIso8601String(),
      ),
      NotificationModel(
        id: '3',
        title: 'Payment Received',
        content:
            'Payment of 500 SAR received from Khaled Ibrahim for dental filling.',
        type: 'payment',
        timestamp: now.subtract(const Duration(hours: 2)).toIso8601String(),
      ),
      NotificationModel(
        id: '4',
        title: 'Appointment Cancelled',
        content:
            'Fatima Hassan cancelled the appointment scheduled for Thursday.',
        type: 'cancellation',
        timestamp: now.subtract(const Duration(hours: 5)).toIso8601String(),
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        title: 'Weekly Report Ready',
        content:
            'Your clinic performance report for this week is now available.',
        type: 'report',
        timestamp: now.subtract(const Duration(days: 1)).toIso8601String(),
        isRead: true,
      ),
      NotificationModel(
        id: '6',
        title: 'Treatment Completed',
        content:
            'Case #1042 for Omar Youssef has been marked as completed.',
        type: 'treatment',
        timestamp: now.subtract(const Duration(days: 2)).toIso8601String(),
        isRead: true,
      ),
    ];
    return _cachedNotifications!;
  }

  @override
  Future<List<NotificationModel>> getAllNotifications() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.get(NotificationEndpoints.notifications);
    // return (response as List)
    //     .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
    //     .toList();

    await Future.delayed(const Duration(milliseconds: 800));
    return _getMockNotifications();
  }

  @override
  Future<NotificationModel> markAsRead(String id) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.put(NotificationEndpoints.markAsRead(id));
    // return NotificationModel.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 300));
    final notifications = _getMockNotifications();
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _cachedNotifications![index] =
          notifications[index].copyWith(isRead: true);
    }
    return _cachedNotifications![index];
  }

  @override
  Future<List<NotificationModel>> markAllAsRead() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.put(NotificationEndpoints.markAllAsRead);
    // return (response as List)
    //     .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
    //     .toList();

    await Future.delayed(const Duration(milliseconds: 500));
    _cachedNotifications =
        _getMockNotifications().map((n) => n.copyWith(isRead: true)).toList();
    return _cachedNotifications!;
  }
}
