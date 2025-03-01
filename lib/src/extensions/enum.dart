/// 枚举扩展
extension EnumListX<T extends Enum> on List<T> {
  /// 转换为可空枚举值
  T? of(dynamic value) {
    if (value == null) return null;

    if (value is String) {
      try {
        return firstWhere((e) => e.name.toLowerCase() == value.toLowerCase());
      } catch (_) {
        return null;
      }
    }

    if (value is int && value >= 0 && value < length) {
      return this[value];
    }

    return null;
  }

  /// 转换为非空枚举值，转换失败返回第一个枚举值
  T to(dynamic value, {T? defaultValue}) {
    return of(value) ?? defaultValue ?? first;
  }
}
