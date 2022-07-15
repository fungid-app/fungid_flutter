// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_name.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CommonName extends CommonName {
  @override
  final String name;
  @override
  final String? language;
  @override
  final int id;
  @override
  final int speciesId;

  factory _$CommonName([void Function(CommonNameBuilder)? updates]) =>
      (new CommonNameBuilder()..update(updates))._build();

  _$CommonName._(
      {required this.name,
      this.language,
      required this.id,
      required this.speciesId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'CommonName', 'name');
    BuiltValueNullFieldError.checkNotNull(id, r'CommonName', 'id');
    BuiltValueNullFieldError.checkNotNull(
        speciesId, r'CommonName', 'speciesId');
  }

  @override
  CommonName rebuild(void Function(CommonNameBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommonNameBuilder toBuilder() => new CommonNameBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommonName &&
        name == other.name &&
        language == other.language &&
        id == other.id &&
        speciesId == other.speciesId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, name.hashCode), language.hashCode), id.hashCode),
        speciesId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CommonName')
          ..add('name', name)
          ..add('language', language)
          ..add('id', id)
          ..add('speciesId', speciesId))
        .toString();
  }
}

class CommonNameBuilder implements Builder<CommonName, CommonNameBuilder> {
  _$CommonName? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _language;
  String? get language => _$this._language;
  set language(String? language) => _$this._language = language;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _speciesId;
  int? get speciesId => _$this._speciesId;
  set speciesId(int? speciesId) => _$this._speciesId = speciesId;

  CommonNameBuilder() {
    CommonName._defaults(this);
  }

  CommonNameBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _language = $v.language;
      _id = $v.id;
      _speciesId = $v.speciesId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommonName other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CommonName;
  }

  @override
  void update(void Function(CommonNameBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CommonName build() => _build();

  _$CommonName _build() {
    final _$result = _$v ??
        new _$CommonName._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'CommonName', 'name'),
            language: language,
            id: BuiltValueNullFieldError.checkNotNull(id, r'CommonName', 'id'),
            speciesId: BuiltValueNullFieldError.checkNotNull(
                speciesId, r'CommonName', 'speciesId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
