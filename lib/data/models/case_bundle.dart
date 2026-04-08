class CaseBundle {
  final int id;
  final String name;
  final String? description;
  final String? coverImage;
  final List<String> caseIds;
  final int originalPrice;
  final int bundlePrice;
  final int discountPercent;
  final bool isActive;
  final String? startsAt;
  final String? expiresAt;

  CaseBundle({
    required this.id,
    required this.name,
    this.description,
    this.coverImage,
    required this.caseIds,
    required this.originalPrice,
    required this.bundlePrice,
    required this.discountPercent,
    required this.isActive,
    this.startsAt,
    this.expiresAt,
  });

  factory CaseBundle.fromJson(Map<String, dynamic> json) {
    final rawCaseIds = json['caseIds'] ?? json['case_ids'];
    List<String> parsedCaseIds = [];
    if (rawCaseIds is List) {
      parsedCaseIds = rawCaseIds.map((e) => e.toString()).toList();
    } else if (rawCaseIds is String) {
      // JSON string olarak geliyorsa
      try {
        final decoded = Uri.decodeFull(rawCaseIds);
        // Simple parse for ["a","b"] format
        parsedCaseIds = decoded
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll('"', '')
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      } catch (_) {}
    }

    return CaseBundle(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      coverImage: json['coverImage'] ?? json['cover_image'],
      caseIds: parsedCaseIds,
      originalPrice: json['originalPrice'] ?? json['original_price'] ?? 0,
      bundlePrice: json['bundlePrice'] ?? json['bundle_price'] ?? 0,
      discountPercent: json['discountPercent'] ?? json['discount_percent'] ?? 0,
      isActive: json['isActive'] ?? json['is_active'] ?? true,
      startsAt: json['startsAt'] ?? json['starts_at'],
      expiresAt: json['expiresAt'] ?? json['expires_at'],
    );
  }
}
