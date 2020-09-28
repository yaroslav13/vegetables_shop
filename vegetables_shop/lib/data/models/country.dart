class Country {
  final String name;
  final String dialCode;
  final String code;

  Country(this.name, this.dialCode, this.code);

  factory Country.fromJson(dynamic json) => Country(
        json['name'],
        json['dial_code'],
        json['code'],
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dial_code': dialCode,
      'code': code,
    };
  }
}
