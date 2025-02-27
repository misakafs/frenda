///
class FrendaConfig {
  ///
  final String prefix;

  ///
  const FrendaConfig({required this.prefix});

  ///
  factory FrendaConfig.fromJson(Map<String, dynamic> json) {
    return FrendaConfig(prefix: json['prefix'] ?? '\$');
  }
}
