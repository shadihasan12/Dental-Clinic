import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/auth/data/endpoints/auth_endpoints.dart';
import 'package:dental_clinic_app/features/auth/data/models/plan_model.dart';

/// Every MAIN plan in the catalogue, across all pages, ordered by
/// `sort_order`.
///
/// Shared by signup and the plan picker - the same public call either way.
/// `GET /plans` is the one paginated list in the billing surface
/// (`meta.pagination.last_page`, 15 a page by default). Three plans fit on a
/// page today, but that is not something to depend on.
Future<List<PlanModel>> fetchMainPlans(ApiConsumer api) async {
  final plans = <PlanModel>[];
  var page = 1;
  // A hard stop in case a server ever reports a nonsense last_page.
  const maxPages = 20;

  while (page <= maxPages) {
    final response = await api.get(
      AuthEndpoints.plans,
      queryParameters: {...AuthEndpoints.mainPlansQuery, 'page': page},
    );
    final data = response['data'] as List? ?? const [];
    plans.addAll(
      data.whereType<Map<String, dynamic>>().map(PlanModel.fromJson),
    );

    final meta = response['meta'];
    final pagination = meta is Map ? meta['pagination'] : null;
    final lastPage =
        pagination is Map ? (pagination['last_page'] as num?)?.toInt() : null;
    if (lastPage == null || page >= lastPage || data.isEmpty) break;
    page++;
  }

  // The filter is also applied here: a server that ignores it must not put
  // an add-on in front of a signup.
  return plans.where((p) => p.type.toUpperCase() == 'MAIN').toList()
    ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
}
