// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_prediction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FullPrediction extends FullPrediction {
  @override
  final String species;
  @override
  final num probability;
  @override
  final num localProbability;
  @override
  final num imageScore;
  @override
  final num tabScore;
  @override
  final num localScore;
  @override
  final bool isLocal;

  factory _$FullPrediction([void Function(FullPredictionBuilder)? updates]) =>
      (new FullPredictionBuilder()..update(updates))._build();

  _$FullPrediction._(
      {required this.species,
      required this.probability,
      required this.localProbability,
      required this.imageScore,
      required this.tabScore,
      required this.localScore,
      required this.isLocal})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        species, r'FullPrediction', 'species');
    BuiltValueNullFieldError.checkNotNull(
        probability, r'FullPrediction', 'probability');
    BuiltValueNullFieldError.checkNotNull(
        localProbability, r'FullPrediction', 'localProbability');
    BuiltValueNullFieldError.checkNotNull(
        imageScore, r'FullPrediction', 'imageScore');
    BuiltValueNullFieldError.checkNotNull(
        tabScore, r'FullPrediction', 'tabScore');
    BuiltValueNullFieldError.checkNotNull(
        localScore, r'FullPrediction', 'localScore');
    BuiltValueNullFieldError.checkNotNull(
        isLocal, r'FullPrediction', 'isLocal');
  }

  @override
  FullPrediction rebuild(void Function(FullPredictionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FullPredictionBuilder toBuilder() =>
      new FullPredictionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FullPrediction &&
        species == other.species &&
        probability == other.probability &&
        localProbability == other.localProbability &&
        imageScore == other.imageScore &&
        tabScore == other.tabScore &&
        localScore == other.localScore &&
        isLocal == other.isLocal;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, species.hashCode), probability.hashCode),
                        localProbability.hashCode),
                    imageScore.hashCode),
                tabScore.hashCode),
            localScore.hashCode),
        isLocal.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FullPrediction')
          ..add('species', species)
          ..add('probability', probability)
          ..add('localProbability', localProbability)
          ..add('imageScore', imageScore)
          ..add('tabScore', tabScore)
          ..add('localScore', localScore)
          ..add('isLocal', isLocal))
        .toString();
  }
}

class FullPredictionBuilder
    implements Builder<FullPrediction, FullPredictionBuilder> {
  _$FullPrediction? _$v;

  String? _species;
  String? get species => _$this._species;
  set species(String? species) => _$this._species = species;

  num? _probability;
  num? get probability => _$this._probability;
  set probability(num? probability) => _$this._probability = probability;

  num? _localProbability;
  num? get localProbability => _$this._localProbability;
  set localProbability(num? localProbability) =>
      _$this._localProbability = localProbability;

  num? _imageScore;
  num? get imageScore => _$this._imageScore;
  set imageScore(num? imageScore) => _$this._imageScore = imageScore;

  num? _tabScore;
  num? get tabScore => _$this._tabScore;
  set tabScore(num? tabScore) => _$this._tabScore = tabScore;

  num? _localScore;
  num? get localScore => _$this._localScore;
  set localScore(num? localScore) => _$this._localScore = localScore;

  bool? _isLocal;
  bool? get isLocal => _$this._isLocal;
  set isLocal(bool? isLocal) => _$this._isLocal = isLocal;

  FullPredictionBuilder() {
    FullPrediction._defaults(this);
  }

  FullPredictionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _species = $v.species;
      _probability = $v.probability;
      _localProbability = $v.localProbability;
      _imageScore = $v.imageScore;
      _tabScore = $v.tabScore;
      _localScore = $v.localScore;
      _isLocal = $v.isLocal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FullPrediction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FullPrediction;
  }

  @override
  void update(void Function(FullPredictionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FullPrediction build() => _build();

  _$FullPrediction _build() {
    final _$result = _$v ??
        new _$FullPrediction._(
            species: BuiltValueNullFieldError.checkNotNull(
                species, r'FullPrediction', 'species'),
            probability: BuiltValueNullFieldError.checkNotNull(
                probability, r'FullPrediction', 'probability'),
            localProbability: BuiltValueNullFieldError.checkNotNull(
                localProbability, r'FullPrediction', 'localProbability'),
            imageScore: BuiltValueNullFieldError.checkNotNull(
                imageScore, r'FullPrediction', 'imageScore'),
            tabScore: BuiltValueNullFieldError.checkNotNull(
                tabScore, r'FullPrediction', 'tabScore'),
            localScore: BuiltValueNullFieldError.checkNotNull(
                localScore, r'FullPrediction', 'localScore'),
            isLocal: BuiltValueNullFieldError.checkNotNull(
                isLocal, r'FullPrediction', 'isLocal'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
