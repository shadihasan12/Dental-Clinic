/// Endpoints for the Home screen's headline figures.
class HomeSummaryEndpoints {
  HomeSummaryEndpoints._();

  /// GET /clinics/home-summary — every number the Home carousel shows, in one
  /// response. Deliberately its own route rather than a statistics query: Home
  /// is opened constantly and the catalog route costs two round trips before
  /// it knows what it is allowed to ask for.
  static const String summary = '/clinics/home-summary';
}
