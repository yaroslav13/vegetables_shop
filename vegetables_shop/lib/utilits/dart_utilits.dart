T enumDecodeNullable<T>(
    Map<T, dynamic> enumValues,
    dynamic source, {
      T unknownValue,
    }) {
  if (source == null) {
    return null;
  }
  return enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

T enumDecode<T>(
    Map<T, dynamic> enumValues,
    dynamic source, {
      T unknownValue,
    }) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}
