class PaginatedResult<T> {
  final List<T> data;
  final int lastPage;
  final int total;

  PaginatedResult({
    required this.data,
    required this.lastPage,
    this.total = 0,
  });
}
