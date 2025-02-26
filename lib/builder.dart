import 'package:build/build.dart';
import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/generator.dart';
import 'package:source_gen/source_gen.dart';

/// 生成器
Builder frendaGenerator(BuilderOptions options) {
  final config = FrendaConfig.fromJson(options.config);
  return PartBuilder([FrendaGenerator(config)], '.g.dart');
}
