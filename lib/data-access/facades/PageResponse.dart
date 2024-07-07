class PageResponse<T> {
  final int totalElements;
  final int totalPages;
  final int size;
  final int pageNumber;
  final List<T> content;

  PageResponse({
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.pageNumber,
    required this.content,
  });

  factory PageResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    final pageable = json['pageable'];
    return PageResponse(
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      size: pageable['pageSize'],
      pageNumber: pageable['pageNumber'],
      content: (json['content'] as List)
          .map((item) => fromJsonT(item))
          .toList(),
    );
  }
}
