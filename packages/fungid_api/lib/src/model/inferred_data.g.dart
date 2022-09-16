// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inferred_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InferredData extends InferredData {
  @override
  final int normalizedMonth;
  @override
  final String season;
  @override
  final int kg;
  @override
  final String? eluClass1;
  @override
  final String? eluClass2;
  @override
  final String? eluClass3;

  factory _$InferredData([void Function(InferredDataBuilder)? updates]) =>
      (new InferredDataBuilder()..update(updates))._build();

  _$InferredData._(
      {required this.normalizedMonth,
      required this.season,
      required this.kg,
      this.eluClass1,
      this.eluClass2,
      this.eluClass3})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        normalizedMonth, r'InferredData', 'normalizedMonth');
    BuiltValueNullFieldError.checkNotNull(season, r'InferredData', 'season');
    BuiltValueNullFieldError.checkNotNull(kg, r'InferredData', 'kg');
  }

  @override
  InferredData rebuild(void Function(InferredDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InferredDataBuilder toBuilder() => new InferredDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InferredData &&
        normalizedMonth == other.normalizedMonth &&
        season == other.season &&
        kg == other.kg &&
        eluClass1 == other.eluClass1 &&
        eluClass2 == other.eluClass2 &&
        eluClass3 == other.eluClass3;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, normalizedMonth.hashCode), season.hashCode),
                    kg.hashCode),
                eluClass1.hashCode),
            eluClass2.hashCode),
        eluClass3.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InferredData')
          ..add('normalizedMonth', normalizedMonth)
          ..add('season', season)
          ..add('kg', kg)
          ..add('eluClass1', eluClass1)
          ..add('eluClass2', eluClass2)
          ..add('eluClass3', eluClass3))
        .toString();
  }
}

class InferredDataBuilder
    implements Builder<InferredData, InferredDataBuilder> {
  _$InferredData? _$v;

  int? _normalizedMonth;
  int? get normalizedMonth => _$this._normalizedMonth;
  set normalizedMonth(int? normalizedMonth) =>
      _$this._normalizedMonth = normalizedMonth;

  String? _season;
  String? get season => _$this._season;
  set season(String? season) => _$this._season = season;

  int? _kg;
  int? get kg => _$this._kg;
  set kg(int? kg) => _$this._kg = kg;

  String? _eluClass1;
  String? get eluClass1 => _$this._eluClass1;
  set eluClass1(String? eluClass1) => _$this._eluClass1 = eluClass1;

  String? _eluClass2;
  String? get eluClass2 => _$this._eluClass2;
  set eluClass2(String? eluClass2) => _$this._eluClass2 = eluClass2;

  String? _eluClass3;
  String? get eluClass3 => _$this._eluClass3;
  set eluClass3(String? eluClass3) => _$this._eluClass3 = eluClass3;

  InferredDataBuilder() {
    InferredData._defaults(this);
  }

  InferredDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _normalizedMonth = $v.normalizedMonth;
      _season = $v.season;
      _kg = $v.kg;
      _eluClass1 = $v.eluClass1;
      _eluClass2 = $v.eluClass2;
      _eluClass3 = $v.eluClass3;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InferredData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InferredData;
  }

  @override
  void update(void Function(InferredDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InferredData build() => _build();

  _$InferredData _build() {
    final _$result = _$v ??
        new _$InferredData._(
            normalizedMonth: BuiltValueNullFieldError.checkNotNull(
                normalizedMonth, r'InferredData', 'normalizedMonth'),
            season: BuiltValueNullFieldError.checkNotNull(
                season, r'InferredData', 'season'),
            kg: BuiltValueNullFieldError.checkNotNull(
                kg, r'InferredData', 'kg'),
            eluClass1: eluClass1,
            eluClass2: eluClass2,
            eluClass3: eluClass3);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
