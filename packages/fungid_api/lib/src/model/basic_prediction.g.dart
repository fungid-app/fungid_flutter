// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_prediction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BasicPrediction extends BasicPrediction {
  @override
  final String species;
  @override
  final num probability;

  factory _$BasicPrediction([void Function(BasicPredictionBuilder)? updates]) =>
      (new BasicPredictionBuilder()..update(updates))._build();

  _$BasicPrediction._({required this.species, required this.probability})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        species, r'BasicPrediction', 'species');
    BuiltValueNullFieldError.checkNotNull(
        probability, r'BasicPrediction', 'probability');
  }

  @override
  BasicPrediction rebuild(void Function(BasicPredictionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BasicPredictionBuilder toBuilder() =>
      new BasicPredictionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BasicPrediction &&
        species == other.species &&
        probability == other.probability;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, species.hashCode), probability.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BasicPrediction')
          ..add('species', species)
          ..add('probability', probability))
        .toString();
  }
}

class BasicPredictionBuilder
    implements Builder<BasicPrediction, BasicPredictionBuilder> {
  _$BasicPrediction? _$v;

  String? _species;
  String? get species => _$this._species;
  set species(String? species) => _$this._species = species;

  num? _probability;
  num? get probability => _$this._probability;
  set probability(num? probability) => _$this._probability = probability;

  BasicPredictionBuilder() {
    BasicPrediction._defaults(this);
  }

  BasicPredictionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _species = $v.species;
      _probability = $v.probability;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BasicPrediction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BasicPrediction;
  }

  @override
  void update(void Function(BasicPredictionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BasicPrediction build() => _build();

  _$BasicPrediction _build() {
    final _$result = _$v ??
        new _$BasicPrediction._(
            species: BuiltValueNullFieldError.checkNotNull(
                species, r'BasicPrediction', 'species'),
            probability: BuiltValueNullFieldError.checkNotNull(
                probability, r'BasicPrediction', 'probability'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
