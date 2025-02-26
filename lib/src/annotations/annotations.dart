///
class Frenda {
  ///
  const Frenda();
}

///
class Filed {
  /// 用于 JSON 序列化的键名
  final String? json;

  ///
  const Filed(this.json);
}

/// 提供常用的装饰器实例
const frenda = Frenda();

///
const filed = Filed(null);
