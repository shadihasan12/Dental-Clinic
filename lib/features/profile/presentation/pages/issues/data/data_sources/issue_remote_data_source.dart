import 'dart:io' show Platform;

import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/data/endpoints/issue_endpoints.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/data/models/issue_model.dart';
import 'package:injectable/injectable.dart';

abstract class IssueRemoteDataSource {
  Future<IssuePageModel> getIssues({int page, int size});

  Future<IssueModel> createIssue({
    required String category,
    required String title,
    required String description,
    List<String> mediaItemIds,
  });

  Future<List<IssueOptionModel>> getCategories();

  Future<List<IssueOptionModel>> getStatuses();
}

@Injectable(as: IssueRemoteDataSource)
class IssueRemoteDataSourceImpl implements IssueRemoteDataSource {
  final ApiConsumer _apiConsumer;

  IssueRemoteDataSourceImpl(this._apiConsumer);

  /// Which build filed the report. Support needs this to tell an Android bug
  /// from a Windows one, and the user is never asked — there is no picker,
  /// and an answer they typed would be worth less than what the build knows.
  ///
  /// These are not the push-notification platform constants: that endpoint
  /// has no `WINDOWS` at all, and reusing its list here would fail every
  /// desktop report.
  static String get _platform {
    if (Platform.isAndroid) return 'ANDROID';
    if (Platform.isIOS) return 'IOS';
    if (Platform.isWindows) return 'WINDOWS';
    throw UnsupportedError(
      'Reporting an issue is not supported on this platform',
    );
  }

  @override
  Future<IssuePageModel> getIssues({int page = 1, int size = 15}) async {
    // No clinic filter, on purpose: a report belongs to the person who filed
    // it, not to a workplace, so switching clinic must not look like the
    // user's reports were deleted.
    final response = await _apiConsumer.get(
      IssueEndpoints.tickets,
      // The server caps size at 100 silently; asking for more is pointless.
      queryParameters: {'page': page, 'size': size.clamp(1, 100)},
    );

    final map = response is Map ? Map<String, dynamic>.from(response) : null;
    final data = map?['data'];
    final items = data is List
        ? data
              .whereType<Map>()
              .map((e) => IssueModel.fromJson(Map<String, dynamic>.from(e)))
              .toList()
        : <IssueModel>[];

    final pagination = map?['meta'] is Map
        ? (Map<String, dynamic>.from(map!['meta'] as Map))['pagination']
        : null;

    return IssuePageModel(
      items: items,
      pagination: pagination is Map
          ? IssuePaginationModel.fromJson(Map<String, dynamic>.from(pagination))
          // A response without meta is still a usable single page.
          : IssuePaginationModel(
              page: page,
              size: size,
              count: items.length,
              total: items.length,
              lastPage: page,
            ),
    );
  }

  @override
  Future<IssueModel> createIssue({
    required String category,
    required String title,
    required String description,
    List<String> mediaItemIds = const [],
  }) async {
    // `status`, `user_id`, `clinic_id` and `roles` are all server-owned and
    // deliberately absent: the clinic comes from the header the interceptor
    // attaches, never from the body.
    final response = await _apiConsumer.post(
      IssueEndpoints.tickets,
      body: {
        'category': category,
        'title': title,
        'description': description,
        'platform': _platform,
        if (mediaItemIds.isNotEmpty) 'media_item_ids': mediaItemIds,
      },
    );

    final data = response is Map ? response['data'] : null;
    if (data is! Map) {
      throw const FormatException('Create issue returned no record');
    }
    return IssueModel.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<List<IssueOptionModel>> getCategories() =>
      _options(IssueEndpoints.categories);

  @override
  Future<List<IssueOptionModel>> getStatuses() =>
      _options(IssueEndpoints.statuses);

  Future<List<IssueOptionModel>> _options(String path) async {
    final response = await _apiConsumer.get(path);

    final data = response is Map ? response['data'] : null;
    if (data is! List) return const [];

    return data
        .whereType<Map>()
        .map((e) => IssueOptionModel.fromJson(Map<String, dynamic>.from(e)))
        .where((o) => o.value.isNotEmpty)
        .toList();
  }
}
