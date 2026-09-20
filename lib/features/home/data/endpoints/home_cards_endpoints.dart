/// Endpoints for the Home screen's statistics carousel.
class HomeCardsEndpoints {
  HomeCardsEndpoints._();

  /// GET /clinics/statistics/home-cards - every card the carousel shows, in
  /// one response, already worded and formatted for the requested language.
  ///
  /// Takes no parameters. The period is always the current calendar month and
  /// the scope comes from the caller's role in the clinic named by the
  /// `X-Selected-Clinic-id` header, which [AuthInterceptor] already sends.
  static const String homeCards = '/clinics/statistics/home-cards';
}
