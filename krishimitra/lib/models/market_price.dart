class MarketPrice {
  final String district;
  final String market;
  final String variety;
  final String commodity;
  final String maxPrice;
  final String avgPrice;
  final String minPrice;

  MarketPrice({
    required this.district,
    required this.market,
    required this.variety,
    required this.commodity,
    required this.maxPrice,
    required this.avgPrice,
    required this.minPrice,
  });

  factory MarketPrice.fromJson(Map<String, dynamic> json) {
    String cleanPrice(String rawPrice) {
      final cleaned = rawPrice.replaceAll(RegExp(r'[^\d.,₹]'), '').trim();
      print("Original Price: $rawPrice, Cleaned Price: $cleaned");
      return cleaned;
    }
    return MarketPrice(
      district: json['District'] ?? '',
      market: json['Market'] ?? '',
      variety: json['Variety'] ?? '',
      commodity: json['Commodity/crop'] ?? '',
      maxPrice: cleanPrice(json['Maximum Price'] ?? ''),
      avgPrice: cleanPrice(json['Average Price'] ?? ''),
      minPrice: cleanPrice(json['Minimum Price'] ?? ''),
    );
  }
}

