class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int lastPage;

  /// Rows across every page, as the server counts them. Null when the
  /// response carried no count.
  final int? total;

  const PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    this.total,
  });

  bool get hasMore => currentPage < lastPage;
}
