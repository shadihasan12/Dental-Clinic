class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int lastPage;

  const PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
  });

  bool get hasMore => currentPage < lastPage;
}
