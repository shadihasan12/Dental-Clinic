import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/data/endpoints/issue_endpoints.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/data/models/issue_model.dart';
import 'package:injectable/injectable.dart';

abstract class IssueRemoteDataSource {
  /// The caller's own reports, in the order the server returns them
  /// (expected newest first).
  Future<List<IssueModel>> getIssues();

  /// Creates a report. The server assigns the id and the status.
  Future<IssueModel> createIssue({
    required String title,
    required String description,
  });
}

@Injectable(as: IssueRemoteDataSource)
class IssueRemoteDataSourceImpl implements IssueRemoteDataSource {
  final ApiConsumer _apiConsumer;

  IssueRemoteDataSourceImpl(this._apiConsumer);

  /// The endpoints are blank until the backend lands. Firing a request at
  /// an empty path would resolve to the API root and come back as a
  /// confusing 404 or, worse, a 200 for something unrelated — so fail here
  /// with a message that says what is actually wrong.
  void _assertConfigured() {
    if (!IssueEndpoints.isConfigured) {
      throw StateError(
        'Issue endpoints are not configured yet — set IssueEndpoints.issues '
        'and IssueEndpoints.createIssue once the backend is available.',
      );
    }
  }

  @override
  Future<List<IssueModel>> getIssues() async {
    _assertConfigured();
    final response = await _apiConsumer.get(IssueEndpoints.issues);

    final data = response is Map ? response['data'] : null;
    if (data is! List) return const [];

    return data
        .whereType<Map>()
        .map((e) => IssueModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<IssueModel> createIssue({
    required String title,
    required String description,
  }) async {
    _assertConfigured();
    final response = await _apiConsumer.post(
      IssueEndpoints.createIssue,
      body: {'title': title, 'description': description},
    );

    final data = response is Map ? response['data'] : null;
    if (data is! Map) {
      throw const FormatException('Create issue returned no record');
    }
    return IssueModel.fromJson(Map<String, dynamic>.from(data));
  }
}
